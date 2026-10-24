# Settings: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/AutomatedWorkflow` | Workflow | [`AutomatedWorkflow2019`](#automatedworkflow2019) |
| `/MySubscription` | My subscription | [`MySubscription2019`](#mysubscription2019) |
| `/MySubscription/Marketplace` | Subscription configuration | [`MySubscriptionUpdateSubscriptionn2023`](#mysubscriptionupdatesubscriptionn2023) |
| `/NotificationSettings` | Automation | [`NotificationSettings2019`](#notificationsettings2019) |
| `/NotificationSettings/MailingList` | Mailing list | [`NotificationSettingsMailingList2019`](#notificationsettingsmailinglist2019) |
| `/NotificationSettings/Notifications` | Notification settings | [`NotificationSettingsNotifications2019`](#notificationsettingsnotifications2019) |
| `/PageAccess` | Users & Roles | [`PageAccess2019`](#pageaccess2019) |
| `/Settings` | Settings | [`Settings2019`](#settings2019) |
| `/TaskSettings` | Task settings | [`TaskSettings2019`](#tasksettings2019) |
| `/Template` | Manage report templates | [`Template2019`](#template2019) |
| `/TenantGeneralSettings` | General Settings | [`GeneralSettings2019`](#generalsettings2019) |
| `/TenantReminders` | Reminders | [`TenantReminders2019`](#tenantreminders2019) |
| `/UserProfile` | User profile | [`UserProfile2019`](#userprofile2019), [`PasskeyUserProfile2019`](#passkeyuserprofile2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/AutomatedWorkflow`: Workflow

Frame: `task-upload-frame`.

```text
link "Home"
link "Automation"
block #divList
  heading "Workflow list"
  button "Back"#backActionToAutomation
  button  primary
  input text#txtSearch placeholder "Type text to search"
  button "Search"#btnSearch primary
  select#cmbWorkflowStatusFilter: All | Active | Inactive
  label "Status"
  select#cmbWorkflowTypeFilter
  button #Grid_gridName_Options
  slot #divAutomatedWorkflowGrid
```

### `/MySubscription`: My subscription

Frame: `task-upload-frame`.

```text
link "Home"
heading "My subscription"
button "Update subscription"#btnDetailsUpdate primary
button "Switch to annual plan"#btnDetailsRenew primary
tabs#mySubscriptionsTabs: Subscription and onboarding details #subscriptionDetails | Payment history #paymentHistory | Referrals #referrals | Reset your account #resetAccount | Tax exemption #taxExemption
tab pane#subscriptionDetails
  heading "Subscription"
  block #spnBillingEmailAddress
  block #spnBillingAddress
  slot #btnChangeBillingAddress
  button "Add items" primary
  button "Add items" primary (hidden)
  button "Add items" primary (hidden)
  button "Add items" primary (hidden)
  button "Add items" primary (hidden)
  button "Add items" primary (hidden)
  button "Add items" primary (hidden)
  button "Add items" primary (hidden)
  button "Change payment method"#btnChangePaymentMethod primary
  heading "Onboarding package Buy onboarding package"
  table
  button "Request cancellation"
tab pane#paymentHistory
  heading "Payment history"
  text "Payment records made since inception. Click on an invoice number link to download an invoice for the required period."
  input text#txtPaymentHistorySearch placeholder "Type text to search"
  button "Search"#btnPaymentHistorySearch primary
  slot #divPaymentHistoryGrid
tab pane#referrals
  text "It is a win-win offer Refer someone who you think should be using Cin7 Core. When they sign up for an active subscriptio"
  button "Refer a friend"#refInviteClientsBtn primary
  text "ORShare the below referral code on social media"
  input text#refInvitationCodeInput read-only
  button "Copy"#refInvitationCodeBtn primary
  button "Share"
  button "Tweet"
  button "Share"
  heading "Referrals"
  input text#txtReferralsSearch placeholder "Type text to search"
  button "Search"#btnReferralsSearch primary
  slot #divReferralsGrid
tab pane#resetAccount
  heading "Transactional data reset"
  text "Use it to delete only transactional data, keeping your reference data. Purchases Sales Stock adjustments Stocktakes Stoc"
  text "It won't delete your: Products Suppliers Customers Integrations All reference data"
  button "Transactional data reset"#TransactionalDataReset
  heading "Full data reset"
  text "Use it to delete the transactional and reference data. Products Suppliers Customers Jobs Purchases Sales Stock adjustmen"
  text "It won't delete your: Data located in Settings -> Reference Books (except discounts and deals) Documents and templates"
  button "Full data reset"#FullDataReset
tab pane#taxExemption
  block #divUploadTaxExemptionCertificates
    heading "Add new tax exempt customer"
    select#taxExemption_Type: Resale | Non-profit | Government | Other
    input file#fileInput
    block #taxExemption_files
      table#FilesList
    input text#taxExemption_StartDate
    input text#taxExemption_ExpirationDate
    select#taxExemptionStates (56 options)
    input text#taxExemption_PermitNumber placeholder "Permit Number"
    button "Submit"#taxExemptionSubmit primary
form#frmDownloadInvoice
form#frmChangePaymentMethod
modal#dlgTransactionalDataReset small
  heading "Transactional data reset"
  button "×"
  label "Please type " " below" for #TransactionalDataResetConfirmation
  input text#TransactionalDataResetConfirmation
  label "Please re-enter your Cin7 Core password" for #TransactionalDataResetPassword
  input password#TransactionalDataResetPassword
  button "Confirm"#btnTransactionalDataResetConfirm
  button "Close"
modal#dlgFullDataReset small
  heading "Full data reset"
  button "×"
  label "Please type " " below" for #FullDataResetConfirmation
  input text#FullDataResetConfirmation
  label "Please re-enter your Cin7 Core password" for #FullDataResetPassword
  input password#FullDataResetPassword
  button "Confirm"#btnFullDataResetConfirm
  button "Close"
modal#divCancelSubscriptionDialog medium
  heading "Cancel Subscription"
  text "We are sorry to hear that you've decided to cancel your Cin7 Core subscription. To help us learn and improve, please tel"
  text "Why do you no longer need your Cin7 Core account?"
  input radio#rbReasons1 name=rbNoNeedReasons
  label "Business Strategic Changes" for #rbReasons1
  input radio#rbReasons2 name=rbNoNeedReasons
  label "Business Closure" for #rbReasons2
  input radio#rbReasons3 name=rbNoNeedReasons
  label "Outgrew Platform" for #rbReasons3
  input radio#rbReasons4 name=rbNoNeedReasons
  label "No Longer Need / Not Using It" for #rbReasons4
  input radio#rbReasons5 name=rbNoNeedReasons
  label "Too Expensive / Cost Too High" for #rbReasons5
  input radio#rbReasons6 name=rbNoNeedReasons
  label "Technical Issues - Integrations" for #rbReasons6
  input radio#rbReasons7 name=rbNoNeedReasons
  label "Technical Issues - Other (bugs, performance issues)" for #rbReasons7
  input radio#rbReasons8 name=rbNoNeedReasons
  label "Product Gaps (missing features, capabilities, or workflows)" for #rbReasons8
  input radio#rbReasons9 name=rbNoNeedReasons
  label "Bad Customer Support Experience" for #rbReasons9
  input radio#rbReasons10 name=rbNoNeedReasons
  label "Bad Onboarding Experience" for #rbReasons10
  input radio#rbReasons11 name=rbNoNeedReasons
  label "Too Difficult to Use" for #rbReasons11
  input radio#rbReasons12 name=rbNoNeedReasons
  label "Issue with Partner (third-party implementation or integration partner issue)" for #rbReasons12
  input radio#rbReasons13 name=rbNoNeedReasons
  label "Staying with Cin7 but replacing with a new account" for #rbReasons13
  text "Before you continue to cancel, is there more you'd like to tell us? We'll use your feedback to improve."
  textarea#tdCancellationReasonDescription placeholder "Enter your comments and feedback here..."
  form#frmCancelSubscription
  button "Don't cancel"
  button "Continue"#btnMySubscriptionReqCancellationScheduleCall
modal#divCancelSubscriptionAreYouSure small
  heading "Cancel subscription"
  button "×"
  text "Are you sure you want to cancel your subscription? You will no longer be able to access or use Cin7 Core features after "
  heading "Talk to someone."
  text "Our Customer Success team can help you with any concerns or problems you might be facing before canceling your subscript"
  button "Yes, arrange call back" primary
  button "No, cancel subscription"
modal#dlgCancelSubscription_ArrangeCallback small
  heading "Call back request"
  button "×"
  text "Please share your contact information and our Customer Success team will reach out within 1 business day."
  input text#tdArrangeCallback_ContactName
  label "Contact person name" for #tdArrangeCallback_ContactName
  input text#tdArrangeCallback_ContactNumber
  label "Contact number" for #tdArrangeCallback_ContactNumber
  input text#tdArrangeCallback_ContactEmail
  label "Contact email" for #tdArrangeCallback_ContactEmail
  button "Submit"#bArrangeCallback_Submit primary
  button "Close"
modal#dlgUpdateBillingAddress small
  heading "Update billing address"
  button "×"
  label "Billing email" for #SubscriptionBillingAddress
  input text#txtDlgBillingAddress
  label "Country" for #SubscriptionBillingCountry
  select#ddlBillingCountry (241 options)
  block #stateDropdownContainer
    label "State/province" for #SubscriptionBillingState
    select#ddlBillingState (57 options)
  block #stateTextBoxContainer
    label "State/province" for #SubscriptionBillingStatetTxt
    input text#txtDlgBillingState
  label "Street address" for #SubscriptionBillingStreet
  input text#txtDlgBillingStreet
  label "Apartment number" for #SubscriptionBillingAptNo
  input text#txtDlgBillingAptNo
  label "City" for #SubscriptionBillingCity
  input text#txtDlgBillingCity
  label "Zip/postal code" for #SubscriptionBillingZipCode
  input text#txtDlgBillingZipCode
  button "Update"#btnUpdateBillingAddress primary
  button "Close"
slot #fb-root
```

### `/MySubscription/Marketplace`: Subscription configuration

Redirects to `/MySubscription/UpdateSubscription`.

Frame: `task-upload-frame`.

```text
link "Home"
link "My subscription"
link "Subscription plan"
link "Onboarding package"
link "Marketplace"
link "Payment"
tab pane#divUpdateSubscriptionContainer
  slot #divPlanFeatures
  heading "Subscription"
  input checkbox#togglerPeriod
  block #divSelectedTotalTable
    text "Pro"#selectedPlan
    text "monthly"#selectedPeriod
    text "0"#selectPlanPrice
    block #divAddOns (hidden)
      text "0"#selectedFeaturesTotal
    text "month"#selectedTotalPeriod
  button "Continue"#btnSendSelectedFeatures primary
tab pane#divOnboardingContainer
  block #divOnboardingPackages
    block #divOBAccelerate
      button "Select" primary
    block #divOBFocused
      button "Select" primary
  block #divOBAddons
    heading "Additional 1:1 onboarding services"
    heading "Add guided assistance for as many Cin7 Core modules as you need"
    slot #divOnboardFeatures
  heading "Onboarding"
  block #divSelectedOnboardTotalTable (hidden)
    block #divSelectedOnboardingPlan (hidden)
      text "-"#selectedOnboardPlan
      block #divSelectedOnboradPrice
        text "0"#selectedOnboardPrice
    block #divOnboardAddOns (hidden)
      text "0"#selectedOnboardFeaturesTotal
    block #divSelectedOnboardTotalAmount
  text "No onboarding package or add-on selected"#pNoSelectedOnboardingPackages
  button "Continue to payment"#btnSendSelectedOnboarding primary
tab pane#divMarketplaceContainer
  heading "Marketplace"
  block #divSelectedMarketplaceTable
    slot #divMarketplaceSelectedFeatures
    block #divMarketplaceSelectedAddons (hidden)
    block #divSelectedMarketplaceTotalAmount (hidden)
    block #divMarketplaceAgreementEasyInsight (hidden)
      input checkbox#chkMarketplaceAgreementEasyInsight
      label "I agree to the &" for #chkMarketplaceAgreementEasyInsight
    block #divMarketplaceAgreementConverSight (hidden)
      input checkbox#chkMarketplaceAgreementConverSight
      label "I agree to the" for #chkMarketplaceAgreementConverSight
  button "Continue to payment"#btnSendSelectedMarketplace primary
tab pane#divPaymentContainer
  link "Find out more" (hidden)
  button "Back"#btnBacktoBilling (hidden)
  button "Back"#btnCardOnFileVerifyBack (hidden)
  slot #stepLine
  text "2"#step2
  block #divCardOnFileErrorBanner (hidden)
    slot #divCardOnFileErrorBannerTitle
    slot #divCardOnFileErrorBannerDetail
  slot #divCardOnFileInfoHint (hidden)
  block #divCardOnFileChargeContainer (hidden)
    heading "Charge card on file"
    text "Amount due:"#divCardOnFileAmountLine (hidden)
    button "Charge card on file"#btnCardOnFileContinue primary
  block #divCardOnFileVerifyScreen (hidden)
    block #divCardOnFileVerifyHeader
      heading "Verify it's you"
      text "Choose how you'd like to confirm this charge."
    slot #divCardOnFileMethods
    block #divCardOnFileTotpStep (hidden)
      text "Open your authenticator app (Google Authenticator, Authy, Microsoft Authenticator) and enter the 6-digit code for Cin7 C"#divCardOnFileTotpInstruction
      block #divCardOnFileTotpCode
        input text
        input text
        input text
        input text
        input text
        input text
      text "New code refreshes every 30 seconds in your app."#divCardOnFileTotpHint
      button "Verify and continue"#btnCardOnFileVerifyTotp primary
      button "Try a different method"#btnCardOnFileTryAnotherMethod
    text "Cin7 will never ask you for verification codes over phone, email, or chat."#divCardOnFileVerifyFooter
  block #divCardOnFileConfirmScreen (hidden)
    heading "Confirm your purchase"
    text "An invoice will be generated and marked as paid. Your new add-ons, packages, and integrations will be available immediat"
    button "Cancel"#btnCardOnFileCancel
    button "Confirm and charge"#btnCardOnFileConfirmCharge primary
  block #divCardOnFileSuccessScreen (hidden)
    heading "Addon activated"
    text "Your add-ons are now live on your account."
    text "Amount charged"
    slot #divCardOnFileSuccessAmount
    text "Card"
    slot #divCardOnFileSuccessCard
    text "Invoice"
    button "Go back to payments"#btnCardOnFileGoBack primary
    text "A receipt has been sent to your email. If a Co-owner initiated this charge, the Owner is also notified."
  block #divCardOnFileManualDivider (hidden)
  form#frmCyberSourcePayment
    slot #divCyberSourceBillingDetails
    block #divCardDeatailsContainer (hidden)
      heading "Pay now"#divManualPayNowOption
      label "Name on the card" for #ccFirstName
      input text#ccFirstName name=bill_to_forename
      label "Credit card number" for #ccNumber
      input text#ccNumber name=card_number
      label "Expiry date" for #ccNumber
      select#ccExpiryDateMonth
      select#ccExpiryDateYear
      label "Security code/CVV" for #ccNumber
      input text#ccCVV name=card_cvn
      slot #divSubmitPaymentCardHost
    slot #frmCyberSourcePaymentPaymentParam (hidden)
  block #divNoChanges (hidden)
    text "No changes were made to your current plan. Please move back and customize your plan."
  block #divZeroPayment (hidden)
    text "Your payment amount for this transaction is $0. You don't need to make any payment. Please continue to apply changes"
  block #divBankTransfer (hidden)
    slot #divBankTransferBillingDetails
    block #divBankTransferContainer
      text "Your bank invoice has been prepared. Please download it."
  block #divConfigureInvoice (hidden)
    text "Click 'Send invoice' to select a customer to send an invoice to."
  block #divShopify (hidden)
    slot #divShopifyBillingDetails
    block #divShopifyContainer (hidden)
      text "Click on the link and continue on Shopify side."
  heading #spnPaymentTitle
  slot #divPaymentTotalTable
  block #divContinueToPaymentContainer
    button "Continue to payment"#btnContinueToPayment primary
  block #divSubmitPaymentSidebarHost
    block #divSubmitPaymentContainer (hidden)
      button #btnSubmitPayment primary
  block #divTaxExemptionPrompt (hidden)
    text "Are you a tax-exempt organization? Upload your exemption certificate to get reimbursed for your subscription taxes."
modal#dlgMarketPlacePurchaseConditions medium
  heading "Purchase conditions"
  button "×"
  text "I understand and acknowledge that I am entering into an agreement with the third-party provider, that all support, servi"
block #divBillingDetailsContainer (hidden)
  heading "Billing contact"
  label "Bill to" for #txtBillingTo
  input text#txtBillingTo
  label "Billing email" for #billingEmailAddress
  input text#billingEmailAddress name=bill_to_email
  heading "Billing address"
  label "Country" for #billingAddressCountry
  select#billingAddressCountry
  label "State/province" for #billingAddressState
  block #stateTextBoxContainer
    input text#billingAddressState name=bill_to_address_state
  block #stateDropdownContainer
    select#cmbbillingAddressState
  label "Street address" for #billingAddressLine1
  input text#billingAddressLine1 name=bill_to_address_line1
  label "Apartment number" for #billingAddressLine2
  input text#billingAddressLine2 name=bill_to_address_line2
  label "City" for #billingAddressCity
  input text#billingAddressCity name=bill_to_address_city
  label "Zip/postal code" for #billingAddressPostCode
  input text#billingAddressPostCode name=bill_to_address_postal_code
```

### `/NotificationSettings`: Automation

Frame: `task-upload-frame`.

```text
link "Home"
button "Notification tutorial"
slot #FeatureModuleDetailsBlock (hidden)
text "Mailing list"
text "Notifications"
text "Report scheduling"
text "Reminders"
text "Workflow"
text "Task settings"
```

### `/NotificationSettings/MailingList`: Mailing list

Frame: `task-upload-frame`.

```text
link "Home"
link "Automation"
link "Mailing list"
block #divMainContent
  block #divMailingList
    heading "Mailing list"
    button "Back"#backActionToAutomation
    table#tblMailingListContainer: Name | Emails
    slot #divNotificationGroup
  block #divMailingListDetails (hidden)
    heading #spMailingListName
    button "Save"#saveAction1 primary
    button "Back"#backAction
    label "Name" for #MailingList_Name
    input text#MailingList_Name
    input checkbox#MailingList_Table
    text "Table"#lblMailingList_Table
    input checkbox#MailingList_List
    text "List"#lblMailingList_List
    block #divEmailsTableView (hidden)
      button  primary
      table#tblEmails: Email
    block #divEmailsRawView
      label "Please provide a comma-separated list of emails" for #MailingList_EmailsRaw
      slot #MailingList_EmailsRaw
```

### `/NotificationSettings/Notifications`: Notification settings

Frame: `emailContent`.

```text
link "Home"
link "Automation"
link "Notifications"
button "Back to list"#backToListAction (hidden)
block #divMainContent
  block #divNotificationList
    heading "Notifications"
    button "Back"#backAction
    table: Active | Name | Description
    slot #divNotificationGroup
  block #divNotificationDetails (hidden)
    heading "Notifications"#spDetailTitle
    block #toggle-active
      input checkbox#Notification_IsActive
    button "Save"#saveAction1 primary
    button "Reset to default"#resetToDefaultAction
    slot #Notification_Description
    block #divConditionRule
      heading "Condition rule"
      slot #Notification_ConditionText
    heading "Actions"
    block #divIsInternal
      input checkbox#Notification_IsInternal
    block #divIsEmail
      input checkbox#Notification_IsEmail
    block #divIsExternal
      input checkbox#Notification_IsExternal
    block #divPeriod
      label "Period"
      select#Notification_Period
    block #divStartExecutionDate
      label "Start execution date" for #Notification_StartExecutionDate
      slot #Notification_StartExecution_Date
      label "Start execution time" for #Notification_StartExecutionDate
      input text#Notification_StartExecution_Time
    block #divTemplateParameter
      heading "Parameters"
      slot #divTemplateParameterList
    block #divTemplateID
      label "Document template"
      select#Notification_TemplateID
    block #divDeliveryMethodsContent
      tabs: Internal #tab_Internal | Email #tab_Email | External #tab_External
      tab pane#tab_Internal
        block #divMessage
          label "Message template" for #Notification_Message
          textarea#Notification_Message
        block #divNotificationExecutionLogInternal
          heading "Internal execution log"
          slot #divExecutionLogInternal
      tab pane#tab_Email
        block #divAllActiveUser
          input checkbox#Notification_AllActiveUser
        block #divAllCompanyContact
          input checkbox#Notification_AllCompanyContact
        block #divMailingListIDs
          label "Select a mailing list"
          select#Notification_MailingListIDs multiple
        block #divCustomEmail
          label "BCC addresses"
          input text#Notification_CustomEmail
        block #divEmailSubject
          label "Email subject"
          input text#Notification_EmailSubject
        block #divSendToRelated
          input checkbox#Notification_SendToRelated
          text "Send to the related user"#lblNotification_SendToRelated
        block #divSendToSaleRep
          input checkbox#Notification_SendToSaleRep
          text "Send to sales rep"#lblNotification_SendToSaleRep
        block #divEmailTemplate
          heading "Email template"
          textarea#Notification_EmailTemplate
        block #divNotificationExecutionLogEmail
          heading "Email execution log"
          slot #divExecutionLogEmail
          block #email_note
          block #divEmailAddresses
            label "Recipients"
            slot #EmailAddresses
          block #divEmailSubjectLog
            label "Subject"
            slot #EmailSubject
          block #divEmailBody
            label "Content"
            slot #emailContent
          block #divEmailErrorMessage (hidden)
            label "Message"
            slot #emailErrorMessage
      tab pane#tab_External
        button #divNew primary
        slot #divExternalNotificationSettingsGrid
        block #divExternal_Url
          label "External URL"
          input text#Notification_ExternalUrl
        block #divNotification_IsExternalSettingActive
          input checkbox#Notification_IsExternalSettingActive
          text "Is active"#lblNotification_IsExternalSettingActive
        block #divExternal_AdditionalParameter
          heading "Additional parameters"
          tabs: Authorization #tabExternalAuthorization | Header #tabExternalHeader
          tab pane#tabExternalAuthorization
            block #divExternalAuthType
              select#Notification_ExternalAuthType: No auth | Basic auth | Bearer auth
              label "Authorization type" for #Notification_ExternalAuthType
            block #divExternal_AuthUsername (hidden)
              label "User name" for #Notification_AuthUserName
              input text#Notification_AuthUserName
            block #divExternal_AuthPassword (hidden)
              label "Password" for #Notification_AuthPassword
              input text#Notification_AuthPassword
            block #divExternal_AuthBearerToken (hidden)
              label "Token" for #Notification_AuthBearerToken
              input text#Notification_AuthBearerToken
          tab pane#tabExternalHeader
            button #divNew primary
            table#tblExternalHeader: Key | Value
        block #divNotificationExecutionLogExternal
          heading "External execution log"
          slot #divExecutionLogExternal
          block #external_note
          block #divExternalUrl
            label "URL"
            slot #ExternalUrl
          block #divExternalParameters
            label "Payload"
            slot #ExternalParameters
          block #divExternalErrorMessage
            label "Message"
            slot #ExternalErrorMessage
```

### `/PageAccess`: Users & Roles

Frame: `task-upload-frame`.

```text
link "Home"
link "Settings"
link "Users"
link "Roles"
tab pane#users
  block #PageAccess_Index_UsersPage
    block #divListUsers
      heading "Users"#formCaption
      button "Export users"#divExportUsers primary
      button "Invite a user"#divNewUser primary
      button "Invite an adviser"#divNewAdviser primary
      slot #PageAccess_Index_UsersContainer
    block #divDetailsUsers (hidden)
      heading #PageAccess_Index_CurrentUserEmail
      button "Lock user"#divLockUser
      button "Set as account owner"#divAssignMasterUser primary
      button "Unlock user"#divUnLockUser primary
      button "Save"#btnSaveUsers primary
      button "Cancel"#btnCancelUsers
      button "Back"#hideDetailsUsers
      block #PageAccess_Index_Message
      block #PageAccess_Index_EffectivePermissionLink
      block #PageAccess_Index_CoOwner
        input checkbox#chkCoOwner
        label "Co-owner" for #chkCoOwner
      slot #PageAccess_Index_RolesUsersContainer
      block #PageAccess_Index_PermissionsContainerUsers
        text "You are looking at the selected role permissions, information is read-only."
        slot #PageAccess_Index_PermissionsContainerUsersGrid
      slot #PageAccess_Index_EffectivePermission
tab pane#roles
  block #PageAccess_Index_RolesPage
    heading "Roles"
    block #PageAccess_Roles_PermissionsContainer2
      block #permissionsButtons2
        button "Full access"#setFullPermissionsOnRole primary
      block #permissionsButtons1
        button "Read-only access"#setReadonlyAccessOnRole primary
      button "Save"#btnSavePermissionsRole primary
      button "Cancel"#btnCancelPermissionsRole
    block #divDetailsRoles
      button "Add new role"#Roles_Add (hidden)
      slot #PageAccess_Index_RolesContainer
      text "Currently, there are no roles in this organization."#PageAccess_Roles_NoRoles
      block #PageAccess_Roles_PermissionsContainer
        slot #PageAccess_Index_PermissionsContainerRoles
      text "Please select a role to edit permissions."#PageAccess_Roles_PermissionHide
modal#PageAccess_NewUser_Content small
  heading "Invite a new user"
  button "×"
  text "Send an invitation to your colleague to join Cin7 Core"
  input text#tdPageAccess_NewUser_Email
  label "Email" for #tdPageAccess_NewUser_Email
  button "Send" primary
  button "Close"
block #emailReCaptcha (hidden)
modal#PageAccess_InviteAdviser_Content small
  heading "Invite an adviser"
  button "×"
  text "Send an invitation to an adviser to access your Cin7 Core account."
  text "Adviser must be a registered Cin7 Core Partner."
  input text#tdPageAccess_InviteAdviser_Email
  label "Email" for #tdPageAccess_InviteAdviser_Email
  button "Send" primary
  button "Close"
modal#dlgAddRoleToUser small
  heading "Add role"
  button "×"
  select#dlgAddRoleToUser_roles: Select a role
  label "Role" for #dlgAddRoleToUser_roles
  button "Save" primary
  button "Close"
modal#dlgAddUserToRole small
  heading "Add user"
  button "×"
  select#dlgAddUserToRole_users: Select a user
  label "User" for #dlgAddUserToRole_users
  button "Save" primary
  button "Close"
modal#dlgNewRole small
  heading "Add new role"
  button "×"
  input text#dlgNewRole_roleName
  label "Role name" for #dlgNewRole_roleName
  button "Save" primary
  button "Close"
```

### `/Settings`: Settings

Frame: `task-upload-frame`.

```text
link "Home"
block #dear-settings-block
  tabs: All #all | Your company #tab1 | Financial #tab2 | Default field values #tab3 | Other items #tab4 | Stock #tab5 | RMA #tab6 | CRM #tab7
  block #left-panes-col
    tab pane#tab1
      slot #linkTenantAddress_Index
      slot #linkTenantContact_Index
      slot #linkDearToDearNetworking_Index
    tab pane#tab2
      slot #linkChartOfAccounts_Index
      slot #linkBank_Index
      slot #linkAccountMapping_Index
      slot #linkOpeningBalances_Index
      slot #linkTenantTaxationRule_Index
      slot #linkTenantPaymentTerm_Index
      slot #linkFixedAsset_Index
      slot #linkExpenseItems_Index
      slot #linkAccountingDimensions_Settings
    tab pane#tab3
      slot #linkDefaultFieldValues_Product
      slot #linkDefaultFieldValues_Customer
      slot #linkDefaultFieldValues_Supplier
  block #right-panes-col
    tab pane#tab4
      slot #linkTenantCarrier_Index
      slot #linkTenantShipZone_Index
      slot #linkTenantAttributeSet_Index
      slot #linkMailingList_Index
    tab pane#tab5
      slot #linkTenantInventoryCategory_Index
      slot #linkTenantBrand_Index
      slot #linkTenantLocation_Index
      slot #linkOrderRouting_Index
      slot #linkTenantUnitOfMeasure_Index
      slot #linkDiscount_Index
      slot #linkDeal_Index
    tab pane#tab6
      slot #linkRMAReturnPolicy_Index
      slot #linkRMAReasonForReturn_Index
      slot #linkRMAReturnOrderSettings_Index
      slot #linkRMAWarrantySetup_Index
    tab pane#tab7
      slot #linkLeadStatus_Index
```

### `/TaskSettings`: Task settings

Frame: `task-upload-frame`.

```text
link "Home"
link "Automation"
heading "Task settings"
tabs#settingsTabs: Setup #tabSetup | Task categories #tabTaskCategories | Calendar #tabCalendar | Workflow #tabWorkflow | Assign and schedule tasks #tabCrmTasks
block #allPanes
  tab pane#tabSetup
    block #divTaskIsActive
      label "Tasks module is active" for #Task_IsActive
      input checkbox#Task_IsActive
    button "Save" primary
  tab pane#tabTaskCategories
    button #TaskCategory_btnAddNewTaskCategory primary
    button "Refresh"#TaskCategory_btnTaskCategoryRefresh
    slot #TaskCategory_divTaskCategoryGrid
    button "Save" primary
  tab pane#tabCalendar
    label "1st day of a week" for #Calendar_FirstDayOfWeek
    select#Calendar_FirstDayOfWeek: Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday
    label "Weekend days"
    input checkbox#Calendar_WeekDay_0
    label "Sunday" for #Calendar_WeekDay_0
    input checkbox#Calendar_WeekDay_1
    label "Monday" for #Calendar_WeekDay_1
    input checkbox#Calendar_WeekDay_2
    label "Tuesday" for #Calendar_WeekDay_2
    input checkbox#Calendar_WeekDay_3
    label "Wednesday" for #Calendar_WeekDay_3
    input checkbox#Calendar_WeekDay_4
    label "Thursday" for #Calendar_WeekDay_4
    input checkbox#Calendar_WeekDay_5
    label "Friday" for #Calendar_WeekDay_5
    input checkbox#Calendar_WeekDay_6
    label "Saturday" for #Calendar_WeekDay_6
    button "Add holiday"#Calendar_btnAddHoliday primary
    slot #Calendar_divHolidayGrid
    button "Save" primary
  tab pane#tabWorkflow
    block #divWorkflowList
      button #WorkflowList_btnAddNewWorkflow primary
      input text#WorkflowList_tbSearch name=divSearch placeholder "Type text to search"
      button "Search" primary
      select#WorkflowList_selStatus: All | Active | Inactive
      select#WorkflowList_selEntityType (22 options)
      button #WorkflowList_btnRefresh
      button #Grid_gridName_Options
      slot #WorkflowList_divWorkflowGrid
    block #divWorkflowEdit (hidden)
      heading "New workflow"
      button "Save"#Workflow_btnSave primary
      button "Back to list"#Workflow_btnBackToList primary
      block #divTaskIsActive
        label "Active" for #Workflow_IsActive
        input checkbox#Workflow_IsActive
      label "Workflow name" for #Workflow_tbName
      input text#Workflow_tbName placeholder "Enter a name"
      label "Applicable to *" for #Workflow_selEntityType
      select#Workflow_selEntityType (21 options)
      label "Due days are based on *" for #Workflow_selDueDaysType
      select#Workflow_selDueDaysType: Previous task completion date | Workflow start date
      label "A notification that can run this workflow" for #Workflow_selNotificationCanStart
      select#Workflow_selNotificationCanStart
      label "A notification that can stop this workflow" for #Workflow_selNotificationCanStop
      select#Workflow_selNotificationCanStop multiple
      button "Task"#Workflow_btnAddTask primary
      table: Task category | Due days | Skip | Start time | End time
  tab pane#tabCrmTasks
    input text#txbCrmSearch placeholder "Type text to search"
    button "Search"#btnCrmSearch primary
    label "From" for #dtFromList
    slot #divFromList
    label "To" for #dtToList
    slot #divToList
    label "Status" for #cmbStatus
    select#cmbStatus
    label "User" for #cmbTenantUsers
    slot #divTenantUsers
    button #CrmbtnRefresh
    heading "Manage"
    table
    slot #TaskList_Container
modal#WorkflowList_activeProcessModal medium
  heading "Active processes"
  button 
  slot #WorkflowList_activeProcessGrid
  button "Close"
```

### `/Template`: Manage report templates

Frame: `task-upload-frame`.

```text
link "Home"
link "Settings"
text "Manage document templates and emails to apply a unique look and feel."
text "Download any report template as MS Word document, modify it as you like, keeping mail merge fields in it. Then upload it"
button "List of available mail merge fields" primary
tabs: Purchase #purchase | Sale #sale | Inventory #inventory | POS #pos | Production #production | CRM #crm | Financial #financial
tab pane#purchase
  slot #divPURCHASE
tab pane#sale
  slot #divSALE
tab pane#inventory
  slot #divINVENTORY
tab pane#pos
  slot #divPOS
tab pane#production
  slot #divPRODUCTION
tab pane#crm
  slot #divCRM
tab pane#financial
  slot #divFINANCIAL
modal#divEditTemplateDialog medium
  heading "Change template"
  button "×"
  button "Download template"#divDownloadTemplate primary
  button "Download email"#divDownloadEmail primary
  button "Reset"#divReset
  button "Delete"#divDelete
  form#frmEditTemplate
    select#tdTypeEdit name=TypeEdit
    label "Template type"
    input text#tdNameEdit name=NameEdit placeholder "Enter a template name"
    label "Template name"
    select#tdcmbMultilingualTemplateEdit name=multilingualTemplateEditId
    label "Language template"
    input file#file_upload_edit name=FileUploadEdit (hidden)
    input text read-only
    button "Browse" primary
    label "Choose a document template"
    input text#tdEmailSubjectEdit name=EmailSubjectEdit placeholder "Enter an email subject"
    label "Email subject"
    input file#email_upload_edit name=EmailUploadEdit (hidden)
    input text read-only
    button "Browse" primary
    label "Choose an email template"
    text "Configure email recipients"
    input checkbox#Template_AllActiveUserEdit
    label "All active users" for #Template_AllActiveUserEdit
    input checkbox#Template_AllCompanyContactEdit
    label "All company contacts" for #Template_AllCompanyContactEdit
    select#Template_MailingListIDsEdit multiple
    label "Select a mailing list"
    input text#Template_CustomEmailEdit
    label "BCC addresses"
    input checkbox#Template_SendToCustomerEdit
    label "Send to the customer" for #Template_SendToCustomerEdit
    input checkbox#Template_SendToSupplierEdit
    label "Send to the supplier" for #Template_SendToSupplierEdit
    input checkbox#Template_SendToSaleRepEdit
    label "Send to sales rep" for #Template_SendToSaleRepEdit
  button "Save" primary
  button "Close"
modal#divAddTemplateDialog medium
  heading "Add a new template"
  button "×"
  form#frmNewTemplate
    select#tdTypeNew name=TypeNew
    label "Template type"
    input text#tdNameNew name=NameNew placeholder "Enter a template name"
    label "Template name"
    select#tdcmbMultilingualTemplateNew name=multilingualTemplateNewId
    label "Language template"
    input file#file_upload_new name=FileUploadNew (hidden)
    input text read-only
    button "Browse" primary
    label "Choose a document template"
    input text#tdEmailSubjectNew name=EmailSubjectNew placeholder "Enter an email subject"
    label "Email subject"
    input file#email_upload_new name=EmailUploadNew (hidden)
    input text read-only
    button "Browse" primary
    label "Choose an email template"
    text "Configure email recipients"
    input checkbox#Template_AllActiveUserNew
    label "All active users" for #Template_AllActiveUserNew
    input checkbox#Template_AllCompanyContactNew
    label "All company contacts" for #Template_AllCompanyContactNew
    select#Template_MailingListIDsNew multiple
    label "Select a mailing list"
    input text#Template_CustomEmailNew
    label "BCC addresses"
    input checkbox#Template_SendToCustomerNew
    label "Send to the customer" for #Template_SendToCustomerNew
    input checkbox#Template_SendToSupplierNew
    label "Send to the supplier" for #Template_SendToSupplierNew
    input checkbox#Template_SendToSaleRepNew
    label "Send to sales rep" for #Template_SendToSaleRepNew
  button "Save" primary
  button "Close"
```

### `/TenantGeneralSettings`: General Settings

Frame: `task-upload-frame`.

```text
link "Home"
link "Settings"
button "Save"#divSaveChanges2 primary
button "Activity log"#ActivityLogsLink
tabs#settingsTabs: All settings #tabAll | Organization #tab1 | Security settings #tab2 | Financial settings #tab3 | Product and measurements settings #tab4 | Purchase process customization #tab5 | Sale process customization #tab6 | Production process customization #tab7 | Rounding table #tab8 | Sale price tier names #tab9 | Document numbering #tab10 | Multilingual support #tab11 | Gift card settings #tab12 | Tooltip settings #tab13 | CRM #tab14 | MRP #tab15
block #allPanes
  tab pane#tab1
    label "Legal/trading Name" for #TenantGeneralSettings_Index_Company
    input text#TenantGeneralSettings_Index_Company placeholder "Legal/trading Name"
    text "Official name to appear on documents."
    label "Country" for #TenantGeneralSettings_Index_Country
    input text#TenantGeneralSettings_Index_Country placeholder "Country"
    label "Base currency" for #TenantGeneralSettings_Index_Currency
    select#TenantGeneralSettings_Index_Currency
    text "Choose your company's main operating currency."
    label "Time zone"
    select#timeZoneComboBox
    text "Specify your time zone."
    label "Date format"
    select#TenantGeneralSettings_Index_DateFormat: dd/MM/yyyy | MM/dd/yyyy | yyyy/MM/dd
    label "Send e-mails from"
    select#TenantGeneralSettings_Index_EmailSender: Company's billing contact | Currently logged-in user | Company's billing contact [sent from the system] | Currently logged-in user [sent from the system]
    text "Choose which sender address will be used to send email from Cin7 Core."
    label "Add email sender to CC"
    select#TenantGeneralSettings_Index_AddEmailSenderToCC: Add sender to CC | Do not add sender to CC
    text "Send a copy of an email to the email sender as a reference."
    label "Global BCC address"
    input text#TenantGeneralSettings_Index_GlobalBCC placeholder "Global BCC address"
    text "BCC email address for all emails sent from purchases and sales for correspondence records."
    label "Email read receipts"
    input radio#TenantGeneralSettings_Index_RequestMailReceipt_true name=TenantGeneralSettings_Index_RequestMailReceipt
    label "Required" for #TenantGeneralSettings_Index_RequestMailReceipt_true
    input radio#TenantGeneralSettings_Index_RequestMailReceipt_false name=TenantGeneralSettings_Index_RequestMailReceipt
    label "Not required" for #TenantGeneralSettings_Index_RequestMailReceipt_false
    text "Request receipt confirmation for emails."
    label "Open details in"
    input radio#TenantGeneralSettings_Index_OpenDetailsInNewTabs_true name=TenantGeneralSettings_Index_OpenDetailsInNewTabs
    label "New tab" for #TenantGeneralSettings_Index_OpenDetailsInNewTabs_true
    input radio#TenantGeneralSettings_Index_OpenDetailsInNewTabs_false name=TenantGeneralSettings_Index_OpenDetailsInNewTabs
    label "Same tab" for #TenantGeneralSettings_Index_OpenDetailsInNewTabs_false
    text "Purchases, sales or any other task can be opened in the same window/tab or in a new tab when selected from a list."
    label "Purchase and sale headers"
    input radio#TenantGeneralSettings_Index_HeadersVisible_true name=TenantGeneralSettings_Index_HeadersVisible
    label "Visible" for #TenantGeneralSettings_Index_HeadersVisible_true
    input radio#TenantGeneralSettings_Index_HeadersVisible_false name=TenantGeneralSettings_Index_HeadersVisible
    label "Hidden" for #TenantGeneralSettings_Index_HeadersVisible_false
    text "Purchase or sale headers can be visible or hidden by default when opening an existing task."
    label "Export CSV file encoding"
    select#TenantGeneralSettings_Index_ExportEncoding: ASCII | Unicode
    text "Use either ASCII or Unicode (UTF-8) encoding when exporting data from Cin7 Core as CSV files."
    label "Tax calculation method"
    select#TenantGeneralSettings_Index_TaxCalculationMethod: Row total | Document total
    text "Calculate tax amounts based on row totals or document totals."
    text "Document total tax calculation method is not compatible with Xero. You may have a discrepancy between the original Cin7 "#trXeroTaxMethodWarning (hidden)
    text "Document total tax calculation method is not compatible with QuickBooks Online Global. You may have a discrepancy betwee"#trQBGlobalTaxMethodWarning (hidden)
    text "Row total tax calculation method is not compatible with QuickBooks Online US. You may have a discrepancy between the ori"#trQBUSTaxMethodWarning (hidden)
    label "Max. decimal places in documents"
    select#TenantGeneralSettings_Index_DecimalPlaces: No decimal places | 1 decimal place | 2 decimal places | 3 decimal places | 4 decimal places
    text "Select the maximum no. of decimal places displayed on printable documents"
    label "Credit hold grace period"
    input text#TenantGeneralSettings_Index_CreditHoldGracePeriod
    text "Number of days before automatic credit hold is applied to customers."
    label "Charge card on file" for #TenantGeneralSettings_Index_AllowChargeToCardOnFile
    input checkbox#TenantGeneralSettings_Index_AllowChargeToCardOnFile
    text "Allow the owner and co-owners to charge new add-ons, packages, or integrations to the card on file."
    text "Only the account Owner can change this setting."#TenantGeneralSettings_Index_AllowChargeToCardOnFile_OwnerOnlyHint (hidden)
  tab pane#tab2
    label "Password change frequency"
    select#TenantGeneralSettings_Index_PasswordChangeFrequency: Never | Every month | Every 3 months | Every 6 months | Every year
    text "Force user password changes on regular basis"
    label "Session timeout"
    select#TenantGeneralSettings_Index_SessionTimeout: 12 hours | 60 minutes | 30 minutes | 20 minutes | 10 minutes | 5 minutes
    text "Your session will expire after 60 minutes of inactivity."#txtSessionTimeoutHint
  tab pane#tab3
    block #financialSettings
      block #liFinancialYearEnd
        label "Financial year end"
        select#TenantGeneralSettings_Index_FinancialYearEndDay (31 options)
        select#TenantGeneralSettings_Index_FinancialYearEndMonth: January | February | March | April | May | June | July | August | September | October | November | December
        text "This field is for recording purposes only. It does not affect any system functionality."
      label "Tax calculation basis"
      select#TenantGeneralSettings_Index_TaxCalculationBasis
      text "This field is for recording purposes only. It does not affect any system functionality."
      block #liTaxPeriod
        label "Tax period"
        select#TenantGeneralSettings_Index_TaxPeriod
        text "This field is for recording purposes only. It does not affect any functionality."
      block #liTaxNumber
        label "Tax ID number"
        input text#TenantGeneralSettings_Index_TaxNumber placeholder "Tax ID number"
        text "This field is for recording purposes only. It does not affect any functionality."
      block #liTaxNumberDisplayName
        label "Tax ID display name"
        input text#TenantGeneralSettings_Index_TaxNumberDisplayName placeholder "Tax ID display name"
        text "This field is for recording purposes only. It does not affect any functionality."
      block #liReverseCurrentYearDepreciation
        label "Reverse current year depreciation"
        input radio#TenantGeneralSettings_Index_ReverseCurrentYearDepreciationWhenAssetsAreSold_true name=TenantGeneralSettings_Index_ReverseCurrentYearDepreciationWhenAssetsAreSold
        label "Yes" for #TenantGeneralSettings_Index_ReverseCurrentYearDepreciationWhenAssetsAreSold_true
        input radio#TenantGeneralSettings_Index_ReverseCurrentYearDepreciationWhenAssetsAreSold_false name=TenantGeneralSettings_Index_ReverseCurrentYearDepreciationWhenAssetsAreSold
        label "No" for #TenantGeneralSettings_Index_ReverseCurrentYearDepreciationWhenAssetsAreSold_false
        text "Reverse depreciation calculated for the sold or disposed fixed assets in the current financial year. This option can be "
      label "Unrealized foreign currency exchange adjustment" for #TenantGeneralSettings_Index_UnrealizedForeignCurrency
      input checkbox#TenantGeneralSettings_Index_UnrealizedForeignCurrency
      text "When enabled, the unrealized foreign currency exchange adjustment calculation and journal creation are made automaticall"
      label "Carry forward P&L calculation" for #TenantGeneralSettings_Index_CarryForward
      input checkbox#TenantGeneralSettings_Index_CarryForward
      text "When enabled, the carry forward P&L calculation and journal creation are made automatically when closing financial perio"
    block #periodLockDateBlock
      label "Period lock date"
      input text#TenantGeneralSettings_Index_LockDate
      text "Lock dates stop data from being changed for a specific period. You can change these at any time."
    block #ChartOfAccountsTypeSetting
      label "Chart of accounts type" for #ChartOfAccountsType
      select#ChartOfAccountsType: Flat structure | Tree structure
      text "Tree structure allows subaccounts within the chart of accounts. Flat structure does not allow subaccounts."
    block #ChartOfAccountsTreeDelimiterSetting
      label "Account code delimiter" for #ChartOfAccountsTreeDelimiter
      input text#ChartOfAccountsTreeDelimiter placeholder "Account code delimiter"
      text "Default account code delimiter. Subaccounts will be created using account code delimiter. Disallowed symbols: ."
    label "Accounting dimensions" for #TenantGeneralSettings_Index_IsAccountingDimensionsEnabled
    input checkbox#TenantGeneralSettings_Index_IsAccountingDimensionsEnabled
    text "Allow accounting dimensions for financial transactions. WARNING: Enabling accounting dimensions can cause tasks to save "
    block #AccountingDimensionsPriorityMode
      label "Reference data priority" for #TenantGeneralSettings_Index_AccountingDimensionsPriorityMode
      select#TenantGeneralSettings_Index_AccountingDimensionsPriorityMode: Can overwrite reference data. | Cannot overwrite reference data.
      text "Some accounting dimensions use reference data as default values. 'Can overwrite reference data' is selected dimension va"
  tab pane#tab4
    label "Weight units of measure"
    select#TenantGeneralSettings_Index_WeightUnits
    text "Select default weight units of measure for new products."
    label "Dimensions units of measure"
    select#TenantGeneralSettings_Index_DimensionsUnits
    text "Select default units of measure for height, weight, and length of new products."
    label "SKU auto generation"
    input checkbox#TenantGeneralSettings_Index_SkuAutogeneration
    text "Automatically generate SKUs for a product, service, or fixed asset upon creation. Existing SKUs won't be affected. SKU a"
    block #productNumberFormat (hidden)
      table: Product type | Prefix | Next number | Suffix
    label "Update stock received date with transfer completion date"
    input checkbox#TenantGeneralSettings_Index_UpdateStockReceivedDateOnLocationTransfer
    text "When enabled, stock received date for stock transferred between locations will be updated with stock transfer completion"
    label "Recommend batch/serial no. for FIFO/FEFO"
    select#TenantGeneralSettings_Index_RecommendBatchSN: Don't recommend | Recommend and warn | Recommend and enforce
    text "Upon pick authorization, recommend first in/first expired batch/serial numbers if these are not picked."
    label "Exclude expired batch/serial numbers"
    input checkbox#TenantGeneralSettings_Index_IgnoreExpiredBatch
    text "Exclude expired batch/serial numbers from system actions such as pick recommend, auto-pick, and auto-consume."
    label "New product description prompt"
    textarea#TenantGeneralSettings_Index_ChatGptPromptForEmptyDescription
    text "This AI (ChatGPT) prompt will be used to generate a new product description. Keywords are [ProductName], [ForBrand], [Fo"
    label "Rephrase product description prompt"
    textarea#TenantGeneralSettings_Index_ChatGptPromptForExistingDescription
    text "This AI (ChatGPT) prompt will be used to rephrase an existing product description. Keywords are [ProductName], [ProductD"
  tab pane#tab5
    label "Default purchase method"
    select#TenantGeneralSettings_Index_DefaultPurchaseMethod: Invoice first | Stock first
    text "Control whether purchases are processed stock first or invoice first by default."
    label "Purchase order will use"
    select#TenantGeneralSettings_Index_PurchaseCost: Latest supplier price | Fixed supplier price
    text "Control which supplier price will appear on a purchase order/invoice by default after product selection."
    label "Purchase documents"
    select#TenantGeneralSettings_Index_PurchaseDocumentSortOrder: Sorted by order entered | Sorted by SKU | Sorted by product name
    text "Customize the sorting order for purchase orders, stock received, and invoice documents (PDF and printed documents only)."
    label "Minimum before reorder set for"
    select#TenantGeneralSettings_Index_ReorderMode: All product units | Each location
    text "Minimum before reorder threshold can be set for the sum of all product units across all locations or in each location."
    label "Default attribute set"
    select#TenantGeneralSettings_Index_Purchase_combobox
    text "Extend the default list of the parameters associated with the purchase by adding extra (maximum 10) fields relevant to y"
    label ""
    input checkbox#TenantGeneralSettings_Index_PurchaseAttributeSetCopyFromChk
    text "Copy supplier attribute values to purchase attribute fields"
    select#TenantGeneralSettings_Index_PurchaseAttributeSetCopyFrom
    label "Limit product search by supplier"
    input checkbox#TenantGeneralSettings_Index_SearchOnlySupplierAttachedProductsInPurchaseLines
    text "Limit product search for purchase orders to products sold by selected supplier. Otherwise, all products can be searched."
    label "Use put away"
    input checkbox#TenantGeneralSettings_Index_UsePurchasePutAway
    text "Divide stock receiving process into two sections - receiving and put away."
    label "Enable accrued inventory transactions"
    input checkbox#TenantGeneralSettings_Index_InventoryAccrual
    text "Generate extra transactions to support GRNI (Goods Received Not Invoiced) and GINR (Goods Invoiced Not Received) scenari"
    block #liInventoryAccrualAccount
      label "Goods received not invoiced account"
      select#TenantGeneralSettings_Index_InventoryAccrualAccount
      text "Required for stock first scenario. The cost of goods received is defined either by a purchase order price or (if a purch"
    block #liStockInTransitAccount
      label "Goods invoiced not received account"
      select#TenantGeneralSettings_Index_StockInTransitAccount
      text "Required for invoice first scenario to record the cost of inventory in transit."
    label "Enable archiving"
    input checkbox#TenantGeneralSettings_Index_AllowArchiving2
    text "Allow archiving of sale quotes/purchase orders."
    label "Archive purchase orders older than"
    select#TenantGeneralSettings_Index_PurchaseOrderArchivePeriod: Do not archive | 3 months | 6 months | 1 year
    text "Draft purchase orders will be archived automatically after this period."
    label "Enable order approval"
    input checkbox#TenantGeneralSettings_Index_AllowPurchaseOrderApproval
    text "Purchase orders must be approved before authorization."
    label "Default load advance purchase order"
    input checkbox#TenantGeneralSettings_Index_IsDefaultAdvancedPurchase
    text "New purchase orders will be advanced purchase by default instead of simple purchase."
    label "Add existing attachments to emails"
    input checkbox#TenantGeneralSettings_Index_Purchase_AddExistingAttachmentsIntoTheEmail
    text "Enable adding multiple attachments related to 'products' and 'suppliers' to emails."
  tab pane#tab6
    label "Assign invoice number"
    select#TenantGeneralSettings_Index_InvoiceNumberTimePoint: On sale creation | On invoice authorization
    text "Invoice numbers can be assigned to the sale as soon as a sale is created, or postponed until an invoice is authorized."
    label "Default sale tax rule"
    select#TenantGeneralSettings_Index_TaxationRule
    text "Tax rule selected by default when creating new customers."
    label "Available quantity is limited to"
    select#TenantGeneralSettings_Index_PickFromAllLocations: All locations | Selected location only
    text "When selling, available stock quantity is calculated either in all locations or only the location selected in the sale. "
    label "On order authorization auto-assemble"
    select#TenantGeneralSettings_Index_FGProduce: Quantity required | Quantity required and maintain minimum stock level quantity | Difference between available quantity and quantity required to cover a shortage
    label "Split auto-assembly products in sale orders"
    input checkbox#TenantGeneralSettings_Index_Sale_SplitAutoAssembly
    text "When split order is executed for sale order which contains an auto-assembly product, if not enough stock is available th"
    label "Sale documents"
    select#TenantGeneralSettings_Index_DocumentSortOrder: Sorted by screen order | Sorted in alphabetical order | Sorted by SKU | Sorted by stock locator, custom attributes and screen order
    text "Customize the sorting order of products in quotes, orders, pick/pack slips and invoices. Cin7 Core will either keep the "
    label "Set invoice date"
    select#TenantGeneralSettings_Index_FillInvoiceDateOnOrderAuthorisation: When invoice authorized | When order authorized | When shipment authorized
    text "Auto-fill invoice date upon sale order authorization, invoice authorization or shipment authorization."
    label "Default invoice date"
    select#TenantGeneralSettings_Index_FillInvoiceDateOption: Current date | Sale order date | Sale shipment date
    text "Auto-fill the invoice date with current date, use the sale order date or use the sale shipment date."
    label "Default shipment date"
    select#TenantGeneralSettings_Index_DefaultShipDate: Invoice date | Current date
    text "COGS transactions use the shipment date. Autofill the shipment date with current date or use the invoice date."
    label "By default, quote is"
    input radio#TenantGeneralSettings_Index_SkipQuote_true name=TenantGeneralSettings_Index_SkipQuote
    label "Skipped" for #TenantGeneralSettings_Index_SkipQuote_true
    input radio#TenantGeneralSettings_Index_SkipQuote_false name=TenantGeneralSettings_Index_SkipQuote
    label "Visible" for #TenantGeneralSettings_Index_SkipQuote_false
    text "Quotes can be skipped by default for a new sale task."
    label "Picking is"
    input radio#TenantGeneralSettings_Index_AutoPick_true name=TenantGeneralSettings_Index_AutoPick
    label "Automatic" for #TenantGeneralSettings_Index_AutoPick_true
    input radio#TenantGeneralSettings_Index_AutoPick_false name=TenantGeneralSettings_Index_AutoPick
    label "Manual" for #TenantGeneralSettings_Index_AutoPick_false
    text "Pick will be auto-completed for sale tasks upon order authorization if there is sufficient quantity on hand if 'Automati"
    label "Packing is"
    input radio#TenantGeneralSettings_Index_AutoPack_true name=TenantGeneralSettings_Index_AutoPack
    label "Automatic" for #TenantGeneralSettings_Index_AutoPack_true
    input radio#TenantGeneralSettings_Index_AutoPack_false name=TenantGeneralSettings_Index_AutoPack
    label "Manual" for #TenantGeneralSettings_Index_AutoPack_false
    text "Pack will be auto-completed upon pick authorization if 'Automatic' is selected. Otherwise, pack must be filled and autho"
    label "Shipping is"
    input radio#TenantGeneralSettings_Index_SkipShip_true name=TenantGeneralSettings_Index_SkipShip
    label "Automatic" for #TenantGeneralSettings_Index_SkipShip_true
    input radio#TenantGeneralSettings_Index_SkipShip_false name=TenantGeneralSettings_Index_SkipShip
    label "Manual" for #TenantGeneralSettings_Index_SkipShip_false
    text "Ship will be auto-completed upon pack authorization if 'Automatic' is selected. Otherwise, ship must be filled and autho"
    label "Customer credit limit"
    select#TenantGeneralSettings_Index_CustomerCreditLimit: Shows a warning when exceeded | Stops processing when exceeded
    text "Show a warning message when a customer credit limit violation is detected or stop sale processing entirely."
    label "Discount rule"
    select#TenantGeneralSettings_Index_DiscountCalculationMethod: Updates the sale price | Updates discount %
    text "Process any available discount by either amending the sale price of the item or recalculating the discount % in the sale"
    label "Automatically apply discounts and deals"
    input checkbox#TenantGeneralSettings_Index_AutomaticallyApplyDiscounts
    text "Automatically apply applicable discounts and deals upon sale authorization."
    block #TenantGeneralSettings_Index_AutomaticallyApplyDiscounts_Note (hidden)
      text "Enabling automatic application of discounts and deals will disable manual price overriding on sale quotes and orders."
    block #dvAllowManualPriceChanges
      label "Allow manual price overriding on sale quotes and orders"
      input checkbox#TenantGeneralSettings_Index_ApplyManualChanges
      text "Allow manual price overriding on sale quotes and orders for products without discounts or deals."
      block #TenantGeneralSettings_Index_ApplyManualChanges_Note (hidden)
        text "Enabling this will allow manual price overriding on sale quotes and orders for non discounted or dealed products."
    label "Apply customer discount after other discounts"
    input checkbox#TenantGeneralSettings_Index_ApplyCustomerDiscountAfterOtherDiscounts
    text "In some scenarios, the seller wants to add an extra discount to the selected customers despite the fact that product rel"
    label "Recurring invoice price"
    select#TenantGeneralSettings_Index_RecurringInvoicePriceHandlingMethod: Copy previous price | Use product price
    text "Recurring invoices can either automatically copy the prices from a previous invoice or use the current product price (fr"
    label "Default attribute set"
    select#TenantGeneralSettings_Index_Sale_combobox
    text "Extend the default list of the parameters associated with the sale by adding extra (maximum 10) fields relevant to your "
    label ""
    input checkbox#TenantGeneralSettings_Index_SaleAttributeSetCopyFromChk
    text "Copy customer attribute values to sale attribute fields"
    select#TenantGeneralSettings_Index_SaleAttributeSetCopyFrom
    label "Show invoice tab before fulfillment tab"
    input radio#TenantGeneralSettings_Index_SaleShowInvoiceFirst_true name=TenantGeneralSettings_Index_SaleShowInvoiceFirst
    label "Invoice first" for #TenantGeneralSettings_Index_SaleShowInvoiceFirst_true
    input radio#TenantGeneralSettings_Index_SaleShowInvoiceFirst_false name=TenantGeneralSettings_Index_SaleShowInvoiceFirst
    label "Fulfillment first" for #TenantGeneralSettings_Index_SaleShowInvoiceFirst_false
    text "Adjust sale workflow steps to reflect your sale process."
    block #liSaleNoAlloc
      label "Make stock allocation optional"
      input radio#TenantGeneralSettings_Index_SaleNoAlloc_true name=TenantGeneralSettings_Index_SaleNoAlloc
      label "Optional" for #TenantGeneralSettings_Index_SaleNoAlloc_true
      input radio#TenantGeneralSettings_Index_SaleNoAlloc_false name=TenantGeneralSettings_Index_SaleNoAlloc
      label "Mandatory" for #TenantGeneralSettings_Index_SaleNoAlloc_false
      text "When 'Optional', sale orders can be authorized with or without stock allocation. Stock will instead be allocated upon pi"
    label "Enable archiving"
    input checkbox#TenantGeneralSettings_Index_AllowArchiving
    text "Allow archiving of sale quotes/purchase orders."
    label "Archive sale quotes older than"
    select#TenantGeneralSettings_Index_SaleQuoteArchivePeriod: Do not archive | 3 months | 6 months | 1 year
    text "Draft sale quotes will be archived automatically after this period."
    label "Default new line quantity"
    input text#TenantGeneralSettings_Index_DefaultQuantity
    text "Default quantity value to when adding new empty lines to sale."
    label "Enable quote approval"
    input checkbox#TenantGeneralSettings_Index_AllowQuoteApproval
    text "Sale quotes must be approved before authorization."
    label "Default load advance sale order"
    input checkbox#TenantGeneralSettings_Index_IsDefaultAdvancedSale
    text "New sale orders will be advanced sale by default instead of simple sale."
    label "Add existing attachments to emails"
    input checkbox#TenantGeneralSettings_Index_Sale_AddExistingAttachmentsIntoTheEmail
    text "Enable adding multiple attachments related to 'products' and 'customers' to emails"
    label "Default sales rep is user creating the sale"
    input checkbox#TenantGeneralSettings_Index_Sale_UseCurrentUserAsSaleRep
    text "User creating the sale will be sales rep by for all new sale orders."
  tab pane#tab7
    label "Stock transfer is"
    input radio#TenantGeneralSettings_Index_MOIsStockTransferAuto_true name=TenantGeneralSettings_Index_MOIsStockTransferAuto
    label "Automatic" for #TenantGeneralSettings_Index_MOIsStockTransferAuto_true
    input radio#TenantGeneralSettings_Index_MOIsStockTransferAuto_false name=TenantGeneralSettings_Index_MOIsStockTransferAuto
    label "Manual" for #TenantGeneralSettings_Index_MOIsStockTransferAuto_false
    text "On order release, if 'automatic' is selected, stock transfers for components will be auto-created with status 'ordered'."
    label "Purchase order replenishment is"
    input radio#TenantGeneralSettings_Index_MOIsPurchaseOrderAuto_true name=TenantGeneralSettings_Index_MOIsPurchaseOrderAuto
    label "Automatic" for #TenantGeneralSettings_Index_MOIsPurchaseOrderAuto_true
    input radio#TenantGeneralSettings_Index_MOIsPurchaseOrderAuto_false name=TenantGeneralSettings_Index_MOIsPurchaseOrderAuto
    label "Manual" for #TenantGeneralSettings_Index_MOIsPurchaseOrderAuto_false
    text "On order release, if 'automatic' is selected, purchase orders for stock replenishment will be auto-created with status '"
    label "Nested production order creation is"
    input radio#TenantGeneralSettings_Index_MOIsNestedOrderAuto_true name=TenantGeneralSettings_Index_MOIsNestedOrderAuto
    label "Automatic" for #TenantGeneralSettings_Index_MOIsNestedOrderAuto_true
    input radio#TenantGeneralSettings_Index_MOIsNestedOrderAuto_false name=TenantGeneralSettings_Index_MOIsNestedOrderAuto
    label "Manual" for #TenantGeneralSettings_Index_MOIsNestedOrderAuto_false
    text "On order authorization, if 'automatic' is selected, any nested production orders will be auto-created also."
    label "Assembly order replenishment is"
    input radio#TenantGeneralSettings_Index_MOIsFinishedGoodsAuto_true name=TenantGeneralSettings_Index_MOIsFinishedGoodsAuto
    label "When order is authorized" for #TenantGeneralSettings_Index_MOIsFinishedGoodsAuto_true
    input radio#TenantGeneralSettings_Index_MOIsFinishedGoodsAuto_false name=TenantGeneralSettings_Index_MOIsFinishedGoodsAuto
    label "Via smart reordering / MRP" for #TenantGeneralSettings_Index_MOIsFinishedGoodsAuto_false
    text "On order release, if 'automatic' is selected, assembly orders for stock replenishment will be auto-created with status '"
    label "Create production order"
    select#TenantGeneralSettings_Index_MOCreateProductionOrder: When order is authorized | Via smart reordering / MRP
    label "Set order status to"
    select#TenantGeneralSettings_Index_MOCreateProductionOrderStatus: Draft | Planned | Released
    label "On order release produce"
    select#TenantGeneralSettings_Index_MOProduce: Quantity required | Quantity required and maintain minimum stock level quantity | Difference between available quantity and quantity required to cover a shortage
    label "Waste write off"
    select#TenantGeneralSettings_Index_MOWastageType: Posted to expense account | Included in production cost
    block #liMOWastageExpenseAccount (hidden)
      label "Wastage expense account"
      select#TenantGeneralSettings_Index_MOWastageExpenseAccount
    label "Backdated transactions"
    input checkbox#TenantGeneralSettings_Index_MOBackdatedTransaction
    text "Transactions for components/resources consumption and stock receipt of finished products can be backdated by changing th"
    label "Co-manufacturing procurement mode"
    select#TenantGeneralSettings_Index_MOCoManType: Sell components - Buy finished products | Transfer components - Buy finished product | Purchase components for co-manufacturer - Buy finished products
    label "Production component description source"
    select#TenantGeneralSettings_Index_MOComponentDescriptionSource: Product description | Product short description | Product internal note
    label "Transfer finished products to storage location"
    select#TenantGeneralSettings_Index_MOTransferFinishedProduct: Don't transfer | On production order completion | On production run completion
    label "Production order/run additional attribute set"
    select#TenantGeneralSettings_Index_MOAttributeSet
    label "Production operation attribute set"
    select#TenantGeneralSettings_Index_MORunOperationAttributeSet
    label "Production run output attribute set"
    select#TenantGeneralSettings_Index_MORunOutputAttributeSet
    label "Product tracing"
    select#TenantGeneralSettings_Index_MOTraceFinishedProduct: Never traced | Always traced | Optional traced
    label "Production documents"
    select#TenantGeneralSettings_Index_MODocumentSortOrder: Sorted by screen order | Sorted by name/description | Sorted by SKU
  tab pane#tab8
    text "Calculated prices will be rounded to the specified value and adjusted as per this rule to implement special price ending"
    button #btnAddNewRoundingRule primary
    slot #RoundingTable_Container
  tab pane#tab9
    label "Price tier 1"
    input text#TenantGeneralSettings_Index_PriceTierName1 placeholder "Price tier 1"
    label "Price tier 2"
    input text#TenantGeneralSettings_Index_PriceTierName2 placeholder "Price tier 2"
    label "Price tier 3"
    input text#TenantGeneralSettings_Index_PriceTierName3 placeholder "Price tier 3"
    label "Price tier 4"
    input text#TenantGeneralSettings_Index_PriceTierName4 placeholder "Price tier 4"
    label "Price tier 5"
    input text#TenantGeneralSettings_Index_PriceTierName5 placeholder "Price tier 5"
    label "Price tier 6"
    input text#TenantGeneralSettings_Index_PriceTierName6 placeholder "Price tier 6"
    label "Price tier 7"
    input text#TenantGeneralSettings_Index_PriceTierName7 placeholder "Price tier 7"
    label "Price tier 8"
    input text#TenantGeneralSettings_Index_PriceTierName8 placeholder "Price tier 8"
    label "Price tier 9"
    input text#TenantGeneralSettings_Index_PriceTierName9 placeholder "Price tier 9"
    label "Price tier 10"
    input text#TenantGeneralSettings_Index_PriceTierName10 placeholder "Price tier 10"
  tab pane#tab10
    table: Document | Prefix | Next number | Suffix
  tab pane#tab11
    label "Multilingual support"
    input checkbox#TenantGeneralSettings_Index_MultilingualSupport
    text "Turn ON/OFF support for multilingual product/supplier/customer names."
    block #multilingualToggledBlock
      text "Please don't change default language if you have already localized names for your customers, suppliers, and products."
      button #divNewLanguageTemplate primary
      slot #gridMultilingual
  tab pane#tab12
    label "Enable gift card support"
    input checkbox#TenantGeneralSettings_Index_EnableGiftCard
    text "Enable gift card support."
    block #liGiftCardSettings (hidden)
      label "Gift card account"
      select#TenantGeneralSettings_Index_GiftCardAccount
      text "Gift card liability account is required for sales and use of gift cards. An account must be set up to receive payments."
    label "Enable gift card expiration"
    input checkbox#TenantGeneralSettings_Index_EnableGiftCardExpiration
    text "Enable gift card expiration."
    label "Default expiration period"
    select#TenantGeneralSettings_Index_DefaultGiftCardExpirationPeriod: Five years | Three years | Year | Quarter | Month
    text "Default expiration period"
    label "Enable gift card refund"
    input checkbox#TenantGeneralSettings_Index_EnableGiftCardRefund
    text "Enable gift card refund."
  tab pane#tab13
    label "Supplier details"
    input checkbox#TenantGeneralSettings_Index_TooltipSupplier
    label "Product details"
    input checkbox#TenantGeneralSettings_Index_TooltipProduct
    label "Stock details"
    input checkbox#TenantGeneralSettings_Index_TooltipProductStock
    label "Customer details"
    input checkbox#TenantGeneralSettings_Index_TooltipCustomer
    label "Product deals"
    input checkbox#TenantGeneralSettings_Index_TooltipProductDeals
    label "Alternative products"
    input checkbox#TenantGeneralSettings_Index_TooltipAlternativeProducts
    label "Sale due details"
    input checkbox#TenantGeneralSettings_Index_TooltipSaleDueDetails
    label "Customer due details"
    input checkbox#TenantGeneralSettings_Index_TooltipCustomerDueDetails
    label "Resource details"
    input checkbox#TenantGeneralSettings_Index_TooltipResource
  tab pane#tab14
    label "Enable opportunity approval"
    input checkbox#TenantGeneralSettings_Index_EnableOpportunityApproval
    text "Opportunities must be approved before marked as completed."
  tab pane#tab15
    label "Production demand calculation date"
    input radio#TenantGeneralSettings_Index_MRPProductionDate_RequiredPlannedDate name=TenantGeneralSettings_Index_MRPProductionDate
    label "Planned/required by date" for #TenantGeneralSettings_Index_MRPProductionDate_RequiredPlannedDate
    input radio#TenantGeneralSettings_Index_MRPProductionDate_ReleaseDate name=TenantGeneralSettings_Index_MRPProductionDate
    label "Release date" for #TenantGeneralSettings_Index_MRPProductionDate_ReleaseDate
    text ""Planned/required by date" will select planned date if order uses forward capacity planning, required by date if using b"
block #ActivityLogDiv (hidden)
  button "Refresh"
  button "Close"#closeActivityLog
  slot #ActivityLogs_Container
  slot #ActivityLogs_Container_Small
slot #CountrySpecificScript
```

### `/TenantReminders`: Reminders

Frame: `task-upload-frame`.

```text
link "Home"
link "Automation"
heading "Reminders"
button "Back"
block #divReminders
  table
```

### `/UserProfile`: User profile

Frame: `task-upload-frame`.

```text
link "Home"
block #divMainContent
  heading "User profile settings"
  button "Save"#UserProfile_SaveChanges primary
  label "Name" for #UserProfile_UserName
  input text#UserProfile_UserName
  link "Reset two-factor authentication"#UserProfile_TFA_StartSetup
  link "Click here to edit alternative two-factor authentication met"#UserProfile_TFA_EditLink
  block #passkey-section (hidden)
    text "Add a passkey"
    slot #passkey-list-container
  text "Organizations you can access"
  text "Create new organization"
  slot #divTenantsContainer
  text "User login history"
  slot #divLoginHistoryContainer
modal#tfaSetupModal small
  block #TFA_Setup_Step1
    heading 
    heading "Get started with two-factor authentication set up"
    slot #TFA_Setup_QRCode
    link "or enter your key manually"#TFA_Setup_ShowCode
    input text#TFA_Setup_Code (hidden)
    button "Next"#TFA_Setup_Next1 primary
    button "Cancel" primary
  block #TFA_Setup_Step2 (hidden)
    heading "Authentication code"
    input text#TFA_Authenticator_Code
    label "Authentication code" for #TFA_Authenticator_Code
    button "Next"#TFA_Setup_Next2 primary
    button "Cancel" primary
  block #TFA_Setup_Step3 (hidden)
    heading "Set up alternative authentication method"
    block #TFA_AlternativeMethod_Email_Option (hidden)
      input radio#TFAAlternativeMethod1 name=TFAAlternativeMethod
      label "Set up alternative email address" for #TFAAlternativeMethod1
    block #TFA_AlternativeMethod_Questions_Option (hidden)
      input radio#TFAAlternativeMethod2 name=TFAAlternativeMethod
      label "Set up security questions" for #TFAAlternativeMethod2
    button "Next"#TFA_Setup_Next3 primary
    button "Cancel" primary
  block #TFA_Setup_Step6 (hidden)
    heading "Security questions"
    block #TFA_SecurityQuestionsWrapper
      slot #TFA_Question_1
      input text#TFA_Question_1_Answer placeholder "Answer"
      slot #TFA_Question_2
      input text#TFA_Question_2_Answer placeholder "Answer"
      slot #TFA_Question_3
      input text#TFA_Question_3_Answer placeholder "Answer"
    button "Next"#TFA_Setup_Next6 primary
    button "Cancel" primary
  block #TFA_Setup_Step4 (hidden)
    heading "Alternative email address"
    input text#TFA_AlternativeEmail
    label "Email address" for #TFA_AlternativeEmail
    button "Confirm email"#TFA_Setup_Next4 primary
    button "Cancel" primary
  block #TFA_Setup_Step5 (hidden)
    heading "Confirm alternative email address"
    input text#TFA_AlternativeEmailCode
    label "Verification code" for #TFA_AlternativeEmailCode
    button "Confirm email"#TFA_Setup_Next5 primary
    button "Cancel" primary
  block #TFA_Setup_StepCompleted (hidden)
    heading "Two-factor authentication enabled!"
    button "Done"#TFA_Setup_Completed primary
modal#tfaDisableModal small
  block #TFA_Disable_Step1 (hidden)
    heading "Disable two-factor authentication"
    input text#TFA_Disable_Code
    label "Authentication code" for #TFA_Disable_Code
    link "I can't use my authenticator app"#TFA_Setup_Disable_AlternativeLink (hidden)
    button "Disable"#TFA_Disable_Next1 primary
    button "Cancel" primary
  block #TFA_Disable_Step2 (hidden)
    heading "Disable two-factor authentication"
    input text#TFA_Disable_AlternativeEmailCode
    label "Verification code" for #TFA_Disable_AlternativeEmailCode
    button "Disable"#TFA_Disable_Next2 primary
    button "Cancel" primary
  block #TFA_Disable_Step3 (hidden)
    heading "Disable two-factor authentication"
    block #TFA_SecurityQuestionsWrapper
      slot #TFA_DisableQuestion_1
      input text#TFA_DisableQuestion_1_Answer placeholder "Answer"
      slot #TFA_DisableQuestion_2
      input text#TFA_DisableQuestion_2_Answer placeholder "Answer"
      slot #TFA_DisableQuestion_3
      input text#TFA_DisableQuestion_3_Answer placeholder "Answer"
    button "Disable"#TFA_Disable_Next3 primary
    button "Cancel" primary
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `AutomatedWorkflow2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAutomatedWorkflowGrid` · store `AutomatedWorkflowStore` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Entity type | `EntityType` |  | flex 1 | renderer() |  |
    | State | `IsActive` |  | flex 1 | renderer() |  |
    | Last updated date | `LastUpdatedDate` |  | flex 1 | renderer() |  |
    | Last updated by | `LastUpdatedBy` |  | flex 1 | renderer() | hidden |


### `GeneralSettings2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `RoundingTable_Container` · store `vMarkupRoundingsStore` · placeholder `There are no rounding rules at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Range from | `RangeFrom` |  | flex 1 | renderer() |  |
    | Range to | `RangeTo` | number column | flex 1 | renderer() |  |
    | Round to nearest | `RoundToNearest` | number column | flex 1 | renderer() |  |
    | Adjustment rule | `AdjustmentRule` |  | flex 1 | renderer() |  |
    | Value | `AdjustmentValue` | number column | flex 1 | renderer() |  |
    | Value | `AdjustmentValue` | number column | 42 | renderer() | hidden |

- **grid** · renders into `gridMultilingual` · store `vMultilingualSupportStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Language | `Code` |  | flex 1 | renderer() |  |
    | Main language | `IsDefault` | check column | 120 | renderer() |  |


### `MySubscription2019`

2 grids · 7 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPaymentHistoryGrid` · store `PaymentHistoryStore` · placeholder `You don't have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | From | `From` |  | flex 1 | renderer() |  |
    | To | `To` |  | flex 1 | renderer() |  |
    | Plan | `Plan` |  | flex 1 | RenderHTMLText |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Invoice number | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Paid with credit | `ReferralCreditUsed` |  | flex 1 | renderer() |  |
    | Response Text | `ResponseText` |  | flex 1 | RenderHTMLText | hidden |

- **grid** · renders into `divReferralsGrid` · store `ReferralsStore` · placeholder `You don't have any referrals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Company | `Company` |  | flex 1 | RenderHTMLText |  |
    | Date joined | `CreatedDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Discount | `Discount` |  | flex 1 | RenderHTMLText |  |
    | Credit earned | `CreditEarned` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| combo |  | `billingAddressCountry` | `CountryStore` | shows `Name` · value `Code2` |
| text field |  | `ccNumber` | `` |  |
| combo |  | `ccExpiryDateMonth` | `monthStore` | shows `value` · value `value` · placeholder `Month` |
| combo |  | `ccExpiryDateYear` | `yearStore` | shows `value` · value `value` · placeholder `Year` |
| text field |  | `ccCVV` | `` |  |
| combo |  | `el` | `CategoriesStore` | shows `name` · value `id` · required · pick-only |

### `MySubscriptionUpdateSubscriptionn2023`

0 grids · 1 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |

### `NotificationSettingsMailingList2019`

3 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `markupLogIds.internalLogId` · store `ExecutionLogStoreInternal` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ExecutionDate` |  | 130 | renderer() |  |
    | Task link | `EntityName` |  | flex 1 | renderer() |  |
    | Details | `Details` |  | flex 2 | renderer() |  |

- **grid** · renders into `markupLogIds.emailLogId` · store `ExecutionLogStoreEmail` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ExecutionDate` |  | 130 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Recipients | `Recipients` |  | flex 1 | renderer() |  |

- **grid** · renders into `markupLogIds.externalLogId` · store `ExecutionLogStoreExternal` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ExecutionDate` |  | 130 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | URL | `Url` |  | flex 2 | renderer() |  |


#### Menus, buttons and other parts

- **component**
  - *buttons:*
    - **item**

### `NotificationSettingsNotifications2019`

4 grids · 6 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `markupLogIds.internalLogId` · store `ExecutionLogStoreInternal` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ExecutionDate` |  | 130 | renderer() |  |
    | Task link | `EntityName` |  | flex 1 | renderer() |  |
    | Details | `Details` |  | flex 2 | renderer() |  |

- **grid** · renders into `markupLogIds.emailLogId` · store `ExecutionLogStoreEmail` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ExecutionDate` |  | 130 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Recipients | `Recipients` |  | flex 1 | renderer() |  |

- **grid** · renders into `markupLogIds.externalLogId` · store `ExecutionLogStoreExternal` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ExecutionDate` |  | 130 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | URL | `Url` |  | flex 2 | renderer() |  |

- **grid** · renders into `divExternalNotificationSettingsGrid` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | External URL | `ExternalURL` |  | flex 1 | renderer() |  |
    | Type | `IsWebhook` |  | 100 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field | {paramValue} | `"conditionControl_".concat(…)` | `` |  |
| number field |  | `"conditionControl_".concat(…)` | `` |  |
| number field |  | `"conditionControl_".concat(…)` | `` |  |
| date field |  | `"conditionControl_".concat(…)` | `` | format `UserDateFormat` |
| checkbox | {"&nbsp;".concat(…)} | `"conditionControl_".concat(…)` | `` |  |
| date field |  | `Notification_StartExecution_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **component** · renders into `"conditionControl_".concat(…)` · store `window["listStore_".concat(_cp.Name)]` · shows `Name` · value `Value` · placeholder `Choose...`

### `PageAccess2019`

3 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `PageAccess_Index_PermissionsContainerRoles` · store `permissionsRolesStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `DisplayName` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `PageAccess_Index_UsersContainer` · store `usersStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Email` |  | 100 | renderer() |  |
    | User | `Email` |  | flex 1 | renderer() |  |
    | Roles | `Roles` |  | flex 1 | RenderHTMLText |  |
    | Co-owner | `IsCoOwner` |  |  | renderer() |  |

- **grid** · renders into `PageAccess_Index_PermissionsContainerUsersGrid` · store `permissionsRolesStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `DisplayName` |  | flex 1 | RenderHTMLText |  |
    | Access | `FullAccess` |  | 200 | renderer() |  |


### `PasskeyUserProfile2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `passkey-list-container` · store `_store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FriendlyName` |  | flex 1 | renderer() |  |
    | Added | `CreatedAt` |  | 120 | renderer() |  |
    | Last used | `LastUsedAt` |  | 120 | renderer() |  |
    |  | `` |  | 110 | renderer() |  |


### `TaskSettings2019`

5 grids · 3 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `TaskListGrid` · renders into `TaskList_Container` · store `taskStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Start | `StartDate` |  | flex 1 | renderer() |  |
    | Category | `TaskCategoryName` |  | flex 1 | renderer() |  |
    | Status | `TaskStatus` |  | flex 1 | RenderHTMLText |  |
    | Assigned to | `UserID` |  | flex 1 | renderer() |  |

- **grid** · renders into `TaskCategory_divTaskCategoryGrid` · store `TaskCategory_store` · placeholder `You do not have any task categories at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Category name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Label color | `Color` |  | flex 1 | renderer() |  |

- **grid** · renders into `Calendar_divHolidayGrid` · store `Holiday_store` · placeholder `You do not have any holidays at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Description | `Description` |  | flex 3 | RenderHTMLText |  |
    | Skip | `Skip` | check column | 50 | renderer() |  |

- **grid** · renders into `WorkflowList_divWorkflowGrid` · store `WorkflowListStore` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Workflow name | `Name` |  | flex 1 | renderer() |  |
    | Due days type | `DueDaysType` |  | flex 1 | renderer() |  |
    | Active process | `ActiveProcessCount` |  | flex 1 | renderer() |  |

- **grid** · renders into `WorkflowList_activeProcessGrid` · store `WorkflowListActiveProcessStore` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `EntityName` |  | flex 1 | renderer() |  |
    | Start date | `CreatedDate` |  | flex 1 | renderer() |  |
    | Completed / All | `AllTaskCount` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `divStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divFromList` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divToList` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **component** · renders into `divTenantUsers` · store `UserStoreEx` · shows `Email` · value `UserId` · placeholder `Choose...`
- **component** · renders into `divNewUsers` · store `vTenantUserStore` · shows `Email` · value `UserId` · placeholder `Choose...`

### `UserProfile2019`

2 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divTenantsContainer` · store `vTenantsStore` · placeholder `You do not have any available organization.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Organization name | `Company` |  | flex 1 | renderer() |  |
    | Master user email | `MasterUserEmail` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 80 | renderer() |  |
    | Plan type | `PlanType` |  | 80 | renderer() |  |
    | Start date | `StartDate` |  | 120 | renderer() |  |
    | Subscription expire date | `ExpirationDate` |  | 120 | renderer() |  |
    | Anniversary date | `AnniversaryDate` |  | 150 | renderer() |  |
    | Two-factor authentication required | `IsTFAEnabled` |  | 120 | renderer() |  |

- **grid** · renders into `divLoginHistoryContainer` · store `vUserLoginHistoryStore` · placeholder `You do not have any login history at the moment`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Timestamp | `SysDate` |  | flex 1 | renderer() |  |
    | Where from | `Country` |  | flex 1 | renderer() |  |
    | Organization name | `Company` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `TFA_Question_1` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |
| combo |  | `TFA_Question_2` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |
| combo |  | `TFA_Question_3` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |

