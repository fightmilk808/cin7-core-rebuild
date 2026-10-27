# Cin7 Core settings: client-side behaviour (static analysis of the shipped page scripts)

Source: public ExtJS bundles in the public page bundles Cin7 serves to every browser, read as text only (nothing executed, no call to the live app, no Cin7 write). No company data.

How to read this file

- Bundle names are written without `.js`; `function` is the function or window variable that does the work. Line numbers are not given because the files are minified.
- The settings screens are server-rendered Razor pages. The JS only wires controls by DOM id. Labels, option lists and defaults of most dropdowns and radios live in the HTML, which is not in the bundles. Where a column says `HTML` the value is not determinable here. The sibling help-doc files (`rules/settings.md` etc.) are the place for labels.
- Field names are the tenant model fields used in the save payload (`vTenant`). The DOM id is `TenantGeneralSettings_Index_<name>` unless stated.
- Booleans shown as a Yes/No radio pair (ids `..._true` / `..._false`) are marked `radio Y/N`.

## ⚠️ Gotchas: the sneaky stuff

The easy-to-miss behaviours, worst first. `CAUTION` = silently corrupts data, cost or stock, is irreversible, or fails silently. `WARNING` = a surprising rule that breaks a rebuild if missed. `NOTE` = the sources disagree. Each links to the full rule below.

> [!CAUTION]
> **Saving General Settings always forces two-factor authentication on**
> There is no control for it, yet the save payload always sends `IsTFAEnabled` as `true`. You would assume 2FA is only changed by its own setting; the page script turns it on for the whole organisation on any save. See [1.1 Company and regional](#11-company-and-regional).

> [!CAUTION]
> **ForesightAI "Setup automatically" overwrites the location tree and cannot be undone**
> The confirm text says it overrides the current Locations settings and cannot be undone. The hierarchy is also capped at 6 levels. See [section 5](#5-foresightai--inventoro-settings-inventorosettings2019).

> [!CAUTION]
> **An expired module trial silently flips pages to read-only**
> When a trial lapses, POS, API, B2B, Notifications and Tasks are made read-only and the MRP Run button is disabled. The only signal is a banner with the expiry date. See [section 0](#0-settings-index-page-settings2019).

> [!CAUTION]
> **A rounding-table edit can be rejected without any message**
> A `Range to` edit that breaks the ordering rule is reverted silently (the value just snaps back). `Range from` is derived (previous `Range to` + 0.01), so you cannot type it. See [1.7 Attribute sets and rounding](#17-attribute-sets-and-rounding).

> [!WARNING]
> **Currency locks the moment any transaction exists**
> When `HasTransactions` is true the currency select is rendered disabled with only the current code. Tax field labels also follow the currency (AUD, NZD, GBP, other). See [1.1 Company and regional](#11-company-and-regional).

> [!WARNING]
> **"Decimal places in quantity" is read by no other page script**
> You would assume it rounds quantities everywhere. Client grids use fixed rounding (4 dp for quantities and purchase amounts), so the setting has no client effect. See [1.5 Inventory](#15-inventory).

> [!WARNING]
> **The credit-limit check is skipped when the limit is 0**
> The check runs on customer select only when `CreditLimit > 0`, so a zero limit means no client-side warning. Answering No to the confirm at order authorisation sets the order back to draft. See [1.3 Sales](#13-sales).

> [!WARNING]
> **The invoice date is only filled while it is empty, and "shipment date" can fall back to today**
> With the trigger on order authorisation, `SALE_SHIPMENT_DATE` falls through to today. Choosing `SALE_SHIPMENT_DATE` also removes the "Invoice" default ship date and forces "Current". See [1.3 Sales](#13-sales).

> [!WARNING]
> **Options hidden by another option are saved as false**
> Choosing a customer hides and unticks Ignore stock on hand, Transfer draft and Assembly draft; hidden boxes are saved as false. Ticking a "Procure up to" box forces Include overdue demand on and disables it. See [section 4](#4-mrp-run-settings-mrprunsettings-route-mrp-run-page).

> [!WARNING]
> **Turning on automatic discounts clears manual price changes**
> Switching "Automatically apply discounts" on clears the manual-change box, and saving with it off stores `ApplyManualPriceChanges=false`. Eligible discounts are applied before the quote or order is authorised, only if at least one discount exists. See [1.3 Sales](#13-sales).

> [!WARNING]
> **Saving with nothing changed still shows "Changes saved successfully."**
> If the main store is not dirty the page only toasts success and sends nothing. Do not read that toast as proof that a value was written. See [section 1](#1-general-settings-generalsettings2019-route-tenantgeneralsettingsindex).

> [!NOTE]
> **The accrual account is "required" even if accrual is off, and nobody knows if that blocks the save**
> The required-field list includes `InventoryAccrualAccount`, but whether hidden required fields block the save depends on a validator in another bundle that was not read. See [section 7](#7-not-determinable-statically).

---

## 0. Settings index page (`Settings2019`)

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Per-page access | `/api/settings_all_permissions` rows `{Prefix, Link, Allowed, Hidden}` | link tiles `link<Prefix>` | n/a | `Settings_Index_Ready`: Allowed=false turns the tile into `javascript:;`, adds `read-only` to its row and shows the message on click; Hidden=true adds `hiddenContent` to the tile | `You don't have access to this page.` |
| RMA tile | feature `RMA` via `FeatureTrials_Init` | tile `.linkRMAPolicy_Index` | n/a | hidden when `/api/TenantAccessToFeatures?feature=RMA` says `IsAvailable=false` | none |
| Fixed asset and Bank tiles | `Xero`, `EnableFinancials` (AccessInfo) | tiles `#linkFixedAsset_Index`, `#linkBank_Index` | hidden | `Settings_Index_Load`: un-hidden only when `!Xero && EnableFinancials` | none |
| Module trials (Notifications, Inventoro, MRP, RMA, API, POS, B2B, Tasks) | `/api/TenantAccessToFeatures` GET/POST | alert box + `Start trial` button | n/a | `FeatureTrials_Init` (copied into every settings bundle): active trial shows days left; expired trial shows expiry date and `FeatureTrials_MakeReadOnly` (POS, API, B2B, Notifications, Tasks made read-only, MRP `#btnRun` disabled); trial offered only when `CanCreateTrials` and no subscription | `This module is not currently part of your subscription. Would you like to trial this feature for 30 days?` (Inventoro: 14 days); `Your trial of this feature expired on {D MMMM YYYY}. If you would like to add this module to your subscription, click here.`; `You have {n} days left on your trial of {company} {feature} module.`; error `Something went wrong. Please try again later.` |

Save buttons on every settings page: `#divSaveChanges` and `#divSaveChanges2` (top and bottom). `ReadOnly` access hides both (`TenantGeneralSettings_Index_HideSaveChangesButton`, RMA settings: `Ext.get('divSaveChanges').addCls('hiddenContent')`).

## 1. General Settings (`GeneralSettings2019`, route `TenantGeneralSettings/Index`)

Page mechanics

- One record: GET/POST `/api/TenantGeneralSettings_Index_vtenant` (single `vTenant` row, 205 model fields: 19 numbering sequences = 76 fields, plus 129 others of which about 122 are real settings).
- Tabs `#settingsTabs` (`#tabAll` shows every pane at once). Hash in the URL selects a tab (`TenantGeneralSettings_Index_SetTabFromHash`). `.set-popover` popovers placed `top` when window < 975px wide, else `right`. Fields with `data-focus-target` show a side note (`.note-title`, `.note-message`) while focused.
- Save (`TenantGeneralSettings_Index_Save`): runs `__HighlightInvalidFields.validation(requiredIds)` then `TenantGeneralSettings_Index_UpdateStore().validation`; if either fails nothing is sent. Saves the multilingual store separately when dirty. If the main store is not dirty it only toasts `Changes saved successfully.` Success toast: `Changes saved successfully.`
- Required (highlighted when empty): `Company`, `InventoryAccrualAccount`, all 19 `...NextNumber` fields, `PriceTierName1..10`.
- Leaving the page with unsaved changes is guarded (`BindPageLeave`, `ArePendingChanges` compares the rebuilt model).
- `IsReadOnly`: every control set read-only/disabled, rounding "add rule" and "new language" buttons hidden, `MRPProductionDate` forced to the RequiredPlannedDate radio, save buttons hidden.
- Country specific: when `CountrySpecificKey` (from AccessInfo) is non-empty the controls are created only after `/TenantGeneralSettings/CountrySpecific?Key=` script loads (`TenantGeneralSettings_Index_AccessCallback`); extra `CountrySpecificData` is merged in on save/load (`TenantGeneralSettings_GetCountrySpecificData` / `_LoadCountrySpecificData`, not in this bundle).

### 1.1 Company and regional

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Company name | `Company` | text `...Company` | HTML | required | none |
| Currency | `Currency` | select, list from `/api/currency` (`Code`,`Name`) | existing | `TenantGeneralSettings_Index_UpdateFinancialsVisibility` relabels tax fields by currency (see 1.8). When `HasTransactions` is true the select is rendered with only the current code, disabled and read-only (cannot be changed once any transaction exists). | none |
| Country | read-only text `...Country` | shows `window.TenantCountry` | n/a | display only | none |
| Time zone | `TimeZone` | select `#timeZoneComboBox`, `/api/TenantGeneralSettings_Index_vTimezone` (`name`,`displayName`) | existing | saved as `name` | none |
| Date format | `DateFormat` | select | HTML | Main2019 (task module block) maps tenant format to Ext format: `dd/MM/yyyy` -> `d/m/Y`, `MM/dd/yyyy` -> `m/d/Y`, anything else -> `Y/m/d` (`window.UserDateFormat`, also moment `DD/MM/YYYY`, `MM/DD/YYYY`, `YYYY/MM/DD`; time `hh:mm A`). `getAltFormats` / `_getAltFormats(UserDateFormat)` adds permissive alternative parse formats (e.g. `j/m/Y`, `dmy`, `d/m`) for `d/m/Y` and the US equivalents for `m/d/Y`. | none |
| Default measurement units | `DefaultDimensionsUnits`, `DefaultWeightUnits` | select with optgroups `Metric` / `Imperial` built from `/api/TenantGeneralSettings_Index_vUOMDim` and `_vUOMWeight` (rows with `IsFirst=true` open a group; first option is blank) | blank | read by Product2019 (`DefaultMeasurementDimensionsUnit`, `DefaultMeasurementWeightUnit` defaults on new product) and Shippit2019 / StarShipIt2019 / TenantShippingZones2019 | none |
| Open details in new tabs | `OpenDetailsInNewTabs` | radio Y/N | HTML | Main2019 `window.OpenDetailsInNewTabs`; every list opens a document with `window.open(url)` instead of `location.href` (SalesList `SaleList_Index_EditGeneral/EditAccounting/EditFulfilment`, and about 50 other list/edit bundles) | none |
| Enable chat | `EnableChat` (model field, AccessInfo) | n/a in this page | HTML | MainAccount2019/Main2019 show or hide the chat widget | none |
| Session timeout | `SessionTimeout` | select `...SessionTimeout` (minutes) | Main2019 uses 60 when the value is null | `cmbSessionTimeoutChange` writes the hint text. Main2019 calls `SessionTimeout_Start(minutes)` (the inactivity timer; its body was not read). | hint: `Your session will expire after {n} minutes of inactivity.` |
| Password change frequency | `PasswordChangeFrequency` | select | HTML | server only | none |
| Two-factor | `IsTFAEnabled` | no control; always sent `true` on save | true | forces 2FA on | none |
| Export encoding | `ExportEncoding` | select | HTML | server (CSV export encoding) | none |
| Tooltip sections ("quick link" tooltips) | `TooltipSections` | 9 checkboxes: Supplier, Customer, Product info, Product stock, Product deals, Alternative products, Sale due details, Customer due details, Resource details | all unchecked when null | saved as comma list of `QuickLinks.TooltipTypes.*` codes (null if none). Main2019 hover tooltips (`_availableSections.has*`) appear only for ticked types; product-based tooltips are not offered for `Non Inventory, Fixed Assets, Service` product types. | none |
| Use latest purchase cost | `UseLatestPurchaseCost` | select `true`/`false` (`...PurchaseCost`) | HTML | server: which cost is proposed on purchase lines. No client read. | none |
| Multilingual support | `IsSupportMultilingual` | switch `...MultilingualSupport` + grid | off | on: shows `#multilingualToggledBlock` and refreshes grid. Grid columns `Language` (combo from `/api/TenantGeneralSettings_Index_vMultilingualSupportReferenceData`), `Main language` (check column: exactly one true; ticking one clears the others), delete. First language added becomes main. Saved through `/api/TenantGeneralSettings_Index_vMultilingualSupport`. | `Language '{0}' is already on the list. Please select another one.` |

### 1.2 Document numbering (19 sequences)

Each sequence is `Prefix`, `NextNumber`, `Suffix` plus a `...Changed` flag. `NextNumber` is sent (and `...Changed=true` set) only if it differs from the loaded value; the flag is reset to false on every load. All `NextNumber` inputs are required. Control ids `txt<Code>Prefix`, `txt<Code>NextNumber`, `txt<Code>Suffix`.

| Code | field prefix | module (inferred from the code; the page labels are HTML) |
|---|---|---|
| Stock | `Stock*` | product (stock item) SKU numbering, used with `SkuAutogeneration` |
| Service | `Service*` | service product |
| FixedAsset | `FixedAsset*` | fixed asset (row hidden for Xero: `fixedAssetNumbers`) |
| PO | `PO*` | purchase order |
| INV | `INV*` | sale invoice |
| SO | `SO*` | sale order |
| Job | `Job*` | job costing |
| CR | `CR*` | credit note |
| ST | `ST*` | label not in JS |
| TR | `TR*` | label not in JS |
| FG | `FG*` | finished goods / assembly |
| FO | `FO*` | fulfilment order |
| MO | `MO*` | manufacturing (production) order |
| WRN | `WRN*` | warranty |
| RMA | `RMA*` | RMA |
| RMAReturnOrder | `RMAReturnOrder*` | RMA return order |
| MRP | `MRP*` | MRP run |
| ECR | `ECR*` | expense claim receipt |
| Opportunity | `Opportunity*` | opportunity |

Sibling toggle: `SkuAutogeneration` (select `...SkuAutogeneration`). The control is read with `dearHelper.control.getValue`; on load `#productNumberFormat` is shown when the value is truthy, and a `change` handler toggles it by `this.checked`. Effect in Product2019: when on, the product code input is disabled and read-only with placeholder `auto-generated`; Product2019 `dataToSave.SkuAutogenerationFlag = SkuAutogeneration`; Opportunity2019 quick-add product does the same (`SkuAutogenerationFlag.Value()` -> placeholder `auto-generated`, input disabled).

### 1.3 Sales

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Default taxation rule | `DefaultTaxationRule` | select from `/api/TenantGeneralSettings_Index_vtenanttaxationrule` (`RuleID`,`Description`) | existing | default tax rule on new sale/purchase (reference data `DefaultTaxRule`) | none |
| Document sort order (sale) | `DocumentSortOrder` | select | HTML | server (print order of lines) | none |
| Skip quote | `SkipQuote` | radio Y/N | HTML | SimpleSale2019 `SaleReferenceDataStore.load`: `DefaultSkipQuote`; new sale `SkipQuote: JobID == null && DefaultSkipQuote` (jobs never skip). Per-sale checkbox `chkSkipQuote` (header). When ticked: Quote tab hidden, quote lines and charges cleared (`RemoveAllQuote`), `divCopy_Order` hidden, Order tab opened; approval (`doesNotNeedApproval`) not required. Checkbox read-only once quote or order is authorised (`StatusTracker` header state). Also read by AdvancedPurchase, PurchaseDropShip, PurchaseService, SimplePurchase, CreditNote, Opportunity, Assembly, AwaitingSale (shared status code). | none |
| Auto-pick | `AutoPick` | radio Y/N | HTML | no client read; auto-pick of stock on authorising an order is server side (the client only has the manual `divAuto_Pick` button, `Sale_Pick_StartAutoPick`, `/api/Sale_Index_AutoPick`) | none |
| Auto-pack (skip pack) | `SkipPack` (DOM `AutoPack`) | radio Y/N | HTML | SimpleSale `DefaultSkipPack`: in `Sale_Pick_SplitSale` and on authorising a pick the pack list is rebuilt from the pick and `Sale_Pack_Complete()` called. SaleMultiple2019: when PackAuthorisationPermission is Full and there are no packing slips, `SaleMult_Pack_CopyFromPickHard()`; otherwise `PlannedOperation='Pack:CopyFromPick'`. | none |
| Auto-ship (skip ship) | `SkipShip` | radio Y/N | HTML | SaleMultiple2019 only: if off and ShipmentStatus is NOT AVAILABLE the shipment store is cleared (`DefaultSkipShip`). | none |
| Show invoice before fulfilment | `ShowInvoiceBeforeFulfillment` | radio Y/N | HTML | SimpleSale / SaleMultiple / AwaitingSale: Invoice tab is moved right after Order tab (`item.insertAfter(before)` on `#tabOrder`). | none |
| Allow authorising orders without allocation | `AllowOrderNoAlloc` | radio Y/N | HTML | SimpleSale: if false, clicking `divAuthorise_Order` runs `Sale_Order_Authorise(false)` straight away (no dropdown, `data-toggle` removed). If true the button keeps its split-menu and `Sale_Order_Authorise(true)` sets status `AUTH_NO_ALLOC` (`StatusTracker.statuses.authNoAllocation`); that status counts as authorised for Fulfill/shipping-rate buttons. The dropdown is hidden again after completion. | none |
| Default ship date | `DefaultShipDate` | select, `Current` or `Invoice` (+ label HTML) | HTML | `CommonSale_GetDefaultShipmentDate`, `Sale_Ship` new shipment: `Invoice` -> invoice date (today if blank), else today. Option `Invoice` is removed and the value forced to `Current` while `FillInvoiceDateOption = SALE_SHIPMENT_DATE`; re-added (text `Invoice date`) otherwise (`TenantGeneralSettings_Index_FillInvoiceDateOption`, runs on load and is wired to the fill-date select). | none |
| Fill invoice date on | `FillInvoiceDateOnOrderAuthorisation` | select: `WHEN_ORDER_AUTHORISED`, `WHEN_SHIPMENT_AUTHORISED`, `WHEN_INVOICE_AUTHORISED` | HTML | see "Invoice date fill rules" below | none |
| Invoice date value | `FillInvoiceDateOption` | select: `CURRENT_DATE`, `SALE_ORDER_DATE`, `SALE_SHIPMENT_DATE` | HTML | see below | none |
| Invoice number time point | `InvoiceNumberTimePoint` | select | HTML | server (when the INV number is allocated) | none |
| Default quantity | `DefaultQuantity` | numeric mask, min 0, no max, left aligned | 0 (blank -> 0 on blur) | `getDefaultQuoteQuantity()` = `DefaultQuantity || 0`: quantity of a newly added quote/order line (SimpleSale, SaleMultiple, Opportunity, ServiceSale, Purchase*, Assembly). | none |
| Headers visible | `HeadersVisible` | radio Y/N | HTML | SimpleSale: `if (FirstLoad && !HeadersVisible) Sale_Index_CollapseToggle()` for saved documents (header block collapsed on first load). SimplePurchase compares `HeadersVisible == 'False'` (string) instead. Same in CreditNote, Opportunity, ExpenseClaim, OpeningBalances. | none |
| Use current user as sale rep | `UseCurrentUserAsSaleRep` | checkbox (`...Sale_UseCurrentUserAsSaleRep`) | HTML | `CommonSale_Index_GetSaleRepByDefault`: when true, picks the contact of Type `Sale` whose Email equals the login (`window.UserName`); if none, the Sale contact flagged `DefaultForType`. Sets `CanBeChangedSaleRep = true`. | none |
| Split auto assembly | `SplitAutoAssembly` | checkbox (`...Sale_SplitAutoAssembly`) | HTML | server | none |
| Pick from all locations | `PickFromAllLocations` | select `true`/`false` | HTML | server (pick location scope) | none |
| Customer credit limit mode | `CustomerCreditLimitMode` | select | HTML | server computes `IsOnCreditHold`, `GracePeriodExceeded`; client shows warnings (below) | see credit rules |
| Credit hold grace period | `CreditHoldGracePeriod` | numeric mask, min 0, blank -> 0 | 0 | server flags `GracePeriodExceeded`; client max 1000 enforced on save | `The maximum amount of the quantity for credit hold grace period cannot exceed more than 1000.` (warning, save blocked) |
| Discount calculation method | `DiscountCalculationMethod` | select; client tests the value `Price` | HTML | SimpleSale/AwaitingSale/SaleMultiple/Opportunity/CreditNote/ServiceSale `Sale_*_ApplyDiscounts`: if `Price`, the line `Price` is set to the discounted price and `Discount=0`; otherwise `Price` stays and `Discount` holds the percent | none |
| Automatically apply discounts | `AutomaticallyApplyDiscounts` (model `IsAutomaticallyApplyDiscounts` on sale) | checkbox | off | turning on shows `..._AutomaticallyApplyDiscounts_Note` and `#dvAllowManualPriceChanges` and clears the manual-change box; turning off hides both. Save stores `ApplyManualPriceChanges=false` when auto-apply is off. On sale, `Sale_Order_PreComplete` / `Sale_Quote_PreComplete` run `Sale_*_ApplyDiscounts` first when `IsAutomaticallyApplyDiscounts === true && DiscountCount > 0`. | none |
| Allow manual price changes (for non-discounted products) | `ApplyManualPriceChanges` (sale: `IsApplyManualPriceChangesForNonDiscountProducts`) | checkbox, visible only while auto-apply is on | off | shows `..._ApplyManualChanges_Note`; in `Sale_*_ApplyDiscounts` a line with no deal/discount (`DealID`,`DealName`,`DiscountID`,`DiscountName` all empty), customer over-discount <= 0 and not the gift card product is left unchanged | none |
| Apply customer discount after other discounts | `ApplyCustomerDiscountAfterOtherDiscounts` | checkbox | HTML | server (ordering of stacked discounts) | none |
| Recurring invoice price handling | `RecurringInvoicePriceHandlingMethod` | select | HTML | server | none |
| Allow charge to card on file | `AllowChargeToCardOnFile` | checkbox | HTML | disabled when `CanEditCardOnFileSetting !== true` and the hint `..._AllowChargeToCardOnFile_OwnerOnlyHint` is shown (only the account owner may change it) | hint text is HTML |
| Enable quote approval | `AllowQuoteApproval` (sale: `IsQuoteApproveEnabled`) | checkbox | off | `isApproved()`: if off always true; if on the quote needs `QuoteApprove == 2`; `isRejected()` is `QuoteApprove == 1`; skip-quote, authorised/paid invoice, authorised stock or completed task bypass approval (`doesNotNeedApproval`). `setApproveButtonsVisible` hides `#btApprove` / `#btReject` when off or when the order is completed. Order approval uses `IsOrderApproveEnabled` (see purchases). | none |
| Archiving | `AllowArchiving` (two mirrored switches `AllowArchiving`, `AllowArchiving2`) | checkbox | off | toggling either mirrors the other and shows/hides `.grpArchiving` (archive periods). Sale/purchase `IsArchiveEnabled`: `setArchiveButtonVisible` hides `#divArchive`, `#divArchiveStatic`; archive only offered for saved documents not yet archived. | none |
| Quote archive period | `SaleQuoteArchivePeriod` | select inside `.grpArchiving` | HTML | server auto-archive age | none |
| Add existing attachments to email | `AddExistingAttachmentsIntoTheEmail` | two mirrored checkboxes (`Purchase_...` and `Sale_...`) | HTML | change on either sets the other; one stored value | none |
| Default new sale page | `IsDefaultAdvancedSale` | checkbox | off | SalesList / Deal / Home call `/api/TenantGeneralSettings_Index_vTenant/short`; if true `window.defaultNewSalePage = '/SaleMultiple'` (advanced sale form) | none |
| Enable gift cards | `IsGiftCardEnabled` | checkbox + sub-settings | off | `setGiftCardGroupVisibility`: off hides `.giftCardGroup`; on shows it, and shows `.giftCardExpirationGroup` only if `CanGiftCardExpire`. On sale forms (SimpleSale `CommonSale_*`): gift-card buttons (`divNewGiftCard_*`) shown only when `IsGiftCardEnabled` and `GiftCardProductID` exist; `divNewPaymentGiftCard_Invoice` only when also invoice currency equals tenant currency. | none |
| Gift card account | `GiftCardAccount` | select; accounts with Class `LIABILITY`, `ForPayments`, Type not `BANK`; with QuickBooks also any ASSET/LIABILITY | existing | | none |
| Gift cards can expire | `CanGiftCardExpire` | checkbox | off | shows expiration period group | none |
| Default expiration period | `DefaultGiftCardExpirationPeriod` | select | HTML | | none |
| Gift cards can be refunded | `CanGiftCardRefund` | checkbox | off | | none |
| Price tier names | `PriceTierName1..10` | 10 text inputs | tier names | tier 1 always editable. Tiers above `AvailablePriceTiers` (subscription, AccessInfo) are read-only and display `Not Available`; on save a value equal to `Not Available` is not written back. All 10 are "required" ids. | none |
| Rounding table (markup rounding) | `vMarkupRoundings` | inline grid | empty (`There are no rounding rules at the moment.`) | see 1.7 | see 1.7 |

Invoice date fill rules (SimpleSale; the same constants are repeated in CreditNote2019, AwaitingSale2019, SalesList2019 as `window.FillInvoiceDateOnInvoiceAuth` etc.)

- Trigger = `FillInvoiceDateOnOrderAuthorisation`, value = `FillInvoiceDateOption`. The invoice date is only filled when it is still empty.
- Order authorised (`Sale_Invoice_CopyFromSaleOrder`) and trigger is `WHEN_ORDER_AUTHORISED`: date = today; `SALE_ORDER_DATE` -> order date; `SALE_SHIPMENT_DATE` falls through to today.
- All lines drop-ship (`Sale_Order_ContinueCompletion`, no shipment needed) and trigger is `WHEN_SHIPMENT_AUTHORISED`: today, or order date for `SALE_ORDER_DATE`.
- Shipment authorised (`Sale_Ship_Set_InvoiceDate`) and trigger is `WHEN_SHIPMENT_AUTHORISED`: `CURRENT_DATE` -> today; `SALE_SHIPMENT_DATE` -> latest shipment date; any other value (`SALE_ORDER_DATE`) -> order date.
- Invoice authorised (`Sale_Invoice_Complete`) with empty date: default today. Trigger `WHEN_INVOICE_AUTHORISED` or `WHEN_ORDER_AUTHORISED`: `SALE_ORDER_DATE` -> order date; `SALE_SHIPMENT_DATE` -> ship date only if `ShipmentStatus == AUTHORISED` (`Sale_Invoice_GetShipDate`, which for an all-drop-ship sale returns today or order date). Trigger `WHEN_SHIPMENT_AUTHORISED`: only when shipment is AUTHORISED does it use order date or ship date.
- Always followed by `Sale_Invoice_UpdateDueDate()`.

Credit limit and credit hold behaviour on sales (SimpleSale `Sale_Index_CheckCreditLimit` on customer select when `CreditLimit > 0`; AwaitingSale2019 has the same)

- Warning toasts: `Customer is on credit hold`; `Customer has been put on credit hold by the system due to exceeding their payment grace period.`; `Credit limit exceeded` with detail `The customer outstanding balance is {0}, whereas the customer credit limit is {1}.` (shown when `CurrentCredit >= CreditLimit`).
- On authorising an order (`Sale_Order_Complete`), after adding the order total: if `IsOnCreditHold` or `CreditLimit > 0 && CurrentCredit + order total > CreditLimit` or `GracePeriodExceeded`, a confirm dialog (Yes!/No) appears. Titles/texts: `Customer is on credit hold` / `The customer is on credit hold. Would you like to continue?`; `Credit limit exceeded` / `The customer outstanding balance including this order is {0}, whereas the customer credit limit is {1}. Would you like to continue?`; `Grace period exceeded` / `Customer has been put on credit hold by the system due to exceeding their payment grace period. Would you like to continue?`. No sets the order status back to draft.
- Data comes from `/api/Sale_Index_CurrentCredit?CustomerID=` (`CurrentCredit`, `IsOnCreditHold`, `GracePeriodExceeded`). How `CustomerCreditLimitMode` changes `CurrentCredit` is server side.
- Role gate `CustomerOnCreditHoldPermission` (reference data) is outside tenant settings.

### 1.4 Purchases

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Default purchase method | `DefaultPurchaseMethod` | select; client tests `Invoice First` | HTML | SimplePurchase / PurchaseDropShip new purchase: `Approach = DefaultPurchaseMethod == 'Invoice First' ? 'Invoice' : 'Stock'` (so the other option is stock first) | none |
| Purchase document sort order | `PurchaseDocumentSortOrder` | select | HTML | server | none |
| Use purchase put-away | `UsePurchasePutAway` | checkbox | off | AdvancedPurchase2019: product lookup `HideNonInventory: !UsePurchasePutAway`; stock-received step gets an intermediate put-away stage (`PurchaseAdvanced_CheckEqualityIntermediatePutAway`); `divCopyFromPO_StockReceived` hidden when on; status logic requires both stock and intermediate statuses authorised. Also read by PurchaseDropShip, PurchaseService, PurchaseCreditNote, SimplePurchase. | none |
| Search only supplier-attached products in purchase lines | `SearchOnlySupplierAttachedProductsInPurchaseLines` | checkbox | off | server (product lookup filter) | none |
| Enable purchase order approval | `AllowPurchaseOrderApproval` (purchase: `IsOrderApproveEnabled`) | checkbox | off | same `isApproved` / `setApproveButtonsVisible` pattern with `archiveType !== 'sale'` | none |
| Purchase order archive period | `PurchaseOrderArchivePeriod` | select inside `.grpArchiving` | HTML | server | none |
| Default new purchase page | `IsDefaultAdvancedPurchase` | checkbox | off | PurchaseList: `/api/TenantGeneralSettings_Index_vTenant/short`; true -> `defaultNewPurchasePage = '/PurchaseAdvanced'` | none |
| Add email sender to CC | `AddEmailSenderToCC` | select `true`/`false` | HTML | server (emails) | none |
| Email sender | `EmailSender` | select | HTML | server | none |
| Global BCC | `GlobalBcc` | text `...GlobalBCC` | blank | server (BCC on every outgoing document email) | none |
| Request read receipt | `RequestMailReceipt` | radio Y/N | HTML | server | none |

### 1.5 Inventory

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Decimal places in quantity | `DecimalPlacesInQuantity` | select `...DecimalPlaces` | HTML | not read by any other bundle; client grids use fixed rounding (qty 4 dp in `SaleEditCalculator`, `OrderQuantity/Quantity/Amount` 4 dp in the purchase calculator) | none |
| Reorder mode | `ReorderMode` | select | HTML | ReorderLevelOfStock2019: `/api/Reorder_Index_Tenant`; value `Location` shows the location filter block `#divLocationContent` (per-location reorder) | none |
| Inventory accrual | `InventoryAccrual` | checkbox | off | on shows `#liInventoryAccrualAccount` and `#liStockInTransitAccount` | none |
| Inventory accrual account | `InventoryAccrualAccount` | select from `/api/TenantGeneralSettings_Index_InventoryAccrualAccounts` | existing | required on save | highlight only |
| Stock in transit account | `StockInTransitAccount` | select, only accounts with Class `ASSET` | existing | | none |
| Update stock received date on location transfer | `UpdateStockReceivedDateOnLocationTransfer` | checkbox | HTML | server (FIFO date handling) | none |
| Recommend batch/serial | `RecommendBatchSN` | select, numeric 0, 1, 2 | HTML | TenantLocationEdit: `recommendBatchSNMode`; `#directed-pick-note` is shown unless the mode is 2 | none |
| Ignore expired batches | `IgnoreExpiredBatch` | checkbox | HTML | server (allocation) | none |
| ChatGPT description prompts | `ChatGptPromptForEmptyDescription`, `ChatGptPromptForExistingDescription` | two textareas | HTML | Product2019 `Product_ChatGpt_GenerateDescription` is the consumer. The shared trial code has a special case for it: after starting a trial from that page it writes `In trial - 15 days left. Subscribe` instead of reloading (which feature name it uses is not visible here) | none |
| Pick from all locations | see 1.3 | | | | |

### 1.6 Manufacturing (MO / production)

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Auto stock transfer | `MOIsStockTransferAuto` | radio Y/N | HTML | server | none |
| Auto purchase order | `MOIsPurchaseOrderAuto` | radio Y/N | HTML | server | none |
| Auto nested order | `MOIsNestedOrderAuto` | radio Y/N | HTML | server | none |
| Auto finished goods | `MOIsFinishedGoodsAuto` | radio Y/N | HTML | server | none |
| Create production order status | `MOCreateProductionOrderStatus` | select | HTML | server | none |
| Create production order | `MOCreateProductionOrder` | select; value `saleOrder` is special | HTML | `changed.bs.select` + `TenantGeneralSettings_Index_MOProduce_Container_UpdateVisibility`: value `saleOrder` shows `.TenantGeneralSettings_Index_MO_SaleOrder_Container` (the MOProduce options for sale orders), otherwise hidden | none |
| How much to produce | `MOProduce` | select; known values `requiredInSalesAndReorder`, `availableMinusRequired` (others HTML) | HTML | ProductionOrder / ProductionSetup `ProductionCommon_CheckOrderQuantity` and `_checkOrderQuantity`: for those two values the client asks `/ProductionOrder/GetSuggestedQuantity` and compares with the entered quantity. If qty is 0 or differs, a confirm dialog: title `Confirmation`, text `You created the production order for {orderQty} of {product}. The quantity needed to cover "{setting}" is {qty}.` + `Would you like to produce:`; confirm button shows the suggested qty (or `Cancel order` when it is 0), cancel button shows the entered qty. Setting names: `Quantity required and maintain minimum stock level quantity` / `Difference between available quantity and quantity required to cover a shortage`. The product's `MinQuantity`/`MaxQuantity` clamp the suggestion and add `The minimum quantity set up for production order is {n}.` (and the max equivalent). | see left |
| Finished goods produce | `FGProduce` | select | HTML | server | none |
| Component description source | `MOComponentDescriptionSource` | select | HTML | server | none |
| Wastage type | `MOWastageType` | select; values `auto`, `include` (others HTML) | HTML | `changed.bs.select`: value `auto` un-hides `#liMOWastageExpenseAccount`. Product2019: with `auto` and any in/out, wastage cost blocks `#wastageProductsCostBlock` / `#makeToOrderWastageProductsCostBlock` are shown. ProductionOrder: with `include`, completing a run with output qty 0 is refused: `Cannot complete production run without any output.` | |
| Wastage expense account | `MOWastageExpenseAccount` | select from `/api/TenantGeneralSettings_Index_vExpenseAccounts` | existing | only visible for wastage `auto` | none |
| Co-manufacturing type | `MOCoManType` | select | HTML | server | none |
| Trace finished product | `MOTraceFinishedProduct` | select, numeric: 0 NeverTrace, 1 AlwaysTrace, 2 Option | HTML | Product2019: value 1 hides `#IssueMethodBlock,#BackflushDefinedForBlock` and the backflush-operation titles; value 2 shows `#ProductTracingBlock` only when the product's costing method is not FIFO. ProductionOrder (`generalOptions`): never trace or component issue method Backflush -> `IsTracing=false`; always -> true; option -> per BOM/run value. Value 1 also hides a column (`isHidden = MOTraceFinishedProduct == 1`). | |
| Transfer finished product | `MOTransferFinishedProduct` | select | HTML | server | none |
| Production document sort order | `MODocumentSortOrder` | select | HTML | server | none |
| Backdated transactions | `MOBackdatedTransaction` | checkbox | HTML | server | none |
| MRP production date | `MRPProductionDate` | radio: value of `...MRPProductionDate_RequiredPlannedDate` vs `..._ReleaseDate` (values from the DOM) | RequiredPlannedDate when not equal to the ReleaseDate value | which date MRP uses for production orders | none |
| Production order attribute set | `MOAttributeSet` | select (`Not defined` = empty guid -> saved as '') | Not defined | | none |
| Run output attribute set | `MORunOutputAttributeSet` | same | Not defined | | none |
| Run operation attribute set | `MORunOperationAttributeSet` | same | Not defined | | none |
| Opportunity approval | `EnableOpportunityApproval` | checkbox | off | Opportunity2019: authorising an opportunity with approval on sets status `waitingForApproval`, else `won`; OpportunityList shows an approval status filter | `Your opportunity is empty. You cannot authorize an empty opportunity.` |

### 1.7 Attribute sets and rounding

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Sale attribute set | `SaleAttributeSet` | select from `/api/TenantAttributeSet_Index_vTenantAttributeSet`; first option `Not defined` (empty guid) | Not defined | saved as '' when Not defined. Sale forms load it as `CurrentAttributeSetId` | none |
| Copy values from (sale) | `SaleAttributeSetCopyFrom`, checkbox `SaleAttributeSetCopyFromChk` | select of sets (without Not defined) | unchecked | checkbox disabled and cleared while Sale set is Not defined; unticking hides the select and clears it; `AttributeSetCopyFrom` read by sale forms | `Please select an attribute set to copy values from.` (error, save blocked) |
| Purchase attribute set / copy from | `PurchaseAttributeSet`, `PurchaseAttributeSetCopyFrom` | same pattern | Not defined | same | same message |
| Rounding table | `vMarkupRoundings` rows `{RangeFrom, RangeTo, RoundToNearest, AdjustmentRule, AdjustmentValue}` | grid with cell editing | none | `Range from` read-only and derived: rows sorted ascending by `RangeTo`, `RangeFrom` = previous `RangeTo + 0.01` (first 0) (`alignRoundingTable`). `Range to`: number, min 0, 2 decimals, required. `Round to nearest`: number, min 0, required. `Adjustment rule`: combo `N` No adjustment / `S` Subtract / `A` Add. `Value`: number min 0, not editable while rule is `N`; choosing `N` resets it to 0. New rule row: `RangeFrom=RangeTo=prevRangeTo+0.01` (or 0), `RoundToNearest=0.01`, rule `N`, value 0, and starts editing `Range to`. Rows removable. Saved only if the store is dirty (`RoundingTableChanged=true`). `RangeTo` edit is rejected (silently, value reverted) when `v <= next row's RangeTo - 0.01` is false or `v < RangeFrom`. | none |

### 1.8 Financials (`#financialSettings` is shown for Xero and non-Xero tenants alike)

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Financial year end | `FinancialYearEndMonth`, `FinancialYearEndDay` | two selects | existing | AccessInfo copies to `window.FinancialYearEndMonth/Day` | none |
| Tax number | `TaxNumber`, `TaxNumberDisplayName` | text; display-name row `#liTaxNumberDisplayName` hidden for non-USD tenants (non-Xero path) | blank | label/placeholder text swapped by currency: AUD `Tax file number` (basis label `GST accounting method`, period label `GST calculation`); NZD `GST number` / `GST basis` / `GST period`; GBP `VAT number` / `VAT scheme` / `VAT period`; any other `Tax ID number` / `Tax basis` / `Tax period` | none |
| Tax calculation basis | `TaxCalculationBasis` | select from `/api/TenantGeneralSettings_Index_vTaxCalculationBasisOptions` (`Code`,`Name`) | existing | | none |
| Tax period | `TaxPeriod` | select from `/api/TenantGeneralSettings_Index_vTaxCalculationFrequency` | existing | | none |
| Tax calculation method | `TaxCalculationMethod` | select; values `Row Total` and `Total` | HTML | every transaction form: `window.TaxPrecision = (method == 'Row Total') ? 2 : 4`. `UpdateTaxAndTotal(record)` (Main2019): line total = `DEARRound(Quantity * DEARRound(Price*(100-Discount)/100, 4), 2)`; tax = `DEARRound(Total*TaxPercent/100, TaxPrecision)`. Purchase uses `DEARRoundPriceForPurchase` (7 dp unless Xero, then 4). | Warnings toggled by `UpdateTaxCalculationMethodWarning`: `#trXeroTaxMethodWarning` when Xero and method `Total`; `#trQBUSTaxMethodWarning` when QuickBooks, method `Row Total`, tenant currency `USD`; `#trQBGlobalTaxMethodWarning` when QuickBooks, method `Total`, currency not `USD`. Texts are in the HTML, not the bundle. |
| Lock date | `LockDate` | datepicker (`dearDatepicker`, autoclose) | blank | saved `YYYY-MM-DD` or ''. AccessInfo returns `TenantLockDate` -> `window.TenantLockDate`; transactions dated before it count as locked (`Sale_Index_IsInLockedPeriod`, `StatusTracker.invoice.IsLocked`, `...creditNote.IsLocked`, `IsPaymentLineLocked`, purchase `LockDate`). Block `#periodLockDateBlock` is never hidden (`IsLockDateDisabled` always false). | `Editing has been disabled as transaction takes place in locked period.`; `Selection has been disabled as transaction takes place in locked period.` (dimension controls tooltip); `You cannot delete a payment within a locked period.`; `Purchase cannot be added: your accounts are locked {0}`; `The task cannot be added: your accounts are locked {0}.`; `The production run cannot be added: your accounts are locked {0}` |
| Unrealised foreign currency gain/loss | `UnrealizedForeignCurrency` | checkbox | HTML | server | none |
| Carry forward | `CarryForward` | checkbox | HTML | server | none |
| Reverse current-year depreciation when assets are sold | `ReverseCurrentYearDepreciationWhenAssetsAreSold` | radio Y/N | HTML | server | none |
| Chart of accounts type | `ChartOfAccountsType` | select `flat` / `tree` | HTML | `tree` option disabled with subtext `(not allowed when Xero or QuickBooks is active)`. Choosing `flat` makes the delimiter input read-only. Main2019 `setChartOfAccountsData` -> `window.treeModeData`; `Common_COA_TreeMode_*` swap placeholder delimiters for the real one in all account pickers. | none |
| Tree delimiter | `ChartOfAccountsTreeDelimiter` | text | HTML | on change/keyup the placeholder characters `treeModeData.dotPlaceholder` and `delimiterPlaceholder` are stripped; allowed-symbols hint `#ChartOfAccountsSymbols` shows `{delimiterPlaceholder}, {dotPlaceholder}` | none |
| Accounting dimensions | `IsAccountingDimensionsEnabled` | checkbox | off | turning ON asks first; turning off is immediate. When on shows `#AccountingDimensionsPriorityMode`. About 35 bundles (sale, purchase, journal, product, MO, supplier, bank forms...) read `IsAccountingDimensionsEnabled`. | dialog `Confirmation`: `Accounting dimensions will be applied for all tasks.` newline `Do you want to switch on the setting?` (Yes/No, Yes is red) |
| Accounting dimensions priority | `AccountingDimensionsPriorityMode` | select; one value is `DefaultValuesTopPriority` | existing | every change asks to confirm and reverts on No; SimpleSale shows `#spnFinancialPrefillPriority` or `#spnFinancialPrefillNotPriority` text depending on whether the mode is `DefaultValuesTopPriority` | dialog `Confirmation`: `Accounting dimensions changes will be applied for all tasks.` newline `Do you want to change the setting?` |

Xero / QuickBooks effects found in this page

- Xero tenant: `financialSettings` visible, `fixedAssetNumbers` hidden; chart of accounts tree disabled; Main2019 sets `PriceDecimals = 4` and `PurchasePriceDecimals = 4`; non-Xero tenants get `PriceDecimals = 4`, `PurchasePriceDecimals = 7`. Also the New Product vs New Asset menu entries swap (Xero: product; others: fixed asset).
- Settings tiles `FixedAsset` and `Bank` hidden for Xero (index page).

## 2. RMA return order settings (`RMAReturnOrderSettings2019`, access key `RMASetup`)

GET/POST `/api/RMA_Index_Settings`. Not part of `vTenant`.

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Return receipts location | `DefaultReturnLocationID` | ExtJS combo (`/api/RMA_Index_vLocation`), `emptyText: 'Choose...'` | none | default receiving location on a return order | `Please select values for all controls.` (error, save blocked) |
| No-warranty expense account | `NoWarrantyExpenseAccount` | combo (`/api/RMA_Index_ExpenseAccounts`) | none | RMAReturnOrder keeps `...Name` copies | same |
| Warranty expense account | `WarrantyExpenseAccount` | combo | none | | same |
| Scrap / write-off default expense account | `ScrapWriteOffDefaultExpenseAccount` | combo | none | stored on the return order as `ScrapWriteOffDefaultExpenseAccount` | same |
| Create credit note | `CreateCreditNoteType` | selectpicker `#CreateCreditNoteType`; values HTML | HTML | copied onto each RMA / return order (`CreateCreditNoteType`) and drives credit-note creation per line; actual values are in the HTML | none |

Validation: all four combos are mandatory; `RMAReturnOrderSettings_Index_Validation` returns false when any is empty. Save success `Changes saved successfully.`; failure shows the server `Message`. Controls disabled for `IsReadOnly`. Combos are tree-mode aware (`Common_COA_TreeMode_RestoreCodes`). `Ctrl+S` is swallowed. A new record gets a client guid ID.

## 3. Notification settings (`NotificationSettings2019`, `NotificationSettingsNotifications2019`, `NotificationSettingsMailingList2019`)

Page: access key `NotificationSettings`; feature `Notifications` (module trial, read-only after expiry via `NotificationSettings_Index_MakeReadOnly` which hides `.notification-type-wrapper`).

Notification definition (`vNotificationSettings`, GET `/api/NotificationSettings_Index_vNotificationSettings?module=`): `IsActive`, `ModuleName`, `NotificationType` (`event` or `notification`), `Name`, `Description`, `SystemName`, `IsInternal`, `IsEmail`, `IsExternal`, `Message`, `EmailSubject`, `EmailTemplate`, `TemplateID`, `TemplateRequired`, `AllowPeriods`, `Period`, `StartExecutionDate`, `CustomEmail`, `SendToRelated`, `SendToSaleRep`, `EmailTypes`, `MailingListIDs`, `ConditionParameter(Value)`, `DeliveryMethods`, plus server flags `AllowCustomEmail`, `AllowSendToRelated`, `AllowSendToSaleRep`, `AllowConditionParameter`, `AvailableEmailTypes`, `Group`, `SubGroupName`, `TemplateParameter` (JSON list of placeholders shown as popover buttons).

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Active | `IsActive` | switch per notification (list row `cbIsActive_<id>`) | per definition | list reverts the switch if the server rejects | none |
| Delivery: in-app | `IsInternal` | checkbox | from definition | row visible only if `DeliveryMethods` contains `internal`; disabled when it is the only method; shows tab `#tab_Internal` | `Please specify a message.` when ticked and `Message` blank |
| Delivery: email | `IsEmail` | checkbox | | only if `email` in `DeliveryMethods`; always disabled for sub-group `Supplier`; shows tab `#tab_Email` | `Please specify the email template.`, `Please specify the email subject.`, `An email recipient is not specified.` (see below) |
| Delivery: external (webhook/URL) | `IsExternal` | checkbox | | only if `external` in `DeliveryMethods`; shows tab `#tab_External` | `Please specify at least one external URL.` (when active and none) |
| Any delivery | | | | | `Please specify the delivery method.` when all three are off |
| Message | `Message` | textarea | | trimmed | |
| Email subject / template | `EmailSubject`, `EmailTemplate` | text, TinyMCE rich editor | | the template must have non-blank plain text | |
| Document template | `TemplateID` | select from `/api/NotificationSettings_Index_vTemplate`; shown only when `TemplateRequired` and (email or external) is on | | `Please specify the document template.` when `TemplateRequired` and blank | |
| Recipients | `SendToRelated`, `SendToSaleRep`, `EmailTypes` (comma list of AllActiveUser, AllCompanyContact, CustomEmail, MailingList), `CustomEmail`, mailing lists | checkboxes, text, select2 multi | | each option shown only when the definition allows it (`AllowSendToRelated`, `AllowSendToSaleRep`, `AllowCustomEmail` with `AvailableEmailTypes`). Email is valid if at least one recipient source is chosen unless `InternalEmail` is in `AvailableEmailTypes` | `An email recipient is not specified.` |
| Schedule (type `notification` only) | `Period`, `StartExecutionDate` | select + date + time | | `event` notifications hide both. Period list: `5minute` Every 5 minutes, `10minute`, `15minute`, `20minute`, `30minute`, `hourly` Hourly, `daily` Daily, `weekly` Weekly, `monthly` Monthly; restricted by the definition's `AllowPeriods`. Start date + time (24h `H:mm`) combined into one datetime. | none |
| Condition | `ConditionParameterValue` | rule builder, saved as JSON | | shown only if `AllowConditionParameter` | none |
| External call | `vExternalNotificationSettings` rows: `ExternalURL`, `ExternalAuthorizationType` (`noauth`, `basicauth`, `bearerauth`), `ExternalUserName`, `ExternalPassword`, `ExternalBearerToken`, `ExternalHeaders` (JSON list of key/value, empty keys dropped), `IsActive`, `IsWebhook` | grid (`External URL`, `Type`=`Webhook` if `IsWebhook`) + form | auth `noauth` | basic shows user and password rows; bearer shows token row | `Please specify the external URL.`; `URL should begin with 'http://' or 'https://'`; `User name is required for the selected authorization type.`; `Password is required for the selected authorization type.`; `A token is required for the selected authorization type.`; delete confirm `Are you sure you want to delete the external URL?` |
| Restore defaults | GET `/api/NotificationSettings_Index_DefaultSettings?systemName=` | button | | resets email/message/delivery/period/recipients/start date, clears condition and external rows | confirm `Are you sure you want to restore all settings to default?`; success `Successfully restored.` |
| Save | | | | success toast `Successfully saved.`; multiple errors joined with `<br/>` in one error toast | |
| Execution logs | `/api/InternalNotificationLog`, `/api/EmailNotificationLog`, `/api/ExternalNotificationLog` (`deliveryType` 0 internal, 1 email, 2 external) | grids, remote sort/paging | | empty text `You do not have any records at the moment.` | |

Mailing lists (`vMailingList`: `MailingListID`, `Name`, `Emails`): `Emails` is a comma list; the table view trims and drops blanks; memo view joins with `, `. Name must be unique across the store.

| Mailing list rule | message text |
|---|---|
| duplicate name | `A mailing list with the same name already exists.` |
| delete confirm | `Are you sure you want to delete the mailing list?` |

## 4. MRP run settings (`MRPRunSettings`, route MRP run page)

Not a tenant setting but a saved parameter set per run (GET/POST `/api/MRP_vMRPSettings`, run `/api/MRP_Run`, long-run probe `/api/MRP_CheckLongExecution` after 15 s). Feature trial `MRP` (expired: `#btnRun` disabled). Named configurations: `#cmbSavedSettings` + `Save as` dialog.

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Planning period | `PlanningPeriodStart`, `PlanningPeriodEnd` | date range popup with presets current week/next week/current month/next month, custom from/to | none | | `Please select the planning period range.`, `Please select 'From' date.`, `Please select 'To' date.`, `Start date cannot be later than end date for the planning period.`, `End date cannot be in the past.` |
| Locations | `Locations[]` | multi-select combo; value '' = `Every location` (selecting Every clears others and vice versa) | Every location | | none |
| Customers | `Customers[]` | multi-select, remote search | none | any customer selected: hides/clears `IsIgnoreStockOnHand`, hides `IsDemandTransferDraft` and `IsDemandAssemblyDraft` (toggleDependsOfOther) | `Please select sales demand for chosen customers.` when customers chosen but no sales-demand option |
| Ignore stock on hand | `IsIgnoreStockOnHand` | checkbox (saved only if visible) | off | on: unticks and disables both "procure up to" boxes and re-evaluates past-due demand | none |
| Procure up to stock level / minimum before reorder | `IsProcureUpToStockLevel`, `IsProcureUpToMinimumBeforeReorder` | two checkboxes that behave as radio (selecting one clears the other) | off | either ticked: `IsIncludePastDueDemand` forced on and disabled | none |
| Include past-due demand | `IsIncludePastDueDemand` | checkbox | off | mirrors the `Authorised` option of sales demand | none |
| Include draft and planned supply tasks | `IsIncludeDraft` | checkbox | off | | none |
| BOM explosion | `IsBomExplosion` | checkbox | off | on: forces production-released and assembly-released demand boxes ticked and disabled | none |
| Include forecast | `IsIncludeForecast`, `ForecastID`, `SalesForecastTemplateName` | checkbox + upload CSV / template | off | forecast buttons shown only when ticked; upload button disabled when a template other than the first two entries is chosen | upload: `Please upload file in .csv format` (`The file has incorrect format and cannot be uploaded. Please upload file in .csv format.`), `Uploaded file has invalid data. Please see the errors in details.`, `Import cannot be completed - the file is empty.`, `The forecast has been uploaded successfully.`, `An error occurred during file uploading.`; row rules: `{0} cannot be empty.` (Demand location, Product SKU), `Please enter a valid quantity. Only positive numbers are allowed.`, `Demand quantity cannot be equal to 0.`, `Please enter required by date in the format {0}.`, `Product SKU cannot be duplicated.` (same SKU+location+date) |
| Demand source | `DemandSales` (radio-like checkboxes in `#divDemandSales`, one is `Authorised`), `IsDemandProductionDraft/Planned/Released`, `IsDemandAssemblyDraft/Released`, `IsDemandTransferDraft` | checkboxes (saved only if visible) | none | | `Please select demand source, upload forecast, or procure up to stock level or minimum before reorder to calculate the demand.` when none of: procure, a demand-source group, forecast |
| Supply task defaults | `SupplyTask` (0 default), `SupplyTaskPurchaseStatus`, `SupplyTaskTransferStatus`, `SupplyTaskProductionOrderStatus`, `SupplyTaskAssemblyStatus` | selects | `DRAFT` each | statuses given to tasks created from suggestions (`Service.A.taskDefaultStatus`) | none |
| Consolidate purchase suggestions | `ConsolidationType` | checkbox, saved as `purchase` or null | off | | `Select at least two supply suggestions to merge.`, `Only purchase supply orders can be merged.`, `Selected supply suggestions must have the same supplier and same location.` |
| Load details | `IsLoadDetails` | checkbox | off | | none |

Other run messages: configuration name `Please input a unique name to this parameter configuration to save it for future MRP runs.`; reset confirm `Are you sure you want to reset run settings to default state?`; success `MRP settings have been saved successfully.` / `MRP has been run successfully.`; concurrency dialog `MRP run is in progress` (`The user {0} is already running MRP ({1}). Please wait until the calculation is completed. It might take several minutes.`); close run `You are about to close the MRP run. The MRP run will not be available to continue work for other users when completed.`; void `Are you sure you want to void supply order? \nVoiding of orders causes changes in demand. \nPlease re-calculate MRP run.`; recalc `Are you sure you want to re-calculate demand and suggested supply orders?`; `Required by date can not be in the past.`; split order `Quantity can not be greater than quantity in the original supply order.`, `This product has already been added.`, `Please select a product to split the order.`

## 5. ForesightAI / Inventoro settings (`InventoroSettings2019`)

Visibility: AccessInfo `InventoroEnabled` and `InventoroSettingsEnabled` (Main2019 hides the nav items `.js-inventoro-*` when false; Settings nav also hidden when `InventoroSettingsEnabled` false). Trial 14 days (`Inventoro`); after expiry the page shows `Trial expired on {date}.` and a "ForesightAI is coming soon" note. Endpoints `api/InventoroSettings_Locations`, `_Products`, `_ProductSegments`, `_Strategy`, `_Suppliers`, rules, logs.

Tabs: Products, Locations, Suppliers, Product strategy, Product rules; activity logs for each (log pages `Products`, `Locations`, `Suppliers`, `Product strategy`, `Product rules`).

| Setting | field | control & values | default | what it changes | message text |
|---|---|---|---|---|---|
| Product: ForesightAI active | `IsActive` (per product-location, overrides `DefaultIsActive`) | grid check | inherit | | none |
| Product: can be ordered | `CanBeOrdered` | grid check (rule value `RuleCanBeOrdered`, default true) | true | | none |
| MOQ | `MinimumOrderQuantity` | int cell, min 0, max 2147483647 (MAX_INT32) | blank | bulk key `MOQ` | bulk modal: `Please specify a MOQ`, `The maximum value for MOQ is {max}`, `The minimum value for MOQ is {min}` (pattern for all bulk fields) |
| Packing qty | `Packing` | min 1 | blank | bulk `PackingQty` | same pattern |
| Min inventory | `MinimumStockQuantity` | min 0 | blank | bulk `MinimumInventory` | |
| Max inventory | `MaximumStockQuantity` | min 1 | blank | bulk `MaximumInventory` | |
| Max days for stock | `MaximumStockDays` | min 1 (column hidden) | blank | bulk `MaxDaysForStock` | |
| Reorder period | `OrderPeriod` (default `DefaultOrderPeriod`) | min 1 | location/supplier default | bulk `ReorderPeriod` | |
| Lead time | `Lead` (default `DefaultLeadTime`) | min 1 | default | bulk `LeadTime` | |
| Segment | `Segment` | read-only column; segments from `api/InventoroSettings_ProductSegments` | | | |
| Bulk change dialogs | | text restricted to digits and `eE`; "Clear value" check disables the box | | | |
| Location: ForesightAI | `IsActive` | grid check | | | `At least one location must remain Active. Please activate another location before setting this one to Inactive.` |
| Location: Assembly | `IsProduction` | grid check | off | enabling asks which BOMs get default lead time/period ("Only n of m BOMs without individual Lead time/Period being set" / "All n BOMs"); disabling stops assembly/production order proposals for those BOMs. Cannot be disabled for all locations or for a co-manufacturing location. | `Assembly cannot be disabled for all locations.`, `Assembly cannot be disabled for a Co-manufacturing location.` |
| Location: Co-manufacturing | `IsCoManufacturing` | grid check | | | |
| Location: parent | `ParentID` | drag & drop tree, max depth 6 levels (`_MAX_HIERARCHY_LEVEL` 5 means 5 below the root) | | | `Can't move under this location as the maximum hierarchy depth is 6 levels.`; `Setup automatically` confirm: `This will override your current Locations settings. This action cannot be undone. Are you sure?`; success `Locations hierarchy has been set up successfully` |
| Location: transfer lead time / period | `TransferLeadTime`, `TransferPeriod` | int min 1, child locations only | 1 and 7 | | |
| Location: assembly lead time / period | `ProductionLeadTime`, `ProductionPeriod` | int min 1, assembly locations only | 1 and 7 | | |
| Supplier: minimum order amount | `MinimumOrderAmount` | bulk modal, label `Minimum order amount ({tenant currency})` | | | same bulk pattern |
| Supplier: purchase order period / lead time | | bulk modals `Purchase order period`, `Lead time`, `Set period and time` | | | |
| Product strategy | `api/InventoroSettings_Strategy` | modal `Change product strategy`: `Do you want to change from {A} to {B}?` | | affects all ForesightAI calculations (reports, forecast graph, Winners, Losers, Chasers) | |
| Product rules | `Rule name`, `Priority`, `Conditions` (drag to reorder) | rule grid with affected-products view | | rules feed `Rule*` values over product cells | `{name} rule deleted successfully.`; filters: `Please specify a Filter name`, `Filter has been saved successfully`, `At least one parameter is required.` |

## 6. Cross-setting dependencies

- Currency change blocked once any transaction exists (`HasTransactions`); tax field labels follow currency (AUD/NZD/GBP/other); tax display-name row only for USD (non-Xero).
- `FillInvoiceDateOption = SALE_SHIPMENT_DATE` removes `DefaultShipDate = Invoice` and forces `Current`.
- `FillInvoiceDateOnOrderAuthorisation` x `FillInvoiceDateOption` x shipment status decide the invoice date (rules in 1.3).
- `AutomaticallyApplyDiscounts` controls visibility of `ApplyManualPriceChanges`; off forces `ApplyManualPriceChanges=false`; on sale forms it triggers an automatic discount pass before authorising quote and order (only if the tenant has at least one discount).
- `SkipQuote` hides the quote step and bypasses quote approval; `AllowQuoteApproval` / `AllowPurchaseOrderApproval` add approve/reject buttons and block moving on until approved (except skip-quote, authorised invoice, authorised stock).
- `AllowOrderNoAlloc` adds the "authorise without allocation" menu and the `AUTH_NO_ALLOC` status.
- `SkipPack` auto-completes the pack from the pick; `SkipShip` (advanced sale) controls whether an empty shipment draft is cleared.
- `UsePurchasePutAway` adds an intermediate put-away status to purchase stock receipts and removes the copy-from-PO button.
- `InventoryAccrual` reveals the accrual and stock-in-transit accounts; accrual account is mandatory on save.
- `SkuAutogeneration` locks the product code field (placeholder `auto-generated`); `Stock*` numbering is the source.
- `AllowArchiving` shows the two archive periods; archive buttons appear on sale and purchase only when enabled.
- `Accounting dimensions` on + `AccountingDimensionsPriorityMode` change need explicit confirmation and apply to all tasks.
- `ChartOfAccountsType = tree` forbidden when Xero or QuickBooks is connected; flat disables the delimiter.
- `MOCreateProductionOrder = saleOrder` reveals the sale-order container (MOProduce); `MOWastageType = auto` reveals the wastage expense account; `MOTraceFinishedProduct = 1` removes the issue-method UI.
- `MOProduce` values `requiredInSalesAndReorder` and `availableMinusRequired` make the production order form propose a different quantity (confirm dialog).
- Attribute set "copy from" requires a non-"Not defined" attribute set in the same row; both validate on save.
- Price tiers above the subscription limit are read-only `Not Available` and excluded from save.
- Lock date interacts with accounting dimensions (dimension inputs disabled for lines in locked periods), payments (cannot delete), additional COGS (cannot edit), purchase expense distribution (cannot add).
- Xero: price decimals 4/4, no fixed asset numbering, no tree chart; QuickBooks: no tree chart, tax method warnings, wider gift card account list.
- Role-based permissions (QuoteView, OrderAuthorisation, Margin, PricesDiscounts, FinancialData, Void, Undo ...) arrive in the same sale reference data as the tenant settings; they hide tabs and columns but are not tenant settings.

## 7. Not determinable statically

- Labels, help text, dropdown option lists and defaults for most General Settings controls (they are in server-rendered HTML): Document sort orders, Customer credit limit mode, Reorder mode, Export encoding, Date format list, Time-of-invoice-number options, Decimal places options, Password change frequency, Session timeout list, Archive periods, Gift card expiry list, `CreateCreditNoteType` options, MO select options (except the values named above), `RecommendBatchSN` labels.
- Server effects with no client read: `AutoPick`, `UseLatestPurchaseCost`, `CustomerCreditLimitMode` computation, `CreditHoldGracePeriod` arithmetic, `ApplyCustomerDiscountAfterOtherDiscounts`, `RecurringInvoicePriceHandlingMethod`, `InvoiceNumberTimePoint`, `DecimalPlacesInQuantity`, `SearchOnlySupplierAttachedProductsInPurchaseLines`, `IgnoreExpiredBatch`, `UpdateStockReceivedDateOnLocationTransfer`, `SplitAutoAssembly`, `PickFromAllLocations`, `MOIsStockTransferAuto` and the other MO auto flags, document sort orders, email settings (`AddEmailSenderToCC`, `GlobalBcc`, `RequestMailReceipt`, `EmailSender`), `ExportEncoding`, `PasswordChangeFrequency`, archive periods.
- Text of the Xero / QuickBooks tax-method warning rows and the card-on-file owner hint (HTML).
- Meaning of numbering codes `ST`, `TR` (labels only in HTML) and exact sequence behaviours (zero padding, wrap), which are server side.
- What exactly `IsTradingHelperTurnedOn`, `GiftCardDefaultAccount` and country-specific keys change (loaded from per-country scripts).
- Whether hidden required fields (accrual account while accrual is off) block the save: that depends on `__HighlightInvalidFields.validation`, which is defined in another bundle and was not read.
- Notification default definitions (names, groups, default templates) come from the server; only the editing UI is in the bundle.
- Bundles not read for this file: TaskSettings2019, ScheduledReportSettings2019, RMAReturnPolicy2019, RMAReasonForReturn2019, B2B / POS / API settings, integration settings pages (Shopify etc.).
