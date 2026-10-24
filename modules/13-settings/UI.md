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

## Components by bundle

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

