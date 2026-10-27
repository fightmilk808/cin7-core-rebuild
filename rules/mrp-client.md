# MRP: client-side behaviour of Cin7 Core (from shipped page scripts)

Source: static reading of the public, minified ExtJS page bundles (beautified copies; never executed, no calls to Cin7).
Bundles: `MRPRunSettings.js` (the run page: settings, demand report frame, suggestions, results, errors, log), `MRPList.js` (run list), `MRPScheduler.js` (Gantt "supply vs demand" view; it also embeds a copy of the run-page service code and the purchase/transfer/production status maps), plus inputs that feed MRP: `TenantLocationEdit.js` (supply rules, transfer planning methods), `LeadSafetyValues2019.js`, `GeneralSettings2019.js`, `ProductionOrder.js`, and helpers in `Main2019.js`. The three `Reorder*2019.js` bundles do not call any MRP endpoint (see section 11).
Rule references are `Bundle :: function` (line numbers move between beautifiers, so function names are the anchor). Page to bundle mapping is in `spec/modules/16-mrp/UI.md`.
Scope: only what the browser decides. What the server decides is at the end under "Not determinable statically". Message text is verbatim from the scripts.
No tenant data appears here. Everything is a rule, a constant or a message string.

Conventions in the scripts: `Dear_Notification_Error/Warning/Success/Info` are toast notifications; `dearSwal({...})` is a modal confirm (`confirmButtonClass: 'btn-danger'` on every destructive one); `dearHelper.blockUI.show()` is a full-page spinner; `ProcessException(response, operation, null)` is the shared store-error handler. Default error toast (`MRPService.defaultErrorText`): `An unhandled error occurred. Please try again and if it appears again contact support.`

---

## ⚠️ Gotchas: the sneaky stuff

The easy-to-miss behaviours, worst first. `CAUTION` = silently corrupts data, cost or stock, is irreversible, or fails silently. `WARNING` = a surprising rule that breaks a rebuild if missed. `NOTE` = the sources disagree. Each links to the full rule below.

> [!CAUTION]
> **Options hidden by another option are saved as false**
> Settings are read with `:checked:visible`, so choosing a customer hides and unticks Ignore stock on hand, Transfer draft and Assembly draft. They are then saved as false with no message. See [section 2.3](#23-dependencies-and-enabledisable-conditions-generalsettings--addlisteners-toggledependsofother).

> [!CAUTION]
> **Complete closes the run for everyone**
> The confirm says the run "will not be available to continue work for other users when completed". The page then leaves for the run list. See [section 2.7](#27-run-complete-long-run-handling).

> [!CAUTION]
> **Voiding an order changes demand but does not recalculate**
> The row becomes VOIDED and the toast tells you to re-calculate; nothing refreshes until you do. See [section 8](#8-results-tab-results).

> [!WARNING]
> **Procure up to forces overdue demand on, and overdue ticks "Authorized" sales**
> Ticking either Procure up to box ticks and disables Include overdue demand, and ticking Include overdue demand also ticks the Authorized sales source. The visible state is not what you set. See [section 2.3](#23-dependencies-and-enabledisable-conditions-generalsettings--addlisteners-toggledependsofother).

> [!WARNING]
> **The planning period cannot start before today**
> Both date fields have a minimum of today and the end cannot be in the past. A "This week" preset starts today, not on Monday. See [section 2.2](#22-planning-period-planningperiod).

> [!WARNING]
> **A saved parameter set carries its planning period and forecast**
> The code that should strip them is a no-op, so they are saved with the set; reloading it later can bring back old dates (consequence inferred). See [section 2.6](#26-saved-parameter-sets-savesettings).

> [!WARNING]
> **A concurrent run, delete or complete abandons your action**
> If another user is running MRP, a modal says who and sends you to the list. Any reply flagged deleted, completed, recalculating, failed or running abandons the original action. See [section 2.7](#27-run-complete-long-run-handling).

> [!WARNING]
> **Required-by dates are locked unless the order type changed**
> Editing is blocked while `IsSupplyTaskChanged` is false (a server flag); a date before today is reverted with a warning. See [section 6.4](#64-cell-editing-rules-createcellediting).

> [!WARNING]
> **Changing the order type wipes the supplier and resets the status**
> The supply field is cleared, status returns to the run-setting default and the order date is set to the required-by date. Production rows only offer shop-floor locations. See [section 6.3](#63-changing-the-order-type-adjustsupplytaskstore).

> [!WARNING]
> **"Awaiting approval" disappears without order approval**
> If tenant order approval is off, the purchase status is removed from both the run settings and the suggestion grid. See [section 6.1](#61-status-options-per-order-type-adjuststatusstore).

> [!WARNING]
> **Forecast CSV is strict about dates and headers**
> Dates must be YYYYMMDD and the five headers exact. A blank required-by date is allowed and the product name is never validated. See [section 2.5](#25-forecast-upload-forecast).

> [!NOTE]
> **The "Scheduler" is a Gantt chart, not a recurring job**
> It has no frequency, time of day or recipients, and persists only view settings in `localStorage`. See [section 12](#12-mrp-scheduler-mrpschedulerjs).

---

## 1. Pages, routes and permissions

| Route | Bundle | Access check | Notes |
|---|---|---|---|
| `/MRPList` | `MRPList.js` | `CheckAccess('MRP','Run', ...)` | Run list. Starts `FeatureTrials_Init('MRP')`. |
| `/MRP` (new run) and `/MRP#<guid>` (existing run) | `MRPRunSettings.js` | `CheckAccess('MRP','Run', ...)` | The id is `window.location.hash.substr(1)`. It is only treated as a run when it matches the GUID regexp `^[0-9a-fA-F]{8}-...-[0-9a-fA-F]{12}$` (`isValidGuid`, `MRPService.isGuid`). |
| `/MRPScheduler#<guid>` | `MRPScheduler.js` | `CheckAccess('MRP','Run', ...)` | Opened from the run page; breadcrumb link `aMRPBreadcrumb` -> `/MRP#<id>`; `btnBack` -> `/MRP#<id>`. |

- Feature module gate: `FeatureTrials_Init('MRP')` calls `GET /api/TenantAccessToFeatures?feature=MRP`. When the module is not part of the subscription the page becomes read-only (`FeatureTrials_MakeReadOnly` disables `#btnRun`) and a banner is shown in `#FeatureModuleDetailsBlock`: `This module is not currently part of your subscription. Would you like to trial this feature for 30 days?` with a `Start trial` button (`POST /api/TenantAccessToFeatures {feature}`; failure toast `Something went wrong. Please try again later.`). Active trial banner: `You have {n} days left on your trial of {installation company} {feature} module. If you would like to add it to your subscription, click here.` Expired: `Your trial of this feature expired on {D MMMM YYYY}. If you would like to add this module to your subscription, click here.` (`MRPRunSettings :: FeatureTrials_Init`).
- `window.IsReadOnly` (role without write on MRP) disables: reset, all setting checkboxes and selects, forecast buttons, customer and location combos, Confirm, Recalculate, Merge-selection editing, void buttons, cell editing of suggestions and the split dialog.
- Run-page "state" flags derive from `GET /api/MRP_vMRP?ID=<id>` (`MRPRunSettings :: load`): `Status` and `Version`.
  - `isCompleted = Status === 'Completed'`.
  - `isInProcess = ['Active','Running','Recalculating'].includes(Status)`.
  - `MRPVersion = data.Version`; `MRP_CURRENT_VERSION = 4`. When `MRPVersion === 4` the Errors tab shows the severity sub-tabs (Critical / Warning / Information); otherwise they stay hidden (`Errors :: createControls`).
  - Statuses the client tests: `Active`, `Running`, `Recalculating`, `Completed`, `Failed` (list: a `Failed` row is not clickable). Reply flags it tests: `IsDeleted`, `IsCompleted`, `IsRecalculating`, `IsFailed`, `IsRunning`, `IsTerminated`.
- Button enablement (`MRPService.updateBtnsAbility(state)`): `Run` disabled if read-only, completed, or a run already exists (`state` truthy). `Complete` disabled if read-only, completed, or no run yet (`!state`). The page calls `updateBtnsAbility()` (no run) on load and `updateBtnsAbility(true)` after a run is shown (`showRunResults`).
- "View Scheduler" button (`#btnOpenScheduler`) is shown only when `Status === 'Active' && IsLoadDetails === true`, linking to `/MRPScheduler#<id>` (`updateOpenScheduledButton`). The "Show on Scheduler" button (`#btnScheduler`) is never wired in the bundle.
- A banner `#alertDetailsDeleted` (`All MRP run details have been deleted.`) is shown when the run payload has `IsDetailsDeleted === true`.
- Leaving with unsaved settings: `beforeunload` returns `There are unsaved changes. Do you really want to leave this page?` when `GeneralSettings.arePendingChanges()` (settings changed since last save/run, or planning period changed).
- Reference data (`GET /api/MRP_ReferenceData`, retried up to 2 times on store exception): the only field the client reads is `IsOrderApprovalEnabled` (see 10.1). The run page does not render until this store has loaded.

---

## 2. Run settings (page `/MRP`, `MRPRunSettings.js`)

Model `vMRPSettings` (`GeneralSettings :: createModels`). The run is started with one settings record; a settings record is also what "Save as" stores as a named parameter set.

### 2.1 Field table

| Label (UI) | Control id | Model field | Control | Options / values | Default (after "Reset settings") |
|---|---|---|---|---|---|
| Load demand with details | `chkIsLoadDetails` | `IsLoadDetails` | checkbox | | unchecked (undefined) |
| Planning period | `btnPlanningPeriod` (dropdown) + `cmbPlanFrom` / `cmbPlanTo` date fields | `PlanningPeriodStart`, `PlanningPeriodEnd` | preset menu + From/To dates + Apply | `This week`, `Next week`, `This month`, `Next month`, custom range (see 2.2) | none: placeholder `Choose...`, required |
| Location | `cmbLocation` (multi-select combo, remote) | `Locations[]` (`vLocationID {LocationID, Name, MRPSettingsID}`) | `Ext.ux.ComboBox` multiSelect, typeAhead, `minChars 0`, `forceSelection`, `queryParam 'Name'`, store `GET /api/MRP_vTenantLocation` | First entry is a synthetic `Every location` with ID `''`. | `Every location` (`LocationID ''`) |
| Customer | `cmbCustomer` (multi-select combo, remote) | `Customers[]` (`vCustomerID {CustomerID, Name, MRPSettingsID}`) | same combo type, store `GET /api/MRP_vCustomer`, `valueField CustomerID` | | empty |
| Ignore stock on hand/on order | `chkIgnoreStockOnHand` | `IsIgnoreStockOnHand` | checkbox | | false |
| Procure up to > Stock level | `chkProcureUpToStockLevel` | `IsProcureUpToStockLevel` | checkbox (acts as radio) | | false |
| Procure up to > Minimum before reorder | `chkProcureUpToMinimumBeforeReorder` | `IsProcureUpToMinimumBeforeReorder` | checkbox (acts as radio) | | false |
| Include overdue demand | `chkIncludePastDueDemand` | `IsIncludePastDueDemand` | checkbox | | false |
| Include draft and planned supply orders | `chkIncludeDraftAndPlannedSupplyTasks` | `IsIncludeDraft` | checkbox | | false |
| BOM explosion | `chkBomExplosion` | `IsBomExplosion` | checkbox | | false |
| Include forecast demand | `chkIncludeForecast` | `IsIncludeForecast` | checkbox | | false |
| (forecast template) | `cmbSalesForecastTemplate` | `SalesForecastTemplateName` | select | saved forecast templates; first options are the "none"/"upload" entries (see 2.5) | `''` |
| (uploaded forecast) | `fileImportForecast` | `ForecastID` | file input `.csv` | | `''` |
| Demand source > Sales | `rbtnSalesAll`, `rbtnSalesAuth`, `rbtnSalesNotAuth` ("All", "Authorized", "Not authorized") | `DemandSales` (string) | three checkboxes behaving as a radio group (class `js-like-rbtns`) | the checkbox `value` attribute; the `Authorised` value is referenced in code: `input[value="Authorised"]` (other two values are not named in the script) | none selected (`undefined`) |
| Demand source > Production > Include draft / planned / released | `chkProductionDraft`, `chkProductionPlanned`, `chkProductionReleased` | `IsDemandProductionDraft`, `IsDemandProductionPlanned`, `IsDemandProductionReleased` | checkboxes | | false |
| Demand source > Assembly > Include draft / released | `chkAssemblyDraft`, `chkAssemblyReleased` | `IsDemandAssemblyDraft`, `IsDemandAssemblyReleased` | checkboxes | | false |
| Demand source > Transfer > Include draft | `chkTransferDraft` | `IsDemandTransferDraft` | checkbox | | false |
| Supply order status > Transfer order | `cmbTransferStatus` | `SupplyTaskTransferStatus` | select | `Draft`, `Ordered` | `DRAFT` |
| Supply order status > Production order | `cmbProductionOrderStatus` | `SupplyTaskProductionOrderStatus` | select | `Draft`, `Planned` | `DRAFT` |
| Supply order status > Assembly order | `cmbAssemblyStatus` | `SupplyTaskAssemblyStatus` | select | `Draft`, `Authorized` | `DRAFT` |
| Supply order status > Purchase order | `cmbPurchaseStatus` | `SupplyTaskPurchaseStatus` | select | `Draft`, `Awaiting approval` (value `AWAITING`), `Ordered` | `DRAFT` |
| Supply order status > Purchase order supplier | `cmbSupplyTask` | `SupplyTask` (int) | select | `Set up for supply rule`, `With the lowest price`, `With the lowest lead time`, `Latest supplier` (integer values not visible in the script; the first is `0`) | `0` (Set up for supply rule) |
| Consolidate suggestions by source | `chkConsolidationType_Purchase` | `ConsolidationType` | checkbox | checked -> string `'purchase'`; unchecked -> `null`. On load, checked if the stored string contains `purchase` (`indexOf('purchase') != -1`). | unchecked |

Other model fields: `ID` (a fresh `guid()` is generated client-side on every Run/Save: `prepareToSave`), `Name` (set only by "Save as"), `SupplyCalculation` (declared, never read or written by the client).

Settings that live outside the form and change MRP behaviour: see section 10.

### 2.2 Planning period (`PlanningPeriod`)

- Presets (computed with moment, local time) in `selectPeriod`:
  - `current_week` (label "This week"): From = today, To = `endOf('week')`.
  - `next_week`: From = `today + 1 week` `.startOf('week')`, To = `.endOf('week')`.
  - `current_month`: From = today, To = `endOf('month')`.
  - `next_month`: From = `today + 1 month` `.startOf('month')`, To = `.endOf('month')`.
  - The preset code stored on the button (`data('value')`) is one of `current_week`, `next_week`, `current_month`, `next_month`, `custom`. After a preset or Apply the dates are written to the two date fields and the button text is the preset label, or `<From> – <To>` (en dash) in the user's date format for custom (`updateBtnToggle`).
- Both date fields have `minValue` = today (`moment().toDate()`); format is the user date format (`UserDateFormat`).
- Validation (`validateRange`, run when Apply is pressed and again on Run), error toasts joined with `<br />`:
  - `Please select 'From' date.`
  - `Please select 'To' date.`
  - `Start date cannot be later than end date for the planning period.` (when `from > to`)
  - `End date cannot be in the past.` (when `to < start of today`)
- On Run: if no value at all, or `custom` with an invalid range, the control is marked invalid and `Please select the planning period range.` is added to the error list (`PlanningPeriod :: validation`).
- A loaded saved run re-sets the dates; if both are present the button value becomes `custom`, otherwise it resets to the `Choose...` placeholder.
- Dates are sent in ISO (`c`) format. The *Save as* code runs `delete settingsToSave.IsIncludeForecast / PlanningPeriodStart / PlanningPeriodEnd` on the array returned by `convertStoreToArray`, which is a no-op, so those fields are in effect sent with the saved set.

### 2.3 Dependencies and enable/disable conditions (`GeneralSettings :: addListeners`, `toggleDependsOfOther`)

`toggleDependsOfOther($c, flag)`: the control (or its `.form-control` wrapper) is hidden (`hiddenContent`) when `flag` is false, shown when true; a checkbox that becomes hidden is also unchecked and its `change` is fired.

| Trigger | Effect |
|---|---|
| Customer combo `change` | `IgnoreStockOnHand` shown only when at least one customer is chosen (hidden and unchecked otherwise); `Transfer > Include draft` hidden and unchecked when a customer is chosen; `Assembly > Include draft` hidden and unchecked when a customer is chosen (`updateAssemblyCheckBox`; see also BOM explosion). |
| Location combo `change` (`changeLocation`) | "Every location" (`''`) is exclusive: choosing it after other locations clears the selection to just `''` and collapses the list; choosing a real location while `''` is selected removes `''`. |
| `Ignore stock on hand/on order` checked | `Stock level` and `Minimum before reorder` are unchecked and disabled; then `togglePastDueDemand`. Unchecked: they are enabled again. |
| `Stock level` / `Minimum before reorder` (class `js-like-rbtns-procure`) | mutually exclusive (checking one unchecks the other). Then `Include overdue demand` is set equal to "either procure box is checked" and **disabled** while either is checked (`prop('checked', state).prop('disabled', state)`), and `change` is fired on it. |
| `Include overdue demand` `change` | Sets the Sales checkbox whose value is `Authorised` to the same checked state and fires `change`. So ticking "Include overdue demand" also selects the "Authorized" sales demand source. |
| Sales demand checkboxes (class `js-like-rbtns`) | radio-like: checking one unchecks the other two. |
| `BOM explosion` checked | `Production > Include released` and `Assembly > Include released` are forced checked and disabled. Unchecked: they are enabled; `updateAssemblyCheckBox` re-applies the customer rule. |
| `Include forecast demand` | the forecast button block `#divForecastBtns` is shown only while checked. |
| Forecast template select `changed.bs.select` | `Upload forecast` disabled when `!!clickedIndex && clickedIndex !== 1` (i.e. enabled only for the first two entries of the select). |
| Purchase status select | The `AWAITING` option is removed at start-up if tenant `IsOrderApprovalEnabled` is false (`Service.A.isOrderApprovalEnabled`). |
| Run in progress, completed or read-only (`applyAccess`) | Reset, all checkboxes, all `.selectpicker`s, forecast buttons, customer and location combos, and the planning-period toggle are disabled. |
| `prepareToSave` visibility rule | `IsIgnoreStockOnHand`, `IsDemandProduction*`, `IsDemandAssembly*` and `IsDemandTransferDraft` are read with `:checked:visible`, so a hidden (and therefore unchecked) option is always saved as false. |

### 2.4 Validation on Run (`GeneralSettings :: validation`)

Errors are collected and shown in one toast joined with `<br />`; the page scrolls to the first `.invalid` block.

1. Planning period rules (2.2).
2. `Please select demand source, upload forecast, or procure up to stock level or minimum before reorder to calculate the demand.` when all of: neither procure box is ticked, no visible checkbox ticked inside the "Demand source" block (`hasFormGroupSelected` = `:visible:checked`), and no forecast chosen (`forecast.id` set or template select value not `''`).
3. `Please select sales demand for chosen customers.` when at least one customer is chosen but none of the three Sales checkboxes is ticked.

Not validated client-side: locations (empty list is allowed: `prepareToSave` iterates the chosen values; the default after reset is `Every location`), supply status selects (always have a value).

### 2.5 Forecast upload (`Forecast`)

- Hidden until "Include forecast demand" is ticked. Buttons: `Download CSV template`, `Upload forecast`, `Remove` (the last is shown only after a successful upload and replaces Upload).
- Template download: file `MRP-Forecast.csv` containing only the header row `Demand Location,Product SKU,Product Name,Quantity,Required by Date` (`forecastHeaders.join()`).
- Date format required in the file: `YYYYMMDD` (moment strict).
- Client validation of the file before upload (`Forecast :: validation`, `validateData`):
  - empty or whitespace-only file: warning `Import cannot be completed - the file is empty.`
  - header-only file (one row): treated as empty (same warning).
  - header cells must equal the five names exactly and in order; otherwise `The file has incorrect format and cannot be uploaded. Please upload file in .csv format.`
  - per data row (line numbers start at 1 for the first data row), messages joined with `<br />`:
    - `Demand location cannot be empty.` / `Product SKU cannot be empty.` (`{0} cannot be empty.`)
    - quantity empty, not a number, or negative: `Please enter a valid quantity. Only positive numbers are allowed.`; exactly 0: `Demand quantity cannot be equal to 0.`
    - required-by date non-empty and not `YYYYMMDD`: `Please enter required by date in the format YYYYMMDD.`
    - duplicate of another row with the same SKU + demand location + required-by date (only checked when all three are non-empty): `Product SKU cannot be duplicated.`
  - If any row fails: toast `Uploaded file has invalid data. Please see the errors in details.` and the errors dialog `Issues while uploading forecast` opens with `We have found {n} issue(s) with the uploaded file:` and a grid (Line #, Demand, SKU, Name, Quantity, Required by date). An empty-state hint in the grid: `Please upload a file to check for issues.`
  - Product name column is never validated; blank required-by date is allowed.
- Upload: `POST /MRP/ImportForecast` (multipart, field `file`), spinner text `Upload forecast file...`. Response `{Success, ForecastDateID, ErrorLines[]}`. Success: stores `ForecastDateID` as `forecast.id` (sent later as `ForecastID`), hides Upload, shows Remove, disables the template select, toast `The forecast has been uploaded successfully.` Failure: clears, toast `An error occurred during file uploading.`, shows `ErrorLines` in the same errors dialog.
- Remove: clears `forecast.id`, re-enables the template select and Upload.

### 2.6 Saved parameter sets (`SaveSettings`)

- Select `cmbSavedSettings` lists stored sets (`GET /api/MRP_vMRPSettings?limit=1000000`). Choosing one loads it into the form via `set(lines, true)` (the list payload is stored with `loadRawData`, then `setAllValues`). `Delete settings` is disabled when no sets exist.
- `Save as` opens a dialog `Name your parameters set` (field `Parameters set name*`, `maxlength 256`). Validation: name empty or already present (exact match against the loaded sets) -> warning `Please input a unique name to this parameter configuration to save it for future MRP runs.`
- Save: `POST /api/MRP_vMRPSettings` with the settings record (new `ID` guid, `Name`); success needs `data.ID`: toast `MRP settings have been saved successfully.`, option appended and selected; else `data.Message` or default error.
- Delete: `DELETE /api/MRP_vMRPSettings/<id>`; response `{IsSuccess, IsForbidden, Message}`; success toast `Successfully deleted.`; failure shows `Message`; list reloads unless `IsForbidden`.
- `Reset settings`: confirm `Are you sure you want to reset run settings to default state?` (Yes/No) then the defaults in 2.1.
- Status defaults per document type are kept in `MRPService.taskDefaultStatus` (Transfer/Purchase/Production/Assembly, initially `DRAFT`) and refreshed from the settings every time they are loaded or prepared (`updateTasksDefaultStatuses`); they are used when a suggestion's order type is switched (6.3).

### 2.7 Run, Complete, long-run handling

- `Run` (`GeneralSettings :: run`): validate, `blockUI`, `prepareToSave`, then
  - after a 15000 ms timer, `GET /api/MRP_CheckLongExecution` (JSON body of the settings array, timeout 6,000,000 ms). If it answers `Status === 'wait'`: modal `MRP run is in progress` / `MRP run demand calculation may take some time due to the large amount of data being processed.<br /> You can close the page, the calculation will be completed in background.` with only a `Back to list` button -> `/MRPList`.
  - `POST /api/MRP_Run` with an array of one settings record (timeout 6,000,000 ms). Response fields: `IsSuccess`, `MrpID`, `MrpNumber`, `Status`, `IsLoadDetails`, `IsTerminated`, `CreatedBy`, `Message`.
    - success: `location.hash = MrpID`, run panels appear, number shown as `#<MrpNumber>`, settings locked (`isInProcess = true`), toast `MRP has been run successfully.`
    - `IsTerminated`: modal `Calculation was terminated by user` (error, `Back to list`).
    - not success but `MrpID` present (someone else's run is active): modal `MRP run is in progress` / `The user {CreatedBy} is already running MRP ({MrpNumber}). Please wait until the calculation is completed. It might take several minutes.` -> `Back to list`.
    - otherwise error toast with `Message` or the default error.
- `MRPService.isProcessing(data)` is applied to every server reply; if any of `IsDeleted`, `IsCompleted`, `IsRecalculating`, `IsFailed`, `IsRunning` is true it shows modal `Warning` with `data.Message` and a `Back to list` button (plus `Ok` which reloads the page when `IsCompleted`), and the original action is abandoned. This is how concurrent edits/deletes/completes by another user surface.
- `Complete` (`MRPRunSettings :: complete`, also the list-page button): confirm modal `You are about to close the MRP run. The MRP run will not be available to continue work for other users when completed.` with buttons `Complete, anyway` / `Cancel`. `POST /api/MRP_Complete {MrpID}`; success toast `MRP run has been completed.`, clears the stored product filter (`MrpFilter_*` keys), then after a short timeout goes to `/MRPList`.
- Debug/export: a `load_data` document event posts the settings to `POST /api/MRP_LoadDataFromDB` and saves the response as `MRP_Data.zip` (hidden support feature; no UI button in the HTML map).
- Opening a run (`MRP#<guid>`): `load` -> `GET /api/MRP_vMRP?ID=`. If `Status` is `Running` or `Recalculating`, the same `MRP run is in progress` modal (`The user {CreatedBy} is already running MRP ({Number}). ...`) is shown and the user is sent to the list. Otherwise settings are filled from the payload, the number shown, and the result tabs are built.

---

## 3. Result tabs and layout of a run

Tabs (`#ulNavigation`): `Demand`, `Suggested supply orders`, `Results`, `Errors`, `Activity log`. Switching tabs refreshes that tab's grid (`adjustUIToShownTab`); the settings panel (`#divCollapsible`) collapses when a run is shown (`toggleCollapseGeneralSettings(true)`) and can be toggled with the collapser buttons. Search boxes on each tab: Enter or button -> store reload from page 1 with `extraParams.Search` = lower-cased, trimmed text.

Empty-search toasts: Results `No supply orders found. Please try a new search.`; Errors `No supply errors found.`; Log `No actions found.`

### 3.1 Demand tab (report iframe)

- The Demand grid is the Report Service report (`Report/MRPDemand`) loaded in an iframe `iReportFrame` with `src = window.ReportServiceUrl + '&mrpID=' + id` (only when the hash is a GUID). It posts messages to the page (checked against the iframe origin): `resize` (iframe height = `data.height + 30`, applied only if the change is < 0 or > 100), `backtoreports` (-> `/Reports`), `notification` (the payload `command` is `eval`ed by the host page), `openFieldsSpecificationModal`, `dr-body_scrolltotop`, `dlgExportToGDrive`, `globalClick`, and **`mrp-open-details`** (`paramBase64`, `excludeFutureSupply`), which opens the Demand details panel (3.2).
- Info modal `Fields specification` text: `This report shows MRP demands.`
- After Recalculate the iframe is reloaded (`reloadReportDemandService`).

### 3.2 Demand details side panel (`DetailsPanel`)

Opened from the report with `paramBase64` = base64 JSON `{LocationID, ProductID, LocationName, ProductName, SKU, IndependentDemand, DependentDemand, Supply, TotalDemand, SuggestedSupply}`.
- Header lines: `Location:` (link `/TenantLocationEdit#<LocationID>`), `Product:` (link `/Product#<ProductID>`, text `<SKU>:<ProductName>`), `Independent demand:`, `Dependent demand:`, `Supply:`, `Total demand:`, `Suggested supply:` (`n/a` when `SuggestedSupply == null`, which also disables its tooltip and shows `0`; otherwise a link; clicking it closes the panel, switches to the Suggestions tab and applies the filter in 6.5).
- `GET /api/MRP_DemandDetails?mrpID&locationID&productID&excludeFutureSupply` -> array of lines with `EntityType`, `EntityID`, `EntityName`, `Date`, `Quantity`, `ID`, `SourceForDetailsID`, `LocationName`, `ProductName`.
- Grouping rules (`render`):
  - Independent demand = `EntityType` starting `demand.` and `SourceForDetailsID == null`. Table "Independent demand": Document / Required By / Qty.
  - Dependent demand = `EntityType` starting `virtual.` and `SourceForDetailsID == null`. Table "Dependent Demand": Document / Required By / Qty. Each row can expand (arrow) to its parent rows: those lines whose `SourceForDetailsID` equals the row's `ID`, shown as Document / Location / Qty. If the dependent row's `EntityName` is `BOM Components`, parent rows get an extra sub-row with the parent `ProductName`.
  - Current supply = `EntityType` starting `supply.` and `SourceForDetailsID == null`. Table "Current supply": Document / Date / Qty.
  - Each list is sorted by ascending `Date` (`new Date(d1.Date) - new Date(d2.Date)`); empty groups are hidden.
- Entity types (`EntityTypes`): `demand.sale`, `demand.transfer`, `demand.production`, `demand.assembly`, `demand.forecast`, `demand.stocklevel`, `virtual.transfer`, `virtual.production`, `virtual.assembly`, `supply.transfer`, `supply.production`, `supply.assembly`, `supply.purchase`, `supply.stockonhand`. Display names for virtual rows (`EntityNames`): `Virtual TR`, `Virtual MO`, `Virtual FG`, `BOM Components`.
- Document links (`getEntityLink`): purchase -> `/Purchase#id`, transfer -> `/Stocktransfer#id`, assembly -> `/FinishedGoods#id`, production -> `/ProductionOrder#id`, sale -> `/Sale#id`; no link (plain text) for any other type or an empty id. The label is whatever the server returns as `EntityName`.

---

## 4. Suggested supply orders grid (`SupplySuggestions`)

Model `vSupplySuggestion`: `ID`, `MRPID`, `SupplyTask` (string), `DemandLocationID`, `DemandLocationName`, `SupplyID`, `SupplyName`, `RequiredByDate` (date `c`), `DocumentDate` (date `c`), `TaskStatus`, `IsSelected` (bool), `ValidationState`, `ValidationText`, `IsSupplyTaskChanged` (bool); has-many `Products` -> `vSuggestionProduct {ProductID, ProductCode, ProductName, Quantity (float), UnitOfMeasure, ProductBOM, MrpSupplySuggestionID, IsSplitted (bool)}`.

Store: `POST /api/MRP_SupplySuggestions` (paged, `remoteSort`, JSON body = filter data (4.3) plus `LoadProducts: true`), reader root `root`; the reader's `rawData.products` array holds all product lines for the page (matched to rows by `MrpSupplySuggestionID`). Paging message: `Displaying suggestions {0} - {1} of {2}`; empty message `You do not have any supply orders at the moment.`

### 4.1 Columns

| Header | Field | Behaviour |
|---|---|---|
| (arrow) | `clm_expand_row` | Click toggles the row-body (product list) for that row. |
| (validation icon) | `actionColumn_validationstate` | Width 58. Shows icon class `cell-icon btnValidationError` when `ValidationState == 'Invalid'`; clicking opens an error modal with `ValidationText` (class `mrp-supply-suggestion-validation`). |
| (checkbox) | `IsSelected` | Header click selects/deselects all rows of the page. Disabled style when `IsReadOnly`. |
| Supply order | `SupplyTask` | Display via the task store: `Purchase`, `Transfer`, `Production`, `Assembly`. Editable combo (6.3). |
| Products | | Button `Split products` (`js-show-products`) opens the split dialog (7). |
| Demand in | `DemandLocationName` | Read-only. |
| Supply from/buy from | `SupplyID` (shows `SupplyName`) | Editable combo; store depends on order type (6.2). |
| Required by date | `RequiredByDate` (+ `DocumentDate`) | Editable date. For `Purchase` and `Production` rows the cell shows two lines: the required-by date and, muted below, `DocumentDate`; row tooltip `Required by date: <d>\nOrder date: <d2>` (Purchase) or `...\nRelease date: <d2>` (Production), with the data-original-title `Release date is a date when components and resources are available to start the production of a finished good.` Transfer and Assembly show the date only. |
| Status | `TaskStatus` | Editable combo, options depend on type (6.1). Display names from the status store (`DRAFT` Draft, `ORDERED` Ordered, `AWAITING` Awaiting approval, `PLANNED` Planned, `RELEASED` Released, `AUTHORISED` Authorized); unknown values display raw. |

- Row body (product table with `Product` (`<code>: <name>`), `Quantity`, `UOM`) is shown under the row when the page checkbox `Show products` (`ckbShowProducts`) is on; the choice persists in `localStorage['mrp_suggestions_show_product']` (`'1'`/`'0'`) and sets row class `active`.
- Product lines of a row can be refreshed on demand via `POST /api/MRP_SupplySuggestionProducts` (`MrpID`, `SupplySuggestionID` + filter data). An empty array is treated as an error (`data.Message` or default text).

### 4.2 Toolbar

`Search` (text + button), `Merge`, `Products` filter, `Reset all filters` (hidden until a filter is active), combo filters `Demand in`, `Supply from/buy from`, `Supply order`, `Show products`, `Confirm`, `Recalculate`, `Export`. Confirm and Recalculate are disabled when read-only or the run is completed.

### 4.3 Filter payload (`SuggestionsFilterService.getFilterData`)

`{MrpID, Search (lower-cased, trimmed), CategoryIDs, BrandIDs, FamilyIDs, Tags, ProductIDs, DemandLocationIDs, SupplyIDs, SupplyTasks}`. It is sent with suggestions, filters, edits (`MRP_Operation`), product loads, Confirm and Export. `hasMatch` (client-side matching helper, not used by the grid) matches search text against SupplyTask, DemandLocationName, SupplyName and Status, lower-cased and trimmed; other filters need an exact id/task match, empty filters match all.
- `Reset all filters` is shown only while a combo filter or a product filter is active (`filter()`: `toggleContent(!hasSomeFilter(true) && !productsFilter.hasSomeFilter)`); the search text alone does not count. It asks `All selected filters will be reset. Would you like to proceed?` (Yes/No).
- Filter option lists (`MRP_SupplySuggestionFilters`, POST) return `{DemandLocations, Supply, SupplyTasks}`; loaded after each product filter change.

### 4.4 Product filter dialog (`ProductsFilter`)

Dialog `Select products to filter` (OR): multi-selects for Categories, Brands, Families, Tags, and Products, with Apply/Close. Mutual exclusion: choosing anything in Products disables the other four (and vice versa); the confirm text is `All selected categories, brands, product families and tags will be reset. Would you like to proceed?` or `Selected products will be reset. Would you like to proceed?`. Selected values persist per run in `localStorage['MrpFilter_<type>_<mrpId>']` and are cleared on Complete.

---

## 5. Export

`Export` submits form `frmExportSupplySuggestion` (hidden field `frmExportSupplySuggestionMrpId` = run id; the form's target and extra fields come from the server HTML). The file format is server-side.

---

## 6. Editing suggestions and creating orders

### 6.1 Status options per order type (`adjustStatusStore`)

| Supply order | Allowed statuses (stored value) |
|---|---|
| Transfer | `DRAFT`, `ORDERED` |
| Purchase | `DRAFT`, `ORDERED`, plus `AWAITING` (Awaiting approval) only if tenant `IsOrderApprovalEnabled` |
| Production | `DRAFT`, `PLANNED` |
| Assembly | `DRAFT`, `AUTHORISED` |

(`RELEASED` exists in the lookup for display only; it is not selectable.) When the order type of a row is changed, the status is reset to `MRPService.taskDefaultStatus[<new type>]` (the status chosen in the run settings).

### 6.2 Supply from/buy from (`bindSupplyStore`)

The editor combo is re-bound depending on `SupplyTask`: `Purchase` -> suppliers (`GET /api/MRP_vSupplier`); `Production` -> shop-floor locations only (`GET /api/MRP_vTenantLocation?IsShopFloor=true`); anything else (Transfer, Assembly) -> all locations (`GET /api/MRP_vTenantLocation`).

### 6.3 Changing the order type (`adjustSupplyTaskStore`)

Clicking the Supply order cell first loads the row's products (`MRP_SupplySuggestionProducts`), then offers only a subset of types:
- always the current type;
- `Purchase` row: also `Transfer`; plus `Production` or `Assembly` if the row has exactly one product and that product's `ProductBOM` is `Production BOM` or `Assembly BOM` respectively;
- `Transfer` row: also `Purchase`, plus the BOM-derived type under the same one-product rule;
- `Production` row: also `Transfer`, and `Purchase` if the single product's BOM is `Production BOM`;
- `Assembly` row: also `Transfer`, and `Purchase` if the single product's BOM is `Assembly BOM`.
On a change (`edit` handler): `SupplyID` and `SupplyName` are cleared, `TaskStatus` is set to the default status for the new type, `ValidationState` set `Good`, `IsSupplyTaskChanged = true`, `DocumentDate = RequiredByDate`, and the supply combo is re-bound.

### 6.4 Cell editing rules (`createCellEditing`)

- No editing when read-only or the run is completed.
- `RequiredByDate` editing is blocked when the row flag `IsSupplyTaskChanged === false` (a server-supplied flag; the client sets it to `true` when the order type is changed, which unlocks the date). A new date before today (`value < start of today`) is reverted, the editor is re-opened and the warning `Required by date can not be in the past.` is shown; otherwise `DocumentDate` is set to the new date as well.
- Editing `SupplyID` stores `SupplyName` from the editor store.
- After the status is changed to a different value: if `ValidationState == 'Invalid'` and both supply and status are non-empty, the validation error clears; and if the row is not invalid and both `SupplyID` and `TaskStatus` are non-empty, the edit is auto-saved (6.6).
- Filter option lists are kept in sync (new task/supply values are appended to the filter stores so the row remains filterable).

### 6.5 Filter-to-demand jump

From the details panel's `Suggested supply` link: `filterBy({locationID, locationName}, productID)` -- suspends filtering, clears all filters, adds the location to the Demand-in filter store if missing, selects it, sets the product filter to `[productID]`, then reloads.

### 6.6 Auto-save of an edited row: `POST /api/MRP_Operation`

Payload: the row (`getData(true)` including nested `Products`) merged with the filter data. Reply `{IsSuccess, SuggestionID, Message}`; success replaces the row id with `SuggestionID` (the split button's `data-id` is updated too), commits the row and shows `Changes have been saved.` Otherwise `isProcessing` modal, or error toast with `Message`.

### 6.7 Confirm (create orders) (`reorder`)

1. Selected rows = `IsSelected`. None: warning `Please select supply order lines to confirm reorder.`
2. `validation(true)`: when the store has unsaved changes, every selected row must have non-empty `SupplyID` and `TaskStatus`; otherwise those rows are flagged Invalid with `Fields can not be empty.` and the toast `Some supply orders have empty fields. Please see the errors in details.` is shown and nothing is sent.
3. `POST /api/MRP_vMRPReorder` (timeout 2,000,000 ms), body `{Suggestions: [selected rows incl. products], ...filter data}`. Reply: array of `{SuggestionID, SuccessMessage, ErrorMessage}`.
   - A row with `ErrorMessage.length === 0` is a success: its `SuccessMessage` is collected; all success messages are shown in one success toast joined with `<br />`. A row with a message is set `ValidationState = 'Invalid'`, `ValidationText = ErrorMessage`.
   - If at least one row was created: suggestions reload and the Results tab reloads. If any failed: toast `Some suggestions have not been reordered. Please see the errors in details.`
   - A non-array reply with `IsSuccess === false` shows `Message` (or the default error); `isProcessing` is also applied.
4. The created document type and status come from the row's `SupplyTask` and `TaskStatus` (Purchase/Transfer/Production/Assembly; statuses in 6.1). Created documents appear in Results with the link types in 8.
5. In the Scheduler a single suggestion can also be confirmed (`POST /api/MRPScheduler_vMRPReorder {MrpID, SupplySuggestionID}`; reply `{IsSuccess, TaskNumber, TaskStatus, TaskID, Message}`; toast `Supply suggestion has been confirmed.`; the bar text becomes the new order number, the status the new status, the link `<Type>#<TaskID>`).

### 6.8 Merge (`merge`)

- `validateMerge`: with 0 selected -> warning `Select at least two supply suggestions to merge.`; any non-Purchase row selected -> `Only purchase supply orders can be merged.`; exactly 1 selected -> `Select at least two supply suggestions to merge.`; selected rows with different `DemandLocationID` or different `SupplyID` -> `Selected supply suggestions must have the same supplier and same location.`
- Confirm modal `Would you like to merge selected supply suggestions?` (Yes/No). `POST /api/MRP_vMRPMerge {mrpID, ids: [suggestion ids]}`; `IsSuccess === false` -> `Message`; success reloads and shows `Suggested orders have been merged.`

### 6.9 Recalculate

Confirm `Are you sure you want to re-calculate demand and suggested supply orders?` (Yes/No; `closeOnConfirm: false`). `POST /api/MRP_Recalculate {mrpID}`. Success: reloads suggestions, errors, results and log, reloads the Demand report, refreshes the Scheduler button, toast `MRP has been recalculated successfully.` `IsTerminated` -> `Calculation was terminated by user` modal; `isProcessing` modal otherwise; else error toast. The Void message (9) tells the user to recalculate after voiding.

---

## 7. Split supply order dialog (`SplitProducts`)

Opened from a row's `Split products` button after loading its product lines. Title `Supply order product lines`. Header shows `<SupplyTask>` and `Required by date: <date>`.

- Left grid: the order's product lines (`Product` = `<code>: <name>`, `Quantity`, `UOM`, `Split` = `Yes` if the quantity differs from the original else `No`). `Split Supply order` button adds a new tab `<SupplyTask> #<n>` (n = running count); hint text `There are no any split orders at the moment.<br />Please click on Split button.`
- Each tab has a grid with columns Validation, `Product` (combo of the original products not already used in this tab; selecting a product already in the tab clears it with `This product has already been added.`), `Quantity` (decimal, 10 places, no spinner), `UOM`, delete. Toolbar: add row (`+`), `Undo` (confirm `Yes, delete all!`; with nothing: warning `There is nothing to undo.`).
- Quantity edit before choosing a product: warning `Please select a product to split the order.`
- Moving quantity out of the parent: on each quantity edit the difference is validated against the parent's remaining quantity (`parentQty - delta >= 0`); otherwise the old value is restored and the warning `Quantity can not be greater than quantity in the original supply order.` appears. The parent line is decremented by the same delta (`parent.Quantity -= delta`) and `IsSplitted` becomes `parent.Quantity !== originalQuantity`.
- Deleting a row with a product asks `Yes, delete it!` and returns that quantity to the parent.
- Button state: `Split Supply order` enabled only if some parent quantity is > 0 and the user can write; `+` likewise; `Confirm` enabled only if any sub-order has a line with quantity > 0.
- `Confirm` (`reorder`): builds one new suggestion per non-empty tab (copy of the parent row with a new `guid()` id and the tab's lines). If the parent still has quantity > 0, its product quantities are updated to the remainder; if everything was moved, the parent is marked `ValidationState = 'ToRemove'`. Then `POST /api/MRP_Split {OriginalMrpID, OriginalSuggestionID, Suggestions: [new rows]}`; success reloads the grid and toasts `Supply order has been split.`

---

## 8. Results tab (`Results`)

Store `GET /api/MRP_Results` (params `MrpID`, `Search`; paged, `remoteSort`). Model `vSupplyResult {ID, TaskID, TaskNumber, TaskType, CreatedAt, SupplyName, DemandLocationName, RequiredByDate, TaskStatus, CreatedBy, TotalQuantity (float)}`. Empty message `You have not created any supply orders at the moment.`

Columns: `Supply task` (the order number, a link `/<Doc>#<TaskID>` in a new tab where Doc maps: Purchase -> `Purchase`, Transfer -> `Stocktransfer`, Assembly -> `FinishedGoods`, Production -> `ProductionOrder`), `Total QTY` (min 80), `Demand`, `Supply`, `Required by date` (user date format), `Status` (raw), `Created by`, `Created at` (user date format), and a button column (`Void`, plus `Products` link which opens the `Task products` dialog via `MRP_SupplySuggestionProducts`). The products dialog grid: Product, Quantity, UOM, Split (Yes/No).

Void (`void`): enabled unless read-only, run completed or `TaskStatus === 'VOIDED'`. Confirm text `Are you sure you want to void supply order? \nVoiding of orders causes changes in demand. \nPlease re-calculate MRP run.` `POST /api/MRP_vMRPVoidTask {TaskType, TaskID}`; success if `IsSuccess || IsVoided`: row status becomes `VOIDED` and toast `Supply order has been voided.<br />Please re-calculate MRP run.` (or the server `Message` when only `IsVoided`); failure -> `Message`.

---

## 9. Errors and Activity log tabs

- Errors (`Errors`): `GET /api/MRP_Errors` (params `MrpID`, `Search`, `errorType`), single column `Error description` (`Message`), empty message `No supply errors.`. Severity map `tabListEnum`: `#critical` -> 2, `#warning` -> 1, `#information` -> 0; default `errorType` is 2 (Critical). Sub-tabs only when run `Version === 4`; changing sub-tab reloads with that `errorType`.
- Activity log (`Log`): `GET /api/MRP_Logs` (params `MrpID`, `Search`). Columns: `Action` (`Message`), `Supply order` (`TaskType`), `Demand in`, `Supply from/buy from`, `User`, `Date/time` (user date format + ` H:i:s`). Message `Displaying results {0} - {1} of {2}`; empty `You do not have any activity at the moment.` The model also has `LogType`, `Error`, `AffectedEntitiesCount`, `ValidationState` (no client use beyond the model).

---

## 10. Tenant and master-data settings that change MRP behaviour

### 10.1 Tenant settings read or written by these pages

| Field | Where | Effect |
|---|---|---|
| `IsOrderApprovalEnabled` (from `MRP_ReferenceData`) | MRPRunSettings `setIsOrderApprovalEnabled` | If false, the `Awaiting approval` purchase status is removed from the run-setting select and from the Purchase status choices in the suggestion grid. |
| `MRPPrefix`, `MRPNextNumber`, `MRPSuffix` (+ `MRPChanged`) | GeneralSettings2019 | Numbering of runs (`#<Number>` in the list and as `txtMRPRunID`). Fields are read-only for read-only users. Editing sets `MRPChanged`. |
| `MRPProductionDate` | GeneralSettings2019 (`chkMRPProductionDateRequiredPlannedDate` / `chkMRPProductionDateReleaseDate`) | Radio pair deciding which date becomes the production order's date for MO suggestions: "Required planned date" or "Release date". Saved as the radio's value; the read-only branch forces the required-planned-date option. The production-suggestion row shows both dates (4.1). |
| `MOIsStockTransferAuto`, `MOIsPurchaseOrderAuto`, `MOIsNestedOrderAuto`, `MOIsFinishedGoodsAuto` (true/false radios) | GeneralSettings2019 | Production-order auto-creation switches for component supply (these are tenant production settings that sit beside the MRP settings; no MRP page code reads them). |
| `ReorderMode` (from `Reorder_Index_Tenant`) | ReorderLevelOfStock2019 | `Location` shows the location filter on the legacy reorder page (section 11). |

### 10.2 Product fields the run page shows or depends on

`ProductBOM` on each suggestion line is `Production BOM` or `Assembly BOM` (used in 6.3). Product-level `MinimumBeforeReorder` and `ReorderQuantity` feed "Procure up to" (the stock-level / minimum-before-reorder demand lines are `demand.stocklevel` entities); the arithmetic is server-side.

### 10.3 Lead and safety values (`LeadSafetyValues2019.js`)

Grid `/api/LeadSafetyValues_List` (search, root `root`): model fields `ID, ProductID, SupplierID, LocationID, SKU, Product, Supplier, Location, Lead, Safety, ReorderQuantity, MinimumToReorder`. Columns: Product, Supplier, Location, `Lead`, `Safety`, `Reorder quantity`, `Minimum to order`. Import page `/LeadSafetyValues/Import?ref=LeadSafetyValues` and export form `frmExport`. The Scheduler reads `PurchaseLeadtimeSettings` with `LeadDays` from the same data (see 12.2).

### 10.4 Supply rules (per location, `TenantLocationEdit.js :: SupplyRules / SupplyRuleEdit / SupplyRuleProductArea`)

Endpoint `/api/TenantLocationEdit_vSupplyRule` (REST). Model `TenantLocationSupplyRule {ID, Name, IsActive, IsAppliedForAllProducts, LocationID, Categories[], Families[], Brands[], Tags[], Products[], Actions[]}`; action model `vSupplyRuleAction {ID, SupplyTask, LocationID, TakeStockQuantity, FulfilDemandQuantity, Capacity, SupplierCondition, RuleID, LineOrder, IsOtherwiseAction}`.

- A rule is "In response to demand, plan action:" followed by an ordered list of actions (drag to reorder; saved `LineOrder` = list index, the `Otherwise` action is `LineOrder 0` with `IsOtherwiseAction = true`) and a final block `If demand is still not fulfilled, plan action:`.
- Action types (`js-cmb-action-task`): `Transfer`, `Purchase`, `Produce` (option hidden when the location `IsCoMan`), and for the `Otherwise` block also `OtherwiseNothing` (`Nothing`). Controls per type (`adjustRuleActionsToSupplyTask`):

| Type | Visible controls | Hidden | Labels |
|---|---|---|---|
| Purchase | supplier condition (`js-cmb-action-supplier`) | location, stock qty, demand qty, capacity | task label `from`, location label `take` |
| Produce | location (list from `/api/TenantLocationEdit_ProduceLocation`), capacity | stock qty, demand qty, supplier | task label `in`, location label empty |
| Transfer (default branch) | location (list from `/api/TenantLocationEdit_TransferLocation?includeComanLocation=true`), take-stock-quantity (`TakeStockQuantity`), fulfil-demand-quantity (`FulfilDemandQuantity`) | capacity, supplier | task label `from`, location label `take` |
| Otherwise: Nothing | none | all | |
In the Otherwise block the stock-qty, demand-qty and capacity controls are removed.
- Capacity (`js-txt-qty`) is a number mask `min 0`, `max 100`, no sign (a percentage); it resets to `0` and other selects are cleared when the type changes.
- Clicking the location combo before choosing an action: warning `Please choose supply action first.`
- Validation: every visible select/textbox in each action must be filled (`All rule fields must be filled`); name via `LocationService.validateName`; only one active rule may apply to all products (`A rule for all products already exists.`, checked against other active rules with `IsAppliedForAllProducts`). Product scope: all products, or a selection by categories, families, brands, tags and products (OR). Active/Not active status column. Delete confirm `Are you sure you want to delete the rule?`. Toasts `Supply rule saved successfully.` / `Supply rule has been created.`
- Option values for `TakeStockQuantity`, `FulfilDemandQuantity` and `SupplierCondition` are in the server HTML, not the script.

### 10.5 Transfer planning methods / supplier intervals (`SupplyIntervals`)

Per location, entries `SupplyInterval {DeliveryMethod, IntervalDays, IntervalStartDate, IsMonday..IsSunday, LocationToID/SupplierID/ProductID for purchases}`. `DeliveryMethod` is `fixed` (pick weekdays `IsMonday..IsSunday`) or `interval` (every `IntervalDays` days from `IntervalStartDate`). Validation toasts: `Please select the transfer planning method.`, `Please enter positive number to set period in days.` (`min 1`, `max 999999`), `Please select the start date.`, `Please select at least one day to plan transfer.` Delete confirm `Are you sure you want to delete transfer planning method?` These feed the Scheduler's "supply days" shading (12.4).

---

## 11. Legacy reorder pages (no MRP linkage)

`ReorderLevelOfStock2019.js`, `ReorderBackorderedStock2019.js`, `ReorderSuggestion2019.js` do not reference MRP. They are separate manual reorder screens:
- Level of stock (`Reorder_Index_Reorder`): selected rows only (`IsSelected`, all rows are pre-selected after each load). Validation per row: price `< 0` -> `<Product name> Reorder price should have a non-zero positive value.`; reorder qty `<= 0` -> `<Product name> Reorder quantity should have a non-zero positive value.`; nothing selected -> `Please select at least one product to reorder.` Posts `{LocationID, Reorder:[{SupplierID, ProductID, Price, ReorderQuantity}]}` to `/api/Reorder_Index_Products`; the reply `ModelState.serverError[]` is shown joined with `<br/>` (success info or error toast) and the grid refreshes. Editable column `Reorder quantity` (decimal precision 4, no spinner). Columns: Product, Supplier SKU, Available, On order, Minimum before reorder, Reorder quantity, Price.
- Backordered stock: same pattern against `/api/ReorderBackordered_Index_Products`, columns include `Backordered` and `Suggested reorder quantity`; products without a supplier are listed with links `/Product#<id>` via `ReorderBackordered_Index_ProductsWithOutSupplier`.
- Suggestion email/log page uses `SuggestReorder_Index_*` endpoints (columns Reorder date, Supplier, Product, Location, Available, On order, Minimum order quantity, Reorder quantity, Price, Ordered, Task, From/To).
See also `rules/inventory-client.md` for these bundles.

---

## 12. MRP Scheduler (`MRPScheduler.js`)

This is a Gantt chart (dhtmlxGantt library embedded in the bundle), not a recurring-job scheduler. It has no frequency, time-of-day or recipient fields; the bundle contains no cron/recurrence/notification-recipient code. The only persistence is browser `localStorage` (12.5).

### 12.1 Load

`GET /api/MRPScheduler_MRP?mrpID` -> `{PurchaseLeadtimeSettings, PurchaseIntervalSettings, TransferIntervalSettings, PlanningPeriodStart, PlanningPeriodEnd}`; then in parallel `GET /api/MRPScheduler_Demand`, `..._Supply`, `..._ExistedSupply` (on-order), `..._LocationCalendar`, all with `?mrpID=`. Spinner text `Loading MRP data...`. Location combo lists the unique `LocationID/LocationName` found in the data, sorted by name; the first is selected.

### 12.2 Data shaping (`DataManager`)

- Demand tab, per product and for the selected location only, four lines (`_model`): `Independent demand` (field `IndependentDemand`), `Dependent demand` (`DependentDemand`), `Current supply` (`Supply`), all dated by `DemandDate`; and `Suggested supply orders` (field `Quantity`, date `RequiredByDate`) from the supply feed. Values are rounded `DEARRound(v, 2)` (`sign * round(abs(v)*100 toFixed(6)) / 100`); zero/blank renders as blank text.
- Week scale: values falling inside the same week bucket are summed (`value += task.value`), each bucket is 7 days long, week starts from the location calendar's `WeekStart` (default 1; label `dd MMM - dd MMM`).
- Supply tab: lines from supply + on-order data. Per line the bar:
  - `start = RequiredByDate - duration days`, `duration (bar) = taskDuration + 1`, `progress = 1 - 1/(taskDuration + 1)`.
  - `taskDuration` = days between `DocumentDate` and `RequiredByDate` for existing supply (`Source === 'supply'`); for a *suggested* Purchase = `LeadDays` from `PurchaseLeadtimeSettings` (matching product + supplier + location, falling back to the same product + supplier with the empty-GUID location, else 0); for other suggestions without a `DocumentDate` it is the date difference (0 if none).
  - Bar label is the order number (`TaskNumber`) or, for a suggestion, its order type; status column shows the document status title or `Suggested` when no status; `Lead time` column shows `duration - 1` when `duration > 1` else `duration`, and for a suggestion a `Confirm` button instead (`js-confirm-order`) that calls 6.7 step 5.
  - Status titles use `window.PurchaseStatuses`, `StockTransferStatuses`, `FinishedGoodsStatuses`, `ProductionOrderStatuses` (fallback `Common_AdjustStatus`). Purchase map includes Awaiting approval, Draft, Ordered/Ordering, Receiving/Received, Billed, Credited, Voided etc.; Transfer: Draft, Ordered, Picking, In transit, Completed, Voided; Production: Draft, Planned, Released, Work in progress, Authorized, Operations completed, Completed, Voided; Assembly (finished goods): Draft, Authorized, Work in progress, Completed, Voided.
  - Links: bar/row text opens `/<Purchase|Stocktransfer|FinishedGoods|ProductionOrder>#<TaskID>`.
- Location calendar (`MRPScheduler_LocationCalendar`): per location and year `{Days[{DayOfWeek,IsWeekend}], SpecialDays[{Date}], WeekStart, Year}`. `isDayOff`: weekends default to Sunday and Saturday (`_defaultWeekends [0,6]`); if a calendar exists for that year (else the latest earlier year) weekend flags come from `Days` (falling back to the default when none flagged) and `SpecialDays` are holidays; day off = weekend or holiday. Shaded only when "Show weekends" is on and scale is Day.
- Supply days (`isSupplyDay`): Transfer lines are shaded on days matching the transfer planning method for the destination (`fixed` weekdays, or every `IntervalDays` from `IntervalStartDate` up to the period end); Purchase lines use the supplier/product/location interval setting. Only when "Show supply days" is on, Day scale, Supply tab.

### 12.3 Controls

| Control | Behaviour |
|---|---|
| Tabs `Supply vs demand` / `Supply orders` | Supply tab: scale forced to Day, Order-type filter hidden, `Show supply days` visible, `Show suggestions` and `Show unused days` hidden. Demand tab: reverse. |
| Location select | Re-parses data for the chosen location; remembers and re-applies Week scale. |
| Order type (multi-select) | `All orders` (value `all`), `Purchase orders`, `Transfer order`, `Assemblies`, `Production orders`. `All` is exclusive: picking a specific type replaces `all`; clearing everything or selecting all specific types resets to `all`. Applies to the Supply tab only. |
| Search | lower-cased, trimmed substring match on product text (and order text) |
| Scale radios `Day` / `Week` | Week is not available on the Supply tab; zoom levels day (min column 50) and week (min column 100); ctrl+wheel zoom. |
| View setup checkboxes | `Horizontal lines`, `Vertical lines`, `Show unused days` (Demand tab: hides dates with no data), `Show suggestions`, `Show supply days`, `Show weekends`; `Collapse all groups` / `Expand all groups`; fullscreen button. |
| Empty location | Toast `There are no tasks in selected location.` |

Gantt config: `drag_move`, `drag_resize`, `drag_progress`, `drag_project` all false (read-only), no links, `task_height 24`, no tooltips, `open_split_tasks true`.

### 12.4 Defaults

Initial view settings: scale `day`, horizontal lines on, vertical lines on, suggestions on, supply days off, unused days on, weekends on.

### 12.5 Persistence

`localStorage['MRPSchedulerSettings']` (JSON of the view settings above). Run page: `localStorage['mrp_suggestions_show_product']` and `MrpFilter_<type>_<runId>`.

---

## 13. Run list (`MRPList.js`)

- Store `GET /api/MRP_vMRP` (paged, `remoteSort`, `extraParams.search`). Grid `MRPList2`, columns: checkbox, `MRP run` (`Number`), `Created by`, `Date` (`CreatedAt`, user date format), `Status`. Messages: empty `You do not have any MRP at the moment.`, `No MRP to display.`, paging `Displaying MRP {0} - {1} of {2}`.
- Click a row -> `/MRP#<id>` unless `Status === 'Failed'`. Add (`btnAdd`) -> `/MRP` (new run).
- Delete: none selected -> warning `Please select MRP to delete.`; confirm `Are you sure you want to delete MRP?` (Yes/No); `DELETE /api/MRP_vMRP/` with a JSON array of ids; success removes rows and toasts `MRP has been deleted.`; else `Message`.
- Complete (list): none selected -> warning `Please select an MRP to complete.`; any selected row not `Active` -> `MRP status must be active.`; more than one -> `Only one active MRP can be completed at a time.`; then the confirm and `POST /api/MRP_Complete {MrpID}` as in 2.7; success toast `MRP run has been completed.`
- Demo-data removal (Home): if `data.HasMRP`, confirmation `There is an active MRP in your account. Do you want to remove data?` (Home2019.js/ContinueSetup.js).

---

## 14. Production orders created from MRP (`ProductionOrder.js`)

The production-order model has `MRPTaskID` and `IsCreatedFromMRP` (bool). When `IsCreatedFromMRP === true` the `LocationName` (output location) cell of the put-away and finished-product lines is not editable (`beforeedit` returns false).

---

## 15. Endpoint summary used by the client

| Endpoint | Method | Payload (client) | Reply fields read |
|---|---|---|---|
| `/api/MRP_vMRP` | GET list/ID, DELETE | `search`, `ID`; delete = array of ids | rows; `IsSuccess`, `Message`, run: `Status`, `Version`, `Number`, `CreatedBy`, `IsDetailsDeleted`, `IsLoadDetails`, settings |
| `/api/MRP_vMRPSettings` | GET, POST, DELETE | `limit`; settings record | `ID`, `Name`, `IsSuccess`, `IsForbidden`, `Message` |
| `/api/MRP_ReferenceData` | GET | | `IsOrderApprovalEnabled` |
| `/api/MRP_vTenantLocation` | GET | `IsShopFloor` | `ID`, `Name` |
| `/api/MRP_vCustomer`, `/api/MRP_vSupplier` | GET | query `Name` | `CustomerID/ID`, `Name` |
| `/MRP/ImportForecast` | POST multipart | `file` | `Success`, `ForecastDateID`, `ErrorLines[]` |
| `/api/MRP_CheckLongExecution` | GET | settings array | `Status` (`wait`) |
| `/api/MRP_Run` | POST | settings array | `IsSuccess`, `MrpID`, `MrpNumber`, `Status`, `IsLoadDetails`, `IsTerminated`, `CreatedBy`, `Message` |
| `/api/MRP_LoadDataFromDB` | POST | settings array | zip blob |
| `/api/MRP_SupplySuggestions` | POST | filter + `LoadProducts` | `root[]`, `total`, `products[]` |
| `/api/MRP_SupplySuggestionFilters` | POST | filter | `DemandLocations`, `Supply`, `SupplyTasks` |
| `/api/MRP_SupplySuggestionProducts` | POST | filter + `MrpID`, `SupplySuggestionID` | products array |
| `/api/MRP_Operation` | POST | row + filter | `IsSuccess`, `SuggestionID`, `Message` |
| `/api/MRP_Split` | POST | `OriginalMrpID`, `OriginalSuggestionID`, `Suggestions[]` | `IsSuccess`, `Message` |
| `/api/MRP_vMRPMerge` | POST | `mrpID`, `ids[]` | `IsSuccess`, `Message` |
| `/api/MRP_vMRPReorder` | POST | `Suggestions[]` + filter | `[{SuggestionID, SuccessMessage, ErrorMessage}]` |
| `/api/MRP_Recalculate` | POST | `mrpID` | `IsSuccess`, `IsTerminated`, `Status`, `IsLoadDetails`, `Message` |
| `/api/MRP_Complete` | POST | `MrpID` | `IsSuccess`, `Message` |
| `/api/MRP_Results`, `/api/MRP_Errors`, `/api/MRP_Logs` | GET | `MrpID`, `Search`, `errorType` | `root[]`, `total` |
| `/api/MRP_vMRPVoidTask` | POST | `TaskType`, `TaskID` | `IsSuccess`, `IsVoided`, `Message` |
| `/api/MRP_DemandDetails` | GET | `mrpID`, `locationID`, `productID`, `excludeFutureSupply` | line array |
| `/api/MRPScheduler_*` | GET / POST (reorder) | `mrpID` / `MrpID`, `SupplySuggestionID` | see 12 |

---

## Not determinable statically

All of the following happen on the server and the scripts only send inputs and display results:

- The netting and explosion algorithm: how independent demand (sales, production, assembly, transfer, forecast, stock-level/minimum-before-reorder lines) is combined with stock on hand, on order and draft/planned supply, in what order dates are processed, how overdue demand is treated, how `Ignore stock on hand/on order` changes the netting, how "Procure up to" computes the target quantity (stock level vs minimum before reorder) and whether it uses reorder quantity or minimum order quantity for rounding or multiples.
- BOM explosion: the number of levels, how component demand is derived (virtual transfer/production/assembly orders), yield/scrap handling, how make-to-order and Production vs Assembly BOMs differ, and how `DependentDemand` is dated (lead time offsets).
- The supply decision: how supply rules are evaluated (rule ordering across rules, how `TakeStockQuantity` / `FulfilDemandQuantity` / `Capacity` / `SupplierCondition` values are interpreted, how the `Otherwise` action applies), how the supplier is chosen for the four `SupplyTask` options (`Set up for supply rule`, lowest price, lowest lead time, latest supplier), how lead time and safety values shift `RequiredByDate` / `DocumentDate`, how transfer planning intervals and location calendars adjust dates, and how consolidation ("Consolidate suggestions by source") groups lines.
- Quantity rounding, units of measure conversion, and supplier minimum/multiple handling of suggested quantities.
- What `MRP_vMRPReorder` creates field by field (numbering, line prices, costs, dates, document status transitions, `AWAITING` approval flow, co-man handling), and what Merge, Split, Void and Recalculate do to demand and to stored suggestions.
- Run lifecycle on the server: who may run concurrently, termination, failure states, deletion of run details, retention, the integer values behind the `Purchase order supplier` select, the values of the `DemandSales` radios other than `Authorised`, and the `MRPProductionDate` radio values.
- The row-level content of the Demand report (Report Service) and its columns, and the format of the Export file.
- Permissions beyond what `CheckAccess('MRP','Run')` and `IsReadOnly` imply.
