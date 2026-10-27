# Reference books: client-side behaviour

Static reading of Cin7 Core's shipped, public ExtJS page scripts for module 14 (reference books). Nothing was executed and the live app was not contacted. Bundle names are the cached file names (`TenantBrands2019` etc.); `Main2019` holds the shared helpers. Each rule cites `bundle:function` (or `bundle:control` where the rule sits in a column or field config). Only what the browser code enforces is listed here: the server's own checks (max lengths, uniqueness, in-use guards) show up only as the message the client prints from the response, see "Not determinable statically".

Screens map to bundles as in [spec/modules/14-reference-books/UI.md](../spec/modules/14-reference-books/UI.md). Option lists for plain HTML `<select>`s are not in the scripts; they come from the server-rendered page and are quoted from that UI.md layout.

## ⚠️ Gotchas: the sneaky stuff

The easy-to-miss behaviours, worst first. `CAUTION` = silently corrupts data, cost or stock, is irreversible, or fails silently. `WARNING` = a surprising rule that breaks a rebuild if missed. `NOTE` = the sources disagree. Each links to the full rule below.

> [!CAUTION]
> **Chart "Use default" re-archives and re-activates accounts and cannot be undone**
> The confirm text says active accounts may be archived and archived accounts made active again, and that the action cannot be undone. Import is blocked while Xero or QuickBooks is connected. See [Chart of accounts](#chart-of-accounts-chartofaccounts-bundle-chartofaccounts2019).

> [!CAUTION]
> **Regenerating the networking key breaks every current connection**
> The confirm text says so plainly. Unsaved changes block the regenerate, and invitations also require a clean state. See [Cin7 Core to Cin7 Core network](#cin7-core-to-cin7-core-network-deartodearnetworking-bundle-deartodear2019).

> [!CAUTION]
> **"I am selling this product" is stored inverted**
> The combo shows Yes but stores `false`, and No stores `true` (the stored value is "not sellable"). Anything reading or writing it raw gets the opposite meaning. See [Default field values](#default-field-values-defaultfieldvaluescustomerproductsupplier-bundle-defaultfieldvalues2019).

> [!WARNING]
> **The shipping-zone range check is dead code**
> The Max less than Min check reads `Max`/`Min`, but the model has `MaxValue`/`MinValue`, so bad ranges are never refused in the browser. Whether the server rejects them is unknown. See [Shipping zones](#shipping-zones-tenantshipzone-bundle-tenantshippingzones2019).

> [!WARNING]
> **Brand and category duplicates only raise a toast; the row is not blocked**
> The client duplicate check does not stop the save, so the server decides. Units of measure behave differently: a duplicate marks the row Invalid. See [Product brands](#product-brands-tenantbrand-bundle-tenantbrands2019).

> [!WARNING]
> **Payment terms quietly clamp and cross-wire flags**
> Method id 4 is not offered. For "Day of next month", Days over 31 is forced to 31; "Last day of next month" makes Days not applicable. Ticking Default clears every other default and forces that row active; unticking Active clears its Default. See [Payment terms](#payment-terms-tenantpaymentterm-bundle-tenantpaymentterm2019).

> [!WARNING]
> **Accounting dimension changes are not retroactive**
> After a save that changes list values, the page warns that new dimensions and values apply to new tasks going forward only. A dimension already used in transactions cannot be disabled on an account. See [Accounting dimensions](#accounting-dimensions-accountingdimensions-bundle-accountingdimensions2019).

> [!WARNING]
> **Deactivating a return policy changes policy for old purchases too**
> The confirm text says the policy deactivates from the update date and that products bought before that date are subject to the new policy. See [Return policy](#return-policy-rmareturnpolicy-bundle-rmareturnpolicy2019).

> [!WARNING]
> **Account mapping requires nothing, but one account may not back two slots**
> No field is required (empty is posted as an empty string); a duplicated account blocks the save. Archived accounts are never offered. See [Account mapping](#account-mapping-accountmapping-bundle-accountmapping2019).

> [!WARNING]
> **Only one tax component can be compound in the editor**
> Ticking Compound clears the flag on every other row. A liability account not in the chart list is nulled on edit, and a blank component name becomes "Tax". See [Tax rules](#tax-rules-tenanttaxationrule-bundle-tenanttaxationrule2019).

> [!WARNING]
> **Deprecating a location has side effects**
> The default location cannot be deprecated, nor a shop-floor location used in a logistics path. Deprecating a co-manufacturing location disconnects all its work centres after a confirm. See [Locations list](#locations-list-tenantlocation-bundle-tenantlocation2019).

> [!NOTE]
> **Length limits, uniqueness and "in use" guards are server-side and not visible here**
> Apart from the 50-character full account code and 256-character invoice and customer references, the browser enforces no length. A guarded delete returns server text that is not in the bundles. See [Not determinable statically](#not-determinable-statically).

---

## Shared behaviour (Main2019 and the grid pattern)

These apply to every page below unless the page's section says otherwise.

| Topic | Behaviour | Source |
|---|---|---|
| Page boot | Each page's `*_Ready()` builds the store/grid, then calls `CheckAccess(<Controller>, 'Index', accessCb, loginCb)`. The access call loads `AccessInfoStore` with `Controller`, `Action`, `DeviceID` (from `localStorage.SessionID`, default `DEAR`). The access callback receives `accessLevel`; the string `ReadOnly` means the user may only look. | Main2019:CheckAccess |
| ReadOnly access | New and Save buttons (`#divNew`, `#divSaveChanges`, `#divSaveChanges2`, page-specific "new" links) get `hiddenContent`; delete column `hidden: IsReadOnly`; cell editing returns `false` from `beforeedit`; checkbox columns refuse changes. Save handlers return immediately when `IsReadOnly`. | each bundle `*_AccessCallback`, `beforeedit`, `*_SaveDetails` |
| Grid shape | Editable reference-book grids are `Ext.grid.Panel` + `CellEditing` (`clicksToEdit: 1`), `selType: 'cellmodel'`, `autoSync: false`, REST proxy at `/api/<Controller>_Index_v<Model>`, `hasPaging: false`, column hide/move disabled (where `enableColumnHide/Move: false`). First column is the validation/status icon (`GetValidationColumnConfig`, 58 px). No inline drag-reorder on any of these grids except tax-rule components. | Main2019:GetValidationColumnConfig |
| Row status icon | `ValidationState` values: `Invalid` (red icon, tooltip = `ValidationText`; click shows an error box), `Warning` (click shows alert), `Pending` (tooltip "Record is being saved. Please wait"), `Expired`, `Edited` or dirty record (tooltip "Record was changed."), `Good`. | Main2019:GetValidationColumnConfig |
| Add row | New row = `Ext.create(model, {ValidationText:'', ValidationState:'Good'})`, `setDirty()`, appended to the store, first editable cell opened. On tablet/mobile (`IsTabletDevice`/`IsMobileDevice`) inline editing is disabled and a modal form is used instead. | `*_Index_New` |
| Save | `#divSaveChanges`/`#divSaveChanges2` click, or Ctrl+S (`Ext.util.KeyMap`, key `S`, ctrl), calls `referenceBookSave()` after a 50 ms timeout. It marks every dirty record `ValidationState='Pending'`, clears `ValidationText`, refreshes the grid and calls `store.save()` (one POST per new row, PUT per changed row, DELETE per removed row, to the proxy URL). | Main2019:referenceBookSave |
| Save payload hygiene | `Ext.Ajax beforerequest`: on `create` the id property is deleted from `jsonData`; on any non-read request `ValidationText` and `ValidationState` are deleted. | each `*_Ready` |
| Save success | Each saved record gets `ValidationState='Good'`, `commit(true)`; toast `Changes saved successfully.` | Main2019:processSaveGridResponse |
| Save failure | Grid pages: `ProcessGridException`. HTTP 401 -> text `You are currently not logged in. Please log in to continue.` and re-auth then retry the save. Timeout -> `Our servers are busy at the moment, please retry in a minute.` Otherwise the response's `ModelState` values are joined with `<br/>` and put on each failed record (`ValidationState='Invalid'`, `ValidationText`=that text) so the row shows the red icon. No `ModelState` -> `An unhandled error occurred. Please try again and if it appears again contact support.` HTTP 404 on `destroy` clears `store.removed`. Pages using `ProcessException` instead show the response `Message` (plus `ModelState` lines) as an error toast; 501 -> `This functionality is not implemented.` | Main2019:ProcessGridException, ProcessException, GetErrorMessage |
| Delete | Delete column -> confirm dialog -> if the row has no id (never saved) it is just removed from the store; otherwise `DELETE <proxyUrl>?id=<id>`. Success: row removed, toast `Deleted successfully.`; failure: toast with response `Message` (or raw response text) and the row stays. Dialog text per page below. Confirm button text `Yes, delete it!`, cancel `No`, title `Confirmation`. | each bundle delete column |
| Unsaved changes | `window.ArePendingChanges = () => store has removed or modified records`; `BindPageLeave` sets `onbeforeunload` to return `There are unsaved changes. Do you really want to leave this page?`. | Main2019:BindPageLeave, IsStoreDirty |
| Keyboard | Enter after an edit re-opens the editor on the same cell (`enterpressed`); Tab/Shift+Tab move to next/previous editable cell and Tab off the last cell of the last row adds a new row (`ColumnTabProcessing`); Up/Down arrows move rows (`UpDownArrowGridHandler`, `UpDownEnforcer`). | Main2019:ColumnTabProcessing, UpDownEnforser |
| Required-field check (form pages) | `__HighlightInvalidFields.validation(ids)`: skips hidden or disabled controls; empty = null/blank (multi-selects: empty array); `data-positive-value` controls must also be > 0. Failure toast = one line `<label text without *> is required.` per missing control joined by `<br />` (or `Please specify all required fields.` when no label is found); the field gets class `invalid` until focus/change. | Main2019:HighlightInvalidFields |
| Tenant flags read here | `window.Quickbooks` (account-level flag from the account-info store `Quickbooks`), `window.Connected`, `window.TenantCurrency`, `window.TenantCountry`, `window.FinancialYearEndMonth/Day`, `window.PriceDecimals` (4) / `window.PurchasePriceDecimals` (7). | Main2019 account-info load |

Exported lists: every grid page has `#divExport` which submits a hidden form (`frmExport<Name>`), a server file download; nothing is computed client-side.

## Product brands (`/TenantBrand`, bundle `TenantBrands2019`)

Store `vTenantBrand`, idProperty `ID`, URL `/api/TenantBrand_Index_vTenantBrand`. State id `TenantBrandGrid_2`. Empty text `You do not have any brands at the moment.`

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Brand (`Brand`) | text editor in grid; modal text `#BrandDetails_Brand` on tablet/mobile and via the row's edit icon | empty | Editor `edit` (TenantBrands2019:cellEditing.edit): case-insensitive match against other rows' `Brand`; more than one match fires a toast (the row is not blocked, server decides). Modal save (`Brand_Index_SaveDetails`) refuses empty. No trim and no maxLength in client code. | `Brand with this name already exists. Brand name must be unique. Please reload the page.` ; modal: `Product Brand cannot be empty.` |

Buttons/handlers: New (`#divNew`), Save, Export; edit icon opens modal `#divBrandDetails` (`TenantBrand_Index_EditDetails`), modal Save (`#divSaveDetails`) sets the record and `store.save()` then hides the modal on success; Close removes an unsaved modal-created record. Delete confirm: `Are you sure you want to delete the brand?` -> `DELETE /api/TenantBrand_Index_vTenantBrand?id=<ID>`. Server errors in modal mode (tablet/mobile) are shown in `#BrandDetails_Errors` from `ModelState.serverError[0]`. Sort: default column sort only, no drag order.

## Carriers (`/TenantCarrier`, bundle `TenantCarriers2019`)

Store `vTenantCarrier`, idProperty `CarrierID`, URL `/api/TenantCarrier_Index_vTenantCarrier`. State id `TenantCarrierCarriers_12`. Empty text `You do not have any carriers at the moment.` Grid is `stateful` with `markDirty: true`.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Carrier name (`Description`) | text editor (grid) / `#CarrierDetails_Description` (modal) | empty | Modal save refuses empty (`Carrier_Index_SaveDetails`). Grid has no client duplicate or empty check. | `Carrier name cannot be empty.` |
| Tracking URL (`TrackingURL`) | text editor; read-only display appends a bold `[TrackingNumber]` token after the URL | empty | Placeholder token `[TrackingNumber]` is display-only in the renderer; the stored value is exactly what was typed. No URL validation in the client. | none |

Delete confirm: `Are you sure you want to delete the carrier?` -> `DELETE /api/TenantCarrier_Index_vTenantCarrier?id=<CarrierID>`. Errors use `ProcessException` (error toast of `Message`). Modal edit/new on tablet/mobile as above. Page load shows a blocking spinner until the first store load.

## Product categories (`/TenantInventoryCategory`, bundle `TenantInventoryCategory2019`)

Store `vTenantInventoryCategory`, idProperty `CategoryID`, URL `/api/TenantInventoryCategory_Index_vTenantInventoryCategory`. Empty text `You do not have any inventory categories at the moment.`

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Category (`Category`) | text editor / modal `#InventoryCategoryDetails_InventoryCategory` | empty | `edit`: value is trimmed (`e.value.trim()`) and written back when it differs; case-insensitive duplicate check across the grid (toast only). No empty check in the modal (`InventoryCategory_Index_SaveDetails`). | `Product category with this name already exists. Product category name must be unique. Please reload the page.` |

Delete confirm uses the message box, not swal: title `Confirmation`, text `Do you really want to delete a category {0}?` (category name), buttons Yes/No -> `DELETE /api/TenantInventoryCategory_Index_vTenantInventoryCategory?id=<CategoryID>`.

## Units of measure (`/TenantUnitOfMeasure`, bundle `TenantUnitOfMeasure2019`)

Store `vTenantUnitOfMeasure`, idProperty `UnitOfMeasureID`, URL `/api/TenantUnitOfMeasure_Index_vTenantUnitOfMeasure`. `minHeight: 300`. Empty text `You do not have any units of measure at the moment.`

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Unit name (`Unit`) | text editor / modal `#UnitOfMeasureDetails_UnitOfMeasure` | empty | Only when the value changed: case-insensitive duplicate among non-empty values; duplicate sets the row `ValidationState='Invalid'` and `ValidationText`; otherwise both are cleared. No empty check, no trim. | `Unit of measure with this name already exists. Unit of measure name must be unique.` |

Delete confirm: `Are you sure you want to delete the unit of measure?` -> `DELETE /api/TenantUnitOfMeasure_Index_vTenantUnitOfMeasure?id=<UnitOfMeasureID>`. (Dimension/conversion fields are not on this page.)

## Payment terms (`/TenantPaymentTerm`, bundle `TenantPaymentTerm2019`)

Store `vTenantPaymentTerm`, idProperty `TermID`, URL `/api/TenantPaymentTerm_Index_vTenantPaymentTerm`. Grid state id `TenantPaymentTerm9`, uses local-storage state (`initStatePersistance`). Has a tablet/mobile row-body layout (Description, Method, Duration).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Description (`Name`) | text editor / modal `#TenantPaymentTerm_Description` | empty | Modal save refuses empty. | `Name cannot be empty.` |
| Method (`Method`, int) | combo (`editable:false`, `forceSelection`), local list: 1 `Number of days`, 2 `Day of next month`, 3 `Last day of next month`, 5 `Days since the end of the month` (id 4 is not offered) | 1 for a new row and for modal Clear; unknown value renders as the first list entry | Modal save refuses empty. | `Method cannot be empty.` |
| Duration (days) (`Days`, int) | number editor `allowDecimals:false`, `minValue:0`, `maxValue:999`, no trigger; modal `#TenantPaymentTerm_Days` with number mask | 0 (modal clear) | Method 3: cell not editable (`beforeedit` returns false; `IsFieldEditable` skips it in Tab order), renders `Not applicable`; in the modal the input is cleared, disabled, placeholder `Not applicable`. Method 2: after edit, `Days > 31` is forced to 31; in the modal the max is 31 for method 2, 999 otherwise, blank or `-` becomes 0, negative or NaN becomes 0, above max clamps to max. Switching away from method 3 restores the previous days value and re-enables the field. Modal save with blank Days and Method != 3 refuses. | `Days cannot be empty.` |
| Is default (`IsDefault`, bool) | checkbox column / modal checkbox | false | Checking one clears `IsDefault` on every other row and forces that row `IsActive=true`. Modal save: when default is ticked all other rows are cleared too. | none |
| Is active (`IsActive`, bool) | checkbox column / modal checkbox | true for a new inline row; modal Clear sets null (unchecked) | Unticking a row also clears its `IsDefault`. | none |

On tablet/mobile inline editing is off and the modal is used; the check columns' `beforecheckchange` returns `IsReadOnly` there (inverted relative to desktop, where it returns `!IsReadOnly`). Delete confirm: `Are you sure you want to delete the payment term?` -> `DELETE /api/TenantPaymentTerm_Index_vTenantPaymentTerm?id=<TermID>`. On a failed destroy the removed record is put back into the store (`exception` listener) and the error shows on the row; if the modal is open `#TenantPaymentTerm_Errors` shows the row's `ValidationText`. A save blocks the UI with a counter of pending requests.

## Tax rules (`/TenantTaxationRule`, bundle `TenantTaxationRule2019`)

List grid (paged store `/api/TenantTaxationRule_Index_Paging_vTenantTaxationRule`, reader root `root`) with columns Name (`Description`, shows `(<EffectivePercentExclusive>%)`; inactive rows grey and struck through) and Status (`Active` / `Deprecated` badge). Filter checkbox `#divShowOnlyActive` reloads page 1 with `extraParams {IsActive: <bool>}`. Clicking a row opens the form (URL hash = rule id also opens it). Form is a separate panel (`#divTaxDetails`) with a components grid.

Tenant setting effects (TenantTaxationRule2019:AccessCallback): `ReadOnly` hides New and Load; otherwise if `window.Quickbooks` is true New is hidden (rules come from the accounting package via `Load` -> `/QuickbooksImportExport/Quickbooks`), else Load is hidden.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`Description`, `#tdDescription`) | text | empty | Required (`TenantTaxationRule_Index_Save` id list `tdDescription, tdInclusive, tdStatus, tdAccountCode`). | `<label> is required.` |
| Status (`IsActive`, `#tdStatus`) | select `ACTIVE` / `DEPRECATED` | `ACTIVE` | Required. Sent as `IsActive = (value == 'ACTIVE')`. | as above |
| Tax inclusive / exclusive (`Inclusive`, `#tdInclusive`) | select `false` = `Tax exclusive`, `true` = `Tax inclusive` | `false` (exclusive) | Required. | as above |
| Account (`AccountCode`, `cmbAccountCode`) | type-ahead combo over Chart of accounts (`/api/TenantTaxationRule_Index_vChartOfAccounts`, display `DisplayName`, value `Code`), `emptyText 'Choose...'` | the chart row flagged `IsDefault` (new rule); empty otherwise | Required. List filter is a case-insensitive regex on typed text. | as above |
| Tax type (`Tax1`, `#tdTax1`) | select filled from `/api/TenantTaxationRule_Index_vXEROTaxTypes` (`TaxType` value, `Name` label), no empty option | null | Not required in the client. Control is a tax-type mapping used for the connected accounting package. | none |
| Components (`Components`, grid) | rows below | one row `Name='Tax'`, `Percent=0`, `Compound=false`, `ComponentOrder=1` on New | At least one row must remain. | `Tax rule should have at least one component.` |

Component columns (grid `ComponentsGrid`, rows are draggable to reorder, `ComponentOrder` is rewritten 1..n on every recalculation):

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Tax component name (`Name`) | text editor | `Tax` | Blank on edit is replaced by `Tax`; blank on modal save also becomes `Tax`. | none |
| Rate (`Percent`, float) | number editor, `allowBlank:false`, `decimalPrecision: 4`, no trigger; shows as `<n>%` | 0 | Blank -> 0. Footer sums to the effective rate. | none |
| Compound (`Compound`, bool) | check column labelled `Compound (apply to taxed subtotal)` | false | Only one row may be compound: ticking a row clears every other row's flag (grid and modal). | none |
| Liability account (`AccountCode`) | combo over Chart of accounts; empty renders `Use the selected liability account` (falls back to the rule's Account) | empty | A value not in the chart list is nulled on edit. | none |

Effective rate (`calculateEffectivePercent`): non-compound rates are summed first; a compound row's rate is then `rate + rate * sum / 100` added on top; rounded with `DEARRound(x, 4)`. Result goes to `EffectivePercentExclusive`.

Save: `POST` (New) or `PUT` (Edit) `/api/TenantTaxationRule_Index_vTenantTaxationRule` with `CurrentTaxRule.getData(true)` (rule plus its Components). Success toast `Tax rule saved.`, list reloaded. Failure -> `ProcessException`. Component delete from the grid has no confirm; from the small (mobile) table it asks `Are you sure you want to delete the tax component?`. There is no rule delete in the client: rules are deprecated via Status.

## Shipping zones (`/TenantShipZone`, bundle `TenantShippingZones2019`)

List of zone cards (`Excluded` badge for negative zones), a feature switch `#TenantShippingZone_Index_Switch` (`GET/POST/DELETE /api/TenantShipZone_Index_vShipZonesEnabled`; POST turns the feature on, DELETE off; load response gives `Enabled`, `TaxRuleID` (default tax rule), `DefaultWeightUnits`), New zone, New "Rest of world" zone (hidden once one exists), New "excluded" (negative) zone (shown only once a rest zone exists), Import (`/TenantShipZone/ImportShippingZones`) and Export. Save is one `POST /api/TenantShipZone_Index_vShipZones` with `{ZoneID, Name, IsRestZone, Negative, TaxRuleID, PricesInclTax, DefaultShippingCost, AppliesTo[], Conditions[]}` (timeout 1 h); delete = remove from store + `store.save()`.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`txtShipZoneName`) | text | empty (new); `Rest of world` for rest zone, locked (disabled) | Required, blank/whitespace refused. | `Please provide a name for the shipping zone.` |
| Tax rule (`cmbTaxRule`) | select from `/api/TenantShipZone_Index_vTenantTaxationRule` | tenant default rule id from the Enabled call | Required unless the zone is negative. Hidden for negative zones. | `Please select a tax rule.` |
| Prices include tax (`PricesInclTax`) | checkbox | false | Disabled when ReadOnly. | none |
| Default shipping cost (`DefaultShippingCost`, `#ShippingZone_Details_CostFixed`) | number with mask, 4 digits | 0 | Shown only for the rest-of-world zone. List shows `FREE SHIPPING` when 0 else `Shipping cost: <n> <currency>`. | none |
| Applies to (grid) | rows: Country (`Country2`, combo of `/api/country`, value `Code2`), State (`StateID`, combo of the country's regions from `/api/countryregion`; cleared when the country changes), Postcode/Zip from (`PostCodeFrom`), to (`PostCodeTo`), list (`PostCodesList`), Shipping rate (`ShippingRate`, hidden for negative zones). Headers read `Zip Code ...` when `TenantCurrency == 'USD'`, else `Postcode ...` | new row `ID=guid`, state `Good` | At least one row unless rest zone. Server-side row errors come back as `AppliesTo[i].ValidationState/ValidationText` and are put on the matching row (word `Postcode` replaced by `Zip Code` for USD tenants). | `At least one shipping zone must be applied to an item. ` |
| Price rates (grid, `ConditionType 'price'`) | Description (text), Min total (number, `minValue 0`, `decimalPrecision 4`), Max total (same; 0 or blank renders as infinity), Rate (`ShippingCost`, `minValue 0`, `decimalPrecision 2`; 0 renders `FREE SHIPPING`) | description `New rule` | Intended check: Max < Min with Max > 0 is refused. The shipped code reads fields `Max`/`Min` which the model does not have (`MaxValue`/`MinValue`), so this check never fires in the client. | `Please specify the correct order total range values for the '{0}' rule.` |
| Weight rates (grid, `ConditionType 'weight'`) | same columns, headers `Min weight` / `Max weight`; units follow `DefaultWeightUnits` | description `New rule` | Same dead check as above. | `Please specify the correct weight range values for the '{0}' rule.` |

Negative zone: hides tax rule, default cost and rates blocks; no delete/activity-log link while still `Added` (unsaved). Rest zone: hides the applies-to/contents block, name locked. Leaving with changes asks `There are unsaved changes. Do you really want to leave this page?` (compares JSON of the payload to the loaded baseline). Delete confirm: `Are you sure you want to delete this Shipping Zone?`. Success toast `Shipping zone has been saved.`; an `Invalid` response shows `ValidationText`, any other failure shows `Message`.

## Additional attributes / attribute sets (`/TenantAttributeSet`, bundle `TenantAttributeSet2019`)

List grid (sorted `Name` DESC, columns Name as a link opening the modal, delete). Editing is in modal `#divAttributeDetails` (static backdrop, no keyboard close). Store `vTenantAttributeSet`, idProperty `SetID`, URL `/api/TenantAttributeSet_Index_vTenantAttributeSet`. Save button `#divSaveChanges` calls `PrepareDataToSave` (not `referenceBookSave`). A set holds 10 attribute slots.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Set name (`Name`) | text `#TenantAttributes_Index_AttributeSetName`, placeholder `Enter an attribute set name` | empty | Required. | `Attribute set name cannot be empty!` |
| Attribute N name (`ColumnN`, N 1..10) | text, placeholder `Attribute N name` | empty | Attribute 1 name always required. For every slot whose type is not `Not used` the name is required; a slot with a name but type `Not used` is refused. Checked in slot order, first failure wins. | `Attribute 1 name cannot be empty!` ; `Attribute {0} has a type, but no name assigned.` ; `Attribute {0} has a name but not a type.` |
| Attribute N type (`ColumnNType`) | select: `Not used`, `List`, `Checkbox`, `Text`, `Numeric`, `Date` | `Not used` | See values rule. | none |
| Attribute N values (`ColumnNValues`) | text | empty | Enabled and editable only when type = `List`; otherwise disabled/read-only. Type `Date` clears it and sets placeholder = tenant date format (`TenantDateFormat`); `Numeric` clears it and sets placeholder `00.0000`. `List` with empty values refused. Values are one string (list separator not enforced by the client). | `Attribute {0} has the type 'List', but possible values are not set.` |

Delete confirm: `Are you sure you want to delete the attribute set?` -> `DELETE .../TenantAttributeSet_Index_vTenantAttributeSet?id=<SetID>`. After a successful save the modal hides; save only sends if the store is dirty. Success toast `Changes saved successfully.`.

## Company addresses (`/TenantAddress`, bundle `TenantAddress2019`)

Store `vTenantAddress`, idProperty `AddressID`, URL `/api/TenantAddress_Index_vTenantAddress`. State id `TenantAddressR1`. Empty text `You do not have any addresses at the moment.` Has tablet/mobile row-body layout and a modal (`#divAddressDetails`) for tablet (`window.isTablet`) editing. Country list: `GET /api/country` (`Code`, `Name`; value stored is the country **name**).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Line 1 (`Line1`) | text | empty | none in client | none |
| Line 2 (`Line2`) | text | empty | none | none |
| City / suburb (`CitySuburb`) | text | empty | none | none |
| State / province (`StateProvince`) | text | empty | none | none |
| ZIP / postcode (`ZipPostCode`) | text | empty | none | none |
| Country (`Country`) | type-ahead combo over `/api/country`, `forceSelection`, local filter | tenant country (`window.TenantCountry`) on a new inline row and in the modal | none | none |
| Type (`Type`) | combo, fixed list `Billing`, `Business`, `Shipping`; closes the editor on select | modal default `Shipping`; inline new row leaves it empty | After editing Type on a row that is flagged default, every other row of the same Type loses its default flag. | none |
| Default (`DefaultForType`, bool) | check column | false inline; modal default true | Ticking a row clears the flag on all other rows with the same `Type`. On tablet the column prints `Yes`/`No` and is not clickable by writers. | none |

Save is the generic grid save. Delete here is different: after the confirm (`Are you sure you want to delete the address?`) the row is removed from the store and `store.save()` is called straight away (no explicit `DELETE ?id=`; the proxy issues the destroy). The tablet table is redrawn after every load/write.

## Company contacts (`/TenantContact`, bundle `TenantContact2019`)

Server-paged list (`GET /api/TenantContact_Index_vTenantContact/GetWithPaging`, root `root`; create/update/destroy go to `/api/TenantContact_Index_vTenantContact`); page size from cookie `TenantContactListPageSize` (default 20); a search box (`#divSearchField`, placeholder `Type text to search`). Reference data from `/api/TenantContact_Index_ReferenceData`; mailing lists from `/api/TenantContact_Index_vMailingList/Get` (select2, remote search).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`Name`) | text | empty | none in client | none |
| Phone (`Phone`), Fax (`Fax`), Email (`Email`), Website (`Website`) | text | empty | none in client | none |
| Mailing lists (`MailingListsEdit`, array; `MailingLists` = comma+space joined string) | multi-select combo (names) | empty | Rows sharing the same Email are kept in sync (`UpdateMailingList`). Saving with a mailing list selected but no email is refused. | `An email is required for the mailing list.` |
| Sales commission % (`SalesCommission`) | number editor, `allowBlank:false`, no trigger, format `0`; shows `<n>%` | (server) | none in client | none |
| Type (`Type`) | combo `Billing`, `Business`, `Sale`, `Shipping`, `Employee` | modal default `Shipping` | Same per-type single-default rule as addresses (editing Type or ticking Default clears other rows' default of that type). | none |
| Default (`DefaultForType`) | check column; modal checkbox | false inline; true in modal | as above | none |
| Accounting dimension default values (`vDimensionDefaultValues`) | extra columns `colAD*` | none | Columns are shown only when the account-info flag `IsAccountingDimensionsEnabled` is true, at least one active dimension exists, and the user's `DimensionsPermission` is not `None` (`ReadOnly` makes them read-only). | none |

Delete confirm: `Are you sure you want to delete the contact?` -> `DELETE /api/TenantContact_Index_vTenantContact?id=<id>`. A "Reassign company contact" dialog posts `POST /api/TenantContact_Index_vTenantContact/ReassignCompanyContact` with from/to contact ids (both pickers are remote-search combos, `emptyText 'type to search...'`). Messages: success `All the customers and leads from '{0}' have been reassigned to '{1}'.`; same from/to -> `Reassign 'from' and 'to' values cannot be the same.`; either missing -> `Please select reassign from and to values.`.

## Locations list (`/TenantLocation`, bundle `TenantLocation2019`)

Two tabs on one page: Locations (`#tabLocations`) and Logistics path (`#tabLogisticsPath`). `New` navigates to `/TenantLocationEdit#new`; clicking a Location cell navigates to `/TenantLocationEdit#<LocationID>`. Locations grid: paged, column hide/move enabled, `remoteSort: true`, URL `/api/TenantLocation_Index_vTenantLocationLocation` (root `root`, `extraParams.CountrySpecificKey`). Exports: `#divExportwBins` (locations with bins), `#btnExportSupplyRules`, `#btnExportPutAwayRules`. Tenant effect: if the account has a country-specific key (`CountrySpecificKey`, from the server page) the country script `/TenantLocation/CountrySpecific?Key=<key>` is loaded and may replace the location model.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Location (`Description`) | read-only text link; a gray note `Used by an external fulfillment service` is appended when `FFServiceID` is set | - | not editable in grid | none |
| Location type (`LocationType`) | read-only text | - | - | none |
| Default (`IsDefault`) | check column | - | Ticking one clears the previous default (`store.findRecord('IsDefault', true)`); blocked when ReadOnly. | none |
| Deprecated (`IsDeprecated`) | check column | - | Ticking is refused if the row has no id yet, if it is the default location, or (shop-floor locations) if it is referenced by any logistics path. For a co-manufacturing location a confirm is shown first (title `Confirmation`, buttons `Confirm`/`Cancel`) and the flag only sets when confirmed. | `The default location can not be deprecated.` ; `Shop floor location is connected to components and demand locations specified by production logistics path. Please change the logistics path to deprecate the location.` ; `Deprecating co-manufacturer location will disconnect all work centers from this location. Would you like to proceed?` |
| Delete (column) | confirm then `DELETE /api/TenantLocation_Index_vTenantLocationLocation?id=<id>` | - | Refused client-side when the location appears in any logistics path (store reloads) or has an external fulfilment service id. | `You cannot delete {0} location because it is being used in logistics.` + newline + `Please reload the page.` ; `You cannot delete this location because it used by a fulfillment service.` ; confirm `Are you sure you want to delete the location?` |

Save (`TenantLocation_Index_Save`, Ctrl+S too) saves dirty locations and, if dirty, validated logistics paths. Save failures: `ProcessGridException` with default text `An error occurred while saving locations.` After a successful write the store reloads. Empty text: `You do not have any locations at the moment.`

Logistics path grid (`/api/TenantLocation_Index_LogisticsPath`; delete payload `PathID`; locations drawn from `/api/TenantLocationEdit_TransferLocation` and `/api/TenantLocationEdit_ShopFloorLocation`): columns Components (`WarehouseLocationID`), Shop floor (`ShopFloorLocationID`), Demand (`RetailLocationID`), each a combo `Description`/`LocationID`. Empty text `You do not have any logistics paths.` Add row = `ShopFloorLocationID null`. The Demand cell is not editable (`beforeedit`) in some cases tied to whether the location is already used by another path. Save-time checks (`ValidateLogisticsPaths`, only dirty rows):

| Rule | Message |
|---|---|
| Any of the three locations empty | `Please select components, shop floor and demand locations in each row.` |
| Demand is a shop-floor location different from the row's shop floor | `Shop floor cannot be linked to another shop floor, only with itself or a demand location.` |
| The same shop floor appears in another row with a different components location | `Shop floor cannot be linked to two different components locations.` |
| Summary toast when any failed | `There were issues validating the logistics path. See errors in details.` |

Deleting a path: confirm text `Are you sure you want to delete this logistics path?`, or when `NumberOfExistingOrders > 0` and no other row keeps the same shop floor: `This logistics path is used for production order procurement tasks. Would you like to proceed?`.

## Edit location (`/TenantLocationEdit`, bundle `TenantLocationEdit`)

Hash routes: `#new` or `#<LocationID>`; the header `select#cmbLocationList` switches location (`/api/TenantLocationEdit_TenantLocationList`); `403` on load shows the response text as an error toast. Location read/write `/api/TenantLocationEdit_vTenantLocation`. Tabs: General, Transfer planning, Bins, Pick zones, Supply rules, Delivery calendar. Tabs for a saved location depend on its type and status (see Visibility below). Leaving with `isSaved === false` triggers the page-leave warning.

General tab:

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`Description`, `#txtTenantLocationName`) | text | empty | Required; when creating, must not equal an existing location name (`findExact`; case-sensitive). | `Please enter a location name.` ; `The location with {name} already exists. Please enter a unique name for location.` |
| Type (`#cmbLocationType`) | select: `Warehouse/retail` (value `Warehouse`), `Fixed assets` (`UseForFixedAssetsOnly`), `Shop floor` (`IsShopFloor`), `Co-manufacturing` (`IsCoMan`); sent as three booleans | Warehouse/retail | The option `Fixed assets` is (re)enabled on load when `window.EnableFinancials` is true (otherwise it keeps the server-rendered state), is disabled when the connected accounting package is Xero (`window.Xero`) and the type is not already Fixed assets, and is disabled while the current type is Co-manufacturing. `Co-manufacturing` is disabled while Default is ticked or when type is Fixed assets or Shop floor. `Shop floor` is disabled while type is Fixed assets or Co-manufacturing. Choosing Fixed assets forces status Active and disables the Deprecated radio. | none |
| Status (radio `#rbtnTenantLocationActive` / `#rbtnTenantLocationDeprecated`, `IsDeprecated`) | radios | Active | Deprecated radio disabled for Fixed assets. The "Default" badge (`#spnLocationStatus`) is shown only while Set as default is ticked. | none |
| Set as default (`IsDefault`) | checkbox | false | Disabled for Fixed assets and Co-manufacturing types. | none |
| Allow to reorder stock level (`AllowReorder`) | checkbox | true for a new location | none | none |
| Use directed pick (`UseDirectedPick`) | checkbox | false | Disabled for Fixed assets / Co-manufacturing. Ticking shows the note about bin-group priority unless the batch/serial recommend mode is 2. | none |
| Use directed receive/put away (`UseDirectedPutAway`) | checkbox | false | Disabled for Fixed assets / Co-manufacturing. Ticking reveals Bin suggestion priority and pre-selects the first option when blank. | none |
| Bin suggestion priority (`BinSuggestionPriority`) | combo: 1 `Empty first`, 2 `Loaded first`, 3 `Alphabet (ascending)`, 4 `Alphabet (descending)` | 1 once shown | Required when Use directed put away is ticked. | `Please choose a priority for suggested bins.` |
| Address lines (`AddressLine1`, `AddressLine2`, `AddressCitySuburb`, `AddressStateProvince`, `AddressZipPostCode`) and Country (`AddressCountry`, remote combo `/api/country`, value = name) | text / combo | empty | If any address field has a value, Line 1, City / suburb, ZIP / postcode and Country become required. | `Please add address line 1.` ; `Please add city / suburb.` ; `Please add zip / postcode.` ; `Please select a country.` |
| Description (`MultiLineDescription`) | auto-height textarea, placeholder `Type description` | empty | none | none |
| Delivery number per day (`DeliveryNumberPerDay`, `#txtDeliveryNumberPerDay`) | number | `0` for a new location | Checked unless type is Co-manufacturing: empty or negative refused. | `Delivery number per day can not be empty.` ; `Delivery number per day can not be negative.` |
| Delivery time interval, mins (`DeliveryTimeInterval`) | number | `60` for a new location | none in client | none |

Country-specific: when `window.CountrySpecificKey === 'ARE'` and the address country is `United Arab Emirates`, extra emirate fields are shown (`CountrySpecificData`, `#divLocationEmirate`).

Visibility rules: the Transfer planning, Bins, Pick zones, Supply rules, Delivery calendar tabs are hidden when the location is Deprecated, Fixed assets or Co-manufacturing; for a Co-manufacturing location only the Supply rules tab stays available when it is active. Bins/pick zone add buttons require a saved location: `Location is not saved. Please click save before adding bins to the selected location.` / `Location not saved. Please click save before adding pick zones to the selected location.`

Bins tab: sub-tabs Bins, Directed put away rules, Bin groups. Bin grid columns: Bin description (`Description`, text), Bin group (`BinGroupID`, combo), Rule (`PutAwayRuleIDsFake`, read-only), Work center (`WorkCenterIDsFake`, multi combo over `/api/TenantLocationEdit_vWorkCenters`), Staging (`IsStaging`, check; tooltip explains a staging bin is a rack-free zone), Deprecated (`IsDeprecated`, check; editable only for already-created bins and non-ReadOnly), Delete. Description must be unique in the grid (edit empties the cell and shows `Bin description should be unique.`); empty at save -> `Some of Bins description are empty.` (row text `Bin description should not be empty.`). Save per bin `POST/PUT /api/TenantLocationEdit_vTenantLocationBin` (toast `Bin has been created.` / `Bin saved successfully.`), delete `DELETE /api/TenantLocationEdit_vTenantLocationBin/<id>` after `Are you sure you want to delete the Bin?` (toast `Bin has been deleted.`). Empty text `You do not have any bins in the selected location at the moment.` Search box `#txtBinsSearchField`, Export/Import buttons.

Pick zones tab: one `Pick zone` name per row, unique (`Pick zone name should be unique.`); empty -> `Some of Pick zones name are empty.`; delete confirm `Are you sure you want to delete the Pick zone?`.

Directed put away rules (`/api/TenantLocationEdit_vPutAwayRule[/<id>]`, `_vPutAwayRuleBins`, `_vPutAwayRuleUOMData`): fields Name (required, unique in list), Active, Bin multi-select (at least one), Min/Max capacity, Min/Max length/width/height/weight, Allow batch split at receive/put away, product scope (All products or Select products). Rules (`ValidateRule`): `Please select at least one bin.`; products scope not all -> `Please select products.` and `Rule for selected products already exists. Please define a unique product selection.`; units of measure not set up and any dimension entered -> `Please set up units of measure from General Settings - Product and measurement settings.` (link to `/TenantGeneralSettings`); otherwise per dimension: min empty -> `Please set the minimum capacity for the bin(s).` / `Please set the minimum length for products put away to bin(s).` (width, height, weight alike); max below min -> `Maximum capacity cannot be less than minimum capacity.` / `Maximum length cannot be less than minimum length.` (width, height, weight alike). Delete confirm `Are you sure you want to delete the Put away rule?`.

Bin groups (`/api/TenantLocationEdit_vBinGroup[/<id>]`, `_vBinGroupBins`): Name required and unique (`Please enter a group name.` / `The group with {name} already exists. Please enter a unique name for group.`), at least one bin (`Please select at least one bin.`). Delete confirm `Are you sure you want to delete the Bin group?`.

Supply rules (`/api/TenantLocationEdit_vSupplyRule[/<id>]`): Name (required, unique: `Please enter a rule name.`), Active, scope All products / Select products (families, tags, categories, brands, products; same product-scope validation as above) plus an ordered list of action lines: action `Purchase` / `Transfer` / `Produce`, source (location or supplier-selection), take `All available` / `Until minimum before reorder` / `Until stock level`, fulfil `Total demand quantity only` / `Partial demand quantity`, `if > <n> % production capacity is available`, supplier choice `With the lowest price` / `With the lowest lead time` / `Latest supplier`, followed by an "otherwise" line. Checks: only one active rule may apply to all products (`A rule for all products already exists.`); every visible control in every action line must be filled (`All rule fields must be filled`); saving with no action chosen warns `Please choose supply action first.`. Delete confirm `Are you sure you want to delete the Supply rule?`.

Transfer planning tab (`/api/TenantLocationEdit_DemandLocationList`): per demand location a planning method `Transfer at intervals` or `Transfer on fixed days`. Interval method: Interval (days, positive) and Start date; fixed method: tick Monday..Sunday. Validation: `Please select the transfer planning method.` ; `Please enter positive number to set period in days.` ; `Please select the start date.` ; `Please select at least one day to plan transfer.`; delete confirm `Are you sure you want to delete transfer planning method?`.

Delivery calendar (`/api/TenantLocationEdit_DeliveryYearCalendar`): year calendar with holidays and special days; times held as seconds; `IsValidCycleTime`, holiday-date and working-date checks exist in the bundle (`FactoryCalendar_*`, a calendar shared with the production calendar) and are described with the production calendar module, not here.

## Chart of accounts (`/ChartOfAccounts`, bundle `ChartOfAccounts2019`)

Read: `GET /api/ChartOfAccounts_Index_vChartOfAccounts` (grouped by `Class`, tree-indented), reference data `/api/ChartOfAccounts_Index_ReferenceData` (system accounts, class/type list, status codes). Accounts are edited in a modal (`#divChartOfAccountsIndexContentDialog`) with tabs General and Accounting dimensions; bank accounts in a second modal (`#divChartOfAccountsBankContentDialog`). Save is a single `POST` (new) or `PUT` (edit) of the record to `/api/ChartOfAccounts_Index_vChartOfAccounts` (bank: `/api/ChartOfAccounts_Index_vBankAccounts`); success toast `Account has been saved.` and the list reloads; failures use `ProcessException`. There is no client delete: accounts are archived via Status; `Delete unused archived accounts` submits form `frmDeleteArchived`.

Tenant settings that change the page: `window.Xero` (connected to Xero): the grid becomes read-only (`IsReadOnly = true`), New/Bank hidden, `Load from Xero` shown, row click does nothing. `window.Quickbooks`: New/Bank hidden, `Load from QuickBooks` shown (goes to `/QuickbooksImportExport/Quickbooks`); editing a row locks Name, Description, Status, Accept payments, Code and Account type; System account is locked unless it is empty or `UNPAIDEXPCLM`. Neither: `Use default` visible for writers. `window.EnableFinancials` gates bank-account detail editing (see Bank accounts). Chart mode from the account-info record: `ChartOfAccountsType` = `flat` or `tree`, with `ChartOfAccountsDelimiter`, `ChartOfAccountsDelimiterPlaceholder`, `ChartOfAccountsDotPlaceholder` (tree mode adds Parent account, sub-account codes and expand/collapse).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Parent account (`#tdParentAccount`, tree mode only) | select of existing accounts | none | Child inherits Type/Class/System account fields (`SetInheritedFields`) and `ForPayments`, which is then locked to the parent's value. | none |
| Account type (`Type`, `#tdChartOfAccounts_Index_AccountType`) | select grouped by class (optgroup = `AccountClass`, option = `Description`, value = `AccountType`) from `vAccountTypesAndClasses`; the `BANK` type is disabled in this dialog | null on New | `Class` is derived on save from the chosen type. No required check in the client. Locked for QuickBooks. | none |
| System account (`SystemAccount`, `#tdSystemAccount`) | select from `SystemAccounts`; `NONE` sent as null; `DEBTORS` and `CREDITORS` are the only ones that allow multiple accounts | `NONE` on New | Always disabled while editing an existing account (set only at creation). Choosing `DEBTORS` forces and locks the dimension attribute "Customer"; `CREDITORS` forces and locks "Supplier" (`adjustAccountingDimensions`). | none |
| Code (`Code`, `#tdChartOfAccounts_Index_Code`) | text, placeholder `Enter a code` | empty (tree child: next number, zero-padded to the last sibling's length, `01` for the first) | Tree mode only (`TreeMode_Validation`): must not contain the delimiter or dot placeholder; full code (parent + delimiter + child) at most 50 characters; renaming a parent must keep every sub-account code within 50. `.` in the typed code is replaced by the dot placeholder before sending. | `Please don't use disallowed symbols in account code: {delimiterPlaceholder}, {dotPlaceholder}.` ; `Full account code exceeds maximum length = 50.` ; `New account code {code} cannot be applied because one or more subaccounts exceeds maximum code length = 50.` |
| Name (`Name`) | text, placeholder `Enter a name` | empty | none in client | none |
| Description | textarea, placeholder `Enter a description` | empty | none | none |
| Status (`Status`) | select from `vAccountStatusCodes` (`ACTIVE`, `ARCHIVED`) | `ACTIVE` on New | Switching to `ARCHIVED` on an account with sub-accounts asks (reverts to `ACTIVE` on No). | `Archiving a parent account will also archive its subaccounts. Do you want to archive the parent account?` |
| Accept payments (`ForPayments`) | checkbox | false | Disabled when a parent is chosen (inherits). | none |
| Accounting dimensions tab | table Dimension / Enable with a checkbox per dimension attribute | inherited from parent | Enabling/disabling is checked via `/api/AccountingDimensions_Index_InUse`; disabled for bank accounts' non-leaf rows. | `The accounting dimension {name} has already been used in transactions and is not allowed to be disabled.` |

Adding the first sub-account to an account asks: `You are adding a first sub-account to an account.` + `The system will transfer all historical data from the higher level account to this sub - account.` + `Do you want to continue?` (buttons Yes/No). Grid: columns Class (hidden), Code, Name, Type, Status badge (`Active` / `Archived`), plus a colAdd cell to add a sub-account (only for ACTIVE parents); filter select `#divFilter` (classes + `All Accounts`) and `Show archived` checkbox (`ChartOfAccounts_Index_IsRecordVisible`: ARCHIVED rows shown only when ticked). Empty text: `Please either load the chart of accounts from accounting software or use the default chart before trying to evaluate our system. Without the chart of accounts and account mapping, the system won’t work.`

Use default: confirm `This will restore your chart of accounts to the Cin7 Core default. Active accounts may be archived and archived accounts made active again. You cannot undo this action. Are you sure you want to restore default accounts?` -> `POST /ChartOfAccounts/FillByDefault`; toasts `Operation completed successfully.`. Import (`/ChartOfAccounts/Import`, Dropzone): one file, `.txt,.csv`, max 32 MB. Errors `Only .txt and .csv files are supported.` ; blocked when connected to an accounting package: `It is not allowed to import accounts when Xero/QuickBooks is connected.`; read-only: `It is not allowed to import accounts in read-only mode.`; a failed upload shows `Server communication error`. Result messages: `Accounts have been imported successfully.` / `Accounts have been imported with errors.`; per-cell errors in an exceptions grid (empty cell shown as `<empty>`).

## Bank accounts (`/BankAccounts`, bundle `BankAccounts2019`; creation lives on Chart of accounts)

List of cards from `GET /api/BankAccountList_Index_vBankAccounts` (60 s timeout): account name (link to `/BankAccount?accountId=<id>`), code, currency, statement balance (`-` when no statement was ever imported and balance is 0), balance in the system, last statement date (`No statement imported.` when none), a `Reconcile {n} item(s)` button (link `/BankAccount?accountId=<id>&tab=tabReconcile`, only when `TransactionCount > 0`; disabled look when ReadOnly). Empty: `There are no bank accounts created for your organization yet.` Editing the details modal opens only when the user is not read-only, the accounting package is not Xero, and `window.EnableFinancials` is true (`BankAccounts_Index_OpenDetails`).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Account currency (`Currency`) | shown in the modal (set from the record; not sent as an edit) | account's | not editable here | none |
| Bank name (`Bank`) | text | `Unknown bank` if blank on save | trimmed-empty becomes `Unknown bank` | none |
| Account name (`AccountName`) | text | record value | none | none |
| Account code (`AccountCode`) | text, tree codes restored for display | record value | not part of the save payload changes | none |
| Account number (`AccountNumber`) | text | `No number` if blank on save | trimmed-empty becomes `No number` | none |
| Initial balance (`InitialBalance`) | text with `dearMoney` numeric mask (no plus/minus signs) | record value | numeric only, no negatives | none |
| Status (`Status`) | combo `ACTIVE` / `ARCHIVED`, not editable text | `ACTIVE` (the modal always resets to ACTIVE on open) | none | none |

Save = `PUT /api/ChartOfAccounts_Index_vBankAccounts` then reload the card list. The same fields appear in the Chart of accounts bank dialog, which adds Parent account and Account currency (read-only after creation; new bank accounts start with `InitialBalance` 0, `StatementBalance` 0, `BalanceInDear` 0) and creates via `POST`. Bank type cannot be chosen in the normal account dialog.

## Account mapping (`/AccountMapping`, bundle `AccountMapping2019`)

All controls are `selectpicker` selects filled from the active chart (`/api/ChartOfAccounts_Index_vChartOfAccounts`, `includeXeroAccountsIfPossible=<Xero flag>`), grouped by account class; option text `<code>: <name>`; the stored value is the code. Archived accounts are never offered. Save (`#divSaveChanges`) copies each value into hidden inputs (`h<Field>`, `null` -> empty string) and submits form `frmMapping` as a normal post (not Ajax). Tenant settings: `Xero` shows `#divIntegrationWarning`; `Quickbooks` shows `#divQBIntegrationWarning` and the supplier-deposit zero-tax rule; `#hShowInventoryAccrual` decides whether Goods received not invoiced and Goods invoiced not received take part in the duplicate check; `CountrySpecificKey` loads `/AccountMapping/CountrySpecific?Key=<key>` and adds its data to the post (`hCountrySpecificKey`, `hCountrySpecificData`). Currency gain/loss and Payment clearing selects exist only when the page renders them.

| Field | Control & which accounts are offered | Rule / validation | Message |
|---|---|---|---|
| Inventory control account (`InventoryControlAccount`) | class ASSET, type not FIXED/BANK, no system account | none individually | none |
| Inventory discrepancy account | class ASSET or EXPENSE, or LIABILITY of type CURRLIAB; not FIXED/BANK; no system account | none | none |
| Goods received not invoiced account (`InventoryAccrualAccount`) | class LIABILITY or ASSET; no system account; not FIXED/BANK | row hidden unless accrual accounting is on | none |
| Goods invoiced not received account (`StockInTransitAccount`) | same list as Inventory control | as above | none |
| Cost of goods sold account | class EXPENSE | none | none |
| Default revenue account | class REVENUE | none | none |
| Tax liability account | type CURRLIAB | none | none |
| Customer credit account (`SalePrepayment`) | no system account and: Xero: class LIABILITY or ASSET; QuickBooks: LIABILITY/ASSET of type CURRLIAB; otherwise class LIABILITY | none | none |
| Supplier deposits account (`PurchasePrepayment`) | no system account, type not BANK | Choosing a value shows the Supplier deposit zero-rated tax rule row (`AccountMapping_ApplyTaxRuleVisibility`); clearing hides it. | none |
| Supplier deposit zero-rated tax rule (`QBSupplierDepositZeroTax`) | tax rules with `EffectivePercentExclusive == 0` (`/api/AccountMapping_Index_vTaxationRules`) | shown only for QuickBooks and only with a supplier-deposit account | none |
| In-transit account (`TransferInTransit`) | no system account, type not BANK, class ASSET | none | none |
| Current year profits account | type EQUITY | none | none |
| Unrealized / Realized currency gains account | accounts whose system account is `UNREALISEDCURRENCYGAIN` / `REALISEDCURRENCYGAIN` | none | none |
| Work in progress account | same list as Inventory control | none | none |
| Gift card liability account | no system account, not FIXED; class LIABILITY with Accept payments on (not BANK), or any ASSET/LIABILITY under QuickBooks | none | none |
| Payment clearing account | type BANK | none | none |

Duplicate rule (`Validate_Duplicate_Account_Selection`, on Save): any non-empty code selected in more than one field blocks the save; the message lists `<code> <name>` of each duplicate separated by `, `.

| Rule | Message |
|---|---|
| same account mapped twice | `The same account cannot be mapped twice. Please select a unique account for each account mapping field. Duplicated accounts are {0}.` |

No field is required in the client (empty values are posted as empty strings); the first control gets focus. A previously saved value is pre-selected (`data-default-val`) and flagged `edited`.

## Accounting dimensions (`/AccountingDimensions`, bundle `AccountingDimensions2019`)

One document, fixed to 10 attribute slots (`Name1..10`, `Type1..10`, `ListValues1..10`, `IsActive1..10`) shown as 10 grid rows (`AttributeID` "1".."10"); rows are never added or deleted in the grid (the delete column only shows for rows flagged `isNew`, which never happens). Loaded via `GET /api/AccountingDimensions_Index_vAccountingDimensions` (5 min timeout), saved via `PUT` of `{Original:[...], Updated:[...]}`. Permission is read with `CheckAccess('AccountingDimensions', 'Settings')`; ReadOnly hides Save.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`Name`) | text | empty | Required for every row on Save (also for unused rows if the store marks them, as written). | `Name is required` (row text) ; toast `There were problems saving changes. Please see the errors in details.` |
| Type (`Type`) | combo, forced selection: `Text`, `List`, `Checkbox` (the enum also has NotUsed, Product, Customer, Supplier, ExpenseClaim, CompanyContact, ProductionResource which the grid can display but not choose) | as loaded | none | none |
| Values (`ListValues`) | text | as loaded | Editable only when Type = `List` (otherwise the cell renders ` N/A ` and `beforeedit` returns false). After edit values are split on `,`, trimmed and rejoined with `, `. List with empty values is refused. On save, non-List rows have `ListValues` set to empty. | `Values must be filled` |
| Active (`IsActive`, bool) | check column | as loaded | none | none |

Slots not present in `usedIds` are posted as `Type = NotUsed`, `IsActive = false`. After a successful save, if list values of an existing row changed the page warns: `New accounting dimensions and values will be applied to new tasks going forward. No changes will be applied retroactively. ...` (message continues in the shipped text). Server validation comes back as `HasErrors` + `ValidationText` and is shown as a toast, default text `There were problems saving changes. Please see the errors in details.`; an HTTP failure shows the response `Message` (sticky toast, `Dear_Notification_ErrorNoHide`).

## Default field values (`/DefaultFieldValues/Customer|Product|Supplier`, bundle `DefaultFieldValues2019`)

One page script serving three entity types (`window.EntityType`). Data: `GET /api/DefaultFieldValues?entityType=<type>` (list of `{EntityType, FieldName, FieldValueID}`), save `POST /api/DefaultFieldValues` of only the non-empty fields (a cleared combo is simply omitted), reference data `/api/DefaultFieldValues/referencesdata?entityType=<type>`. The load/save wrapper (`DFVHandler`) and the field-name constants (`DefaultFieldValuesConstant`) are not in the cached page bundle. ReadOnly access hides Save and makes all combos read-only. Every combo has `emptyText 'Choose...'`, is type-ahead with a case-insensitive filter, and has no required rule. When no saved values exist for Product, all combos are cleared (`DefaultFieldValues_Product_SetDefaultValues`).

Product:

| Field | Control & values | Default | Rule / validation |
|---|---|---|---|
| Type | combo: `Stock`, `Service`, `Gift card` (value `GiftCard`), `Non-inventory` (value `Non Inventory`), `Fixed asset` (value `Fixed Asset`) | none | Drives which rows show (below). |
| Fixed asset type | combo of fixed asset types | none | Shown only for type Fixed asset; saved only when visible. |
| Category, Brand | combos of categories / brands | none | none |
| Costing method | combo: `FIFO`, `FIFO - Serial number`, `FIFO - Batch`, `FEFO - Serial number`, `FEFO - Batch`, `Special - Batch`, `Special - Serial number` (values FIFO, FISN, FIBATCH, FESN, FEBATCH, BATCH, SN) | none | Hidden and not saved for Service and Gift card. |
| Unit of measure | combo of units | none | none |
| Drop ship | combo: `No drop ship` (N), `Optional drop ship` (O), `Always drop ship` (A) | none | Hidden/not saved for Service and Gift card. |
| Product discount | combo of discounts | none | Hidden/not saved for Fixed asset and Gift card. |
| Default location | combo of locations (with bins) | none | Hidden/not saved for Gift card. |
| Additional attributes set | combo of attribute sets | none | none |
| I am selling this product | combo `Yes` (stored `false`) / `No` (stored `true`); the stored value is the inverse, "not sellable" | none | none |

Customer (combos): Currency, Sale account, Tax rule, Payment term, Account receivable, Sale price tier, Sales representative, Default carrier, Default location, Attributes set. When `SetDefaultValues` is applied (blank state) it picks the payment term named `30 days`, receivable account code `610`, price tier code `1`, the location named `Main warehouse`, attribute set `00000000-0000-0000-0000-000000000000` (none) and clears the rest, and fills the currency list from the tenant currencies (the tenant default when several).

Supplier (combos): Currency, Default carrier, Tax rule, Payment term, Account payable, Attributes set.

## Fixed asset types (`/FixedAssetType`, bundle `FixedAssetType2019`; reused inside Opening balances)

List of types (grid + small-screen table) from `/api/FixedAssetType_Index_vFixedAssetType`, edit in modal `#divNewFixedAssetTypeDialog` (titles `Add a new fixed asset type` / `Edit fixed asset type`). Access is checked as `CheckAccess('FixedAsset', 'Index')`. No delete in the client (no delete column). Save `POST`/`PUT` the record to the same URL; on success the list reloads, a `FixedAssetType_Save_Callback` (set when the dialog is embedded) is called with the saved model, and the modal hides.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name | text | empty | Required (`__HighlightInvalidFields` on `tdFixedAssetTypeName`, `...DepreciationMethod`, `...AveragingMethod`, `...AssetAccountCode`, `...AccumulatedDepreciationAccountCode`, `...DepreciationExpenseAccountCode`). | `<label> is required.` |
| Depreciation method | select: `No Depreciation`, `Straight Line`, `Declining Balance`, `Declining Balance (150%)`, `Declining Balance (200%)`, `Sum of the Years' Digits`, `Full Depreciation at Purchase` | empty | Required. | as above |
| Averaging method | select: `Full Month`, `Actual Days` | empty | Required. | as above |
| Rate % / Effective life | radio pair (`rbRate`): Rate (`Rate`, text) or Effective life (`EffectiveLife`) | Rate selected on New; on Edit, Rate if the stored rate > 0, else Effective life | Mutually exclusive: choosing Rate disables and clears Effective life; choosing Effective life clears Rate. Neither is required here (the server decides). | none |
| Asset account | select of fixed-asset accounts (`/api/FixedAssetType_Index_vChartOfAccountsFixedAsset`) | empty | Required. | as above |
| Accumulated depreciation account | same fixed-asset account list | empty | Required. | as above |
| Depreciation expense account | select of expense accounts (`/api/FixedAssetType_Index_vChartOfAccountsExpense`) | empty | Required. | as above |

ReadOnly disables all dialog fields and hides New.

## Opening balances (`/OpeningBalances`, bundle `OpeningBalances2019`)

One document (`BalanceWrapper`, `POST /api/OpeningBalances_Index`, timeout 2000 s, body = wrapper with Lines, MultiCurrencyLines, Purchases, Sales and `OpeningBalancesDate` `YYYY-MM-DD`; response reloads the wrapper). Tabs: balances (journal lines), outstanding purchases, outstanding sales, stock on hand, fixed assets (the Fixed asset tab is shown only when `!Xero && EnableFinancials`). Date: Month select + Year select (current year minus 10, 12 years). Once an opening balance exists (`isOBPresent`) the date is fixed to that stored date and is the date used for validation; otherwise it is the first of the chosen month and dated rows display the day before.

| Field / grid | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Opening date | Month and Year selects | none | Both required on Save. | `Please choose the opening balances date.` |
| Account lines: Debit, Credit (`Debit`, `Credit`) | money cells; totals row (`DebitTotal`, `CreditTotal`) | 0 | Entering a non-zero Debit zeroes Credit and vice versa. Accounts with system account `DEBTORS` or `CREDITORS`, or type `BANK`, are not editable inline: their cell is a link opening the multi-currency editor. Save is refused with no chart loaded. | `Please create your own or load the default chart of accounts before editing opening balances.` ; empty grid `Load your chart of accounts before editing opening balances.` |
| Inventory / Fixed asset flag (`InventoryAsset`) | checkbox column (header `Inventory/ Fixed asset` when financials on and not Xero) | as loaded | none | none |
| Multi-currency lines | Currency (combo; not editable for BANK accounts), Amount, Exchange rate (`Rate`, `decimalPrecision 5`), Amount in tenant currency | none | Rate must be positive; currency must be a 3-letter code. | `Rate should be positive.` ; `Please select the currency.` ; summary `Failed to save changes. Please see the issues found in the details below.` ; empty `Add amounts in all currencies for the account.` |
| Outstanding purchases | Supplier (combo), Currency, Invoice # (`SupplierReference`), Invoice date, Amount, Conversion rate (`decimalPrecision 5`), Total | none | Conversion rate editable except while the row is `Pending`. Rules: rate > 0, supplier chosen, amount non-zero, invoice number present and at most 256 characters, invoice date on or before the opening date. | `Conversion rate must be positive.` ; `Please select a supplier.` ; `Please specify an amount.` ; `Please enter the invoice number. ` ; `Invoice number length should not exceed 256 characters.` ; `The invoice date should be prior or equal to the opening balances date.` ; empty `Add outstanding bills prior to opening balances date.` |
| Outstanding sales | Customer, Currency, Invoice #, Customer reference (`CustomerReference`), Invoice date, Amount, Conversion rate, Total | none | Same as purchases with customer wording; customer reference at most 256 characters. | `Please select a customer.` ; `Customer reference length must not exceed 256 characters.` ; others as purchases ; empty `Add outstanding invoices prior to opening balances date.` |
| Stock on hand (task detail editor, `/api/OpeningBalances_StockOnHandTaskDetails`) | Product, Location, Account, Unit cost (`decimalPrecision 7`), Received date, Quantity, Batch/serial #, Expiry date | none | Account required; unit cost positive. Void with `/Purchase/Cancel`. | `Please select an account.` ; `Unit cost should be positive.` ; `Not all the provided data is valid. Please check the details below:` ; `Changes saved.` ; empty `No stock on hand uploaded.` / `No opening stock on hand uploaded.` |
| Fixed asset details (`/api/OpeningBalances_FixedAssetTaskDetails`) | Product, Serial number, Location, Depreciation start date, Purchase date, Purchase cost, Asset / Accumulated depreciation / Depreciation expense accounts, Rate % or Effective life | none | Row rules: product, serial number, location, purchase date selected; purchase cost positive. Detail editor required list below. | `Please select a product. ` ; `Please select a serial number.` ; `Please select a location.` ; `Please select a purchase date.` ; `Purchase cost should be positive.` ; editor: `Product field is required.` ; `Serial number field is required.` ; `Location is required.` ; `Depreciation start date is required.` ; `Purchase date is required.` ; `Purchase cost is required.` ; `Asset account field is required.` ; `Accumulated depreciation account field is required.` ; `Depreciation expense account field is required.` ; `Either rate % OR effective life is required.` ; saved `Changes have been saved.` |

Import of outstanding purchases/sales: `.txt,.csv`, max 32 MB (`dictInvalidFileType: 'Only .txt and .csv files are supported.'`), URLs `/OpeningBalances/ImportOutstandingPurchasesJson` and the sales equivalent; success `Outstanding purchases have been imported successfully.`. ReadOnly hides every add/save/import button and disables the month/year selects. The page also embeds Add new customer / supplier / product / fixed asset type dialogs that reuse their own bundles' rules.

## Order routing (`/OrderRouting`, bundle `OrderRouting2019`)

One document (`vOrderRouting`: `OrderRoutingEnabled`, `OrderRoutingKeepRouting` and a child list `vOrderRoutingSettings`) saved with one `PUT /api/OrderRouting_Index_vOrderRouting`. Error toast on HTTP failure: `An error happened during saving.`; success `Changes saved successfully.`; a server-side `ValidationState == 'Error'` shows `ValidationText` or `There were problems saving changes. Please see the errors in details.`. Save runs only when there are pending changes; Ctrl+S too. Export/Import buttons (`frmExportOrderRouting`, `/OrderRouting/ImportOrderRouting`).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Order routing (`OrderRoutingEnabled`) | radio On / Off | as loaded (Off focused on load) | Off hides "Keep routing" and the settings table; On shows them. | none |
| Keep routing, regardless of the stock status (`OrderRoutingKeepRouting`) | radio On / Off | as loaded | Only visible when routing is On. | none |
| Settings rows (grid, tablet uses a modal) | Country (combo of `/api/country`, value = country name), State / province (text), City / suburb (text), ZIP / postcode (text), Location (combo of `/api/OrderRouting_Index_vTenantLocation`, value `ID`) | new row: guid id and Country = tenant country | No required rule in the client. The tablet modal shows server errors in `#OrderRoutingDetails_Errors` (`ModelState.serverError[0]`). | none |

Delete a settings row: `Do you really want to delete a location?` (Yes/No); rows live in memory until Save. Empty text `You do not have any settings at the moment.`

## Expense items (`/ExpenseItems`, bundle `ExpenseItemList`)

Reference data `/api/ExpenseItemList/ReferenceData` (accounts + accounting dimensions), items `/api/ExpenseItemList/ExpenseItems`, accounts `/api/ExpenseItemList/ChartOfAccounts`, save one `POST /api/ExpenseItemList/vExpenseItem` with the whole array (each item carrying `vDimensionDefaultValues`). Empty text `You do not have any expense items at the moment.` Tenant settings: accounting dimensions columns (`colAD*`) shown only with `IsAccountingDimensionsEnabled`, at least one active dimension and `DimensionsPermission` not `None`.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Description | text | empty | none in client | none |
| Account (`AccountCode`) | combo over the chart | empty | Required: any row without an account blocks the save. | `There were problems saving changes. Please see the errors in details.` |
| Accounting dimensions (`vDimensionDefaultValues`) | dialog from a `colAD` cell | none | read-only when `AccountingDimensionsReadonly`. | none |

Delete confirm `Are you sure you want to delete the expense item?`. Save success toast `Changes saved successfully.`; the grid reloads.

## Lead statuses (`/LeadStatus`, bundle `LeadStatus2019`)

Same grid pattern as Payment terms. Store `vLeadStatus`, idProperty `StatusID`, URL `/api/LeadStatus_Index_vLeadStatus`. A failed destroy puts the removed record back and shows the error on the row. Empty text `You do not have any custom lead statuses at the moment.`

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`Name`) | text / modal `#LeadStatus_Description` | empty | Modal save refuses empty. | `Name cannot be empty.` |
| Is active (`IsActive`) | check column | true | none | none |
| `IsKanban`, `Position` | not shown | `IsKanban` true, `Position` 9999 on a new row | no drag-reorder UI in this page | none |

Delete confirm `Are you sure you want to delete the lead status?`; the delete removes the row and calls `store.save()` (proxy destroy). (`IsFieldEditable` still references a `Duration (days)` column copied from Payment terms; this page has no such column.)

## Return reasons (`/RMAReasonForReturn`, bundle `RMAReasonForReturn2019`)

Server-searchable list (`/api/RMA_Index_vRMAReasonForReturn`, search text in `extraParams.search`, Enter key runs `loadPage(1)`), grid with one editable column Name (model `ReasonForReturn`: `ID`, `Name`, `CreatedDate`). Empty text `You do not have any return reasons at the moment.` Access is `CheckAccess('RMASetup', 'Index')`.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name | text | empty | none in client | none |

Save: nothing dirty -> warning `There is nothing to save.`; otherwise dirty rows go `Pending`, `store.save` success -> `Changes saved successfully.`, failure -> `There were problems saving changes. Please see the errors in details.`. Delete confirm `Are you sure you want to delete this reason?`.

## Return order settings (`/RMAReturnOrderSettings`, bundle `RMAReturnOrderSettings2019`)

One settings document, `POST /api/RMA_Index_Settings` (timeout 1 h); an id is generated client-side (`guid()`) when none exists. Loaded after the expense account list (`/api/RMA_Index_ExpenseAccounts`) and location list (`/api/RMA_Index_vLocation`) both load. Changes apply to new RMAs only.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Receive the returned products to (`DefaultReturnLocationID`) | combo of locations | as loaded | Required. | `Please select values for all controls.` |
| Non-warranty expense account (`NoWarrantyExpenseAccount`) | combo of expense accounts (code) | as loaded | Required. | as above |
| Warranty expense account (`WarrantyExpenseAccount`) | combo | as loaded | Required. | as above |
| Scrap/write-off default expense account (`ScrapWriteOffDefaultExpenseAccount`) | combo | as loaded | Required. | as above |
| Credit note creation and authorization setting (`CreateCreditNoteType`) | select: `After each product line is received`, `After all products are received` | as loaded | none | none |

Failure shows `Message` from the response. ReadOnly hides Save.

## Return policy (`/RMAReturnPolicy`, bundle `RMAReturnPolicy2019`)

List of policies (`/api/RMA_Index_vRMAReturnPolicy`, search box) with Name, Created, Updated, Active columns and a delete column (`Are you sure you want to delete the return policy?` -> `DELETE /api/RMA_Index_vRMAReturnPolicy/<id>`); edit form on the same page (hash routing). Empty text `You do not have any return policies at the moment.`

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name (`Name`) | text | empty | Required. | `Please enter a name for the return policy.` |
| Active (`IsActive`) | checkbox | true | Unticking asks for confirmation and reverts to ticked on No. | `Return policy will be deactivated starting from the date of the update. All products purchased before the date of the return policy's deactivation will be subject to the new return policy.` + blank line + `Would you like to proceed anyway?` (buttons `Yes!` / `No`) |
| Refund possible / days / payment option (`IsRefundPossible`, `RefundDays`, `RefundPaymentOptions`) | checkbox, number, radio `original` / `credit` | `original` | none in client | none |
| Replacement possible / days (`IsReplacementPossible`, `ReplacementDays`, `IsPossibleCrossSale`) | checkbox, number, checkbox | none | none | none |
| Return possible / days (`IsReturnPossible`, `ReturnDays`) | checkbox, number | none | none | none |
| Calculation start dates (`RefundCalculationStartDate`, `ReturnCalculationStartDate`, `ReplacementCalculationStartDate`) | combos | as loaded | none | none |
| Restocking fee (`RestockingFeesPercent` / `RestockingFeesFixedAmount`) | radio `percent` / `amount` choosing one number box | none | Choosing percent enables the percent box and disables the amount box (and vice versa); on save the unused one is sent as 0. | none |
| Policy text (`PolicyText`) | TinyMCE rich text | empty | none | none |
| Applies to (countries, categories, families, brands, tags) | multi-select chips (`emptyText 'Select country'`, `'Select category'`, `'Select family'`, `'Select brand'`, `'Select tag'`) | none | Before save, `POST /api/RMA_Index_vRMAReturnPolicy_ValidateConflicts` is called; if the response is not `success`, its `message` (HTML) is shown in a Yes!/No confirm and the save proceeds only on Yes. | server `message` |
| RMA processing milestones (grid) | rows with a milestone cost type (new types via `POST /api/RMA_Index_vRMACostType`, requires a name: `Please enter the milestone type name.`) | none | At least one milestone. | `Please enter at least one RMA processing milestone.` |

Save: `POST` (new) or `PUT /api/RMA_Index_vRMAReturnPolicy/<id>`; success `Changes saved successfully.`; error toast shows the response `Message` or `Error saving changes.`; an `Invalid` response shows the record's `ValidationText`.

## Warranties (`/WarrantySetupList`, bundles `WarrantiySetupList2019` + the warranty setup editor)

List (`/api/WarrantySetupList_Index_vWarrantySetup`, filter combo `#divFilter`, search box) with Name, Start date (`CalculationStartDate`), Terms (`TermsType`: `Lifetime` or `Calculated`), Active. Delete: confirm `Are you sure you want to delete this warranty?` -> `DELETE /api/WarrantySetupList_Index_vWarrantySetup/<id>`; toasts `The warranty has been deleted successfully.`, server `message`, or `Failed to delete this warranty.`. Empty text `You do not have any warranties at the moment.` Editor save: `POST /api/WarrantySetup_Index_vWarrantySetup` or `PUT .../<id>` (document with `HasErrors`, `Original`/`Updated`).

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name | text | empty | Required. | `Name field is required.` |
| Start date calculation (`CalculationStartDate`) | select (values include `Sales Order`, `Invoice`) | as loaded | none | none |
| Auto-generated number (`IsAutoGeneratedNumber`) | select/checkbox | as loaded | none | none |
| Terms (`TermsType`) | radio Lifetime / Calculated | as loaded | none | none |
| Terms period (`TermsUnitNumbers`, `TermsUnitInterval`) | number + interval select | none | When type is Calculated the number must be a positive number. | `The terms period field should be a positive number.` |
| Agreement, Active | text, checkbox | none | none | none |

## Discounts (`/DiscountListNew`, bundles `DiscountListNew2019` + `DiscountNew2019`)

List (`/api/DiscountListNew_Index_vDiscountNew`, search, refresh) with Discount name, Discount type, Status. Editor: `POST /api/DiscountNew_Index_vDiscountNew` or `PUT .../<id>` (hash = id). New discount: `Type = 'Simple'`, `IsActive = true`.

| Field | Control & values | Default | Rule / validation | Message |
|---|---|---|---|---|
| Name | text | empty | server-validated (`HasErrors`, `ValidationText`) | server text; default `There were problems saving changes. Please see the errors in details.` |
| Discount type (`Type`) | select: `Simple`, `Quantity Based`, `FreeShipping` (each shows its own section) | `Simple` | none | none |
| Simple: value type + amount | select (first entry default; includes `% Discount`, `% Markup`) + number mask | `0` (`0%` for percent types) | `% Discount` capped at 100 (value forced to 100). Changing the value type resets the amount. | none |
| Quantity based lines (grid) | Up to (`MaxValue`, `decimalPrecision 4`), Type of discount, Amount, Min | `No discount lines added.` | Line `% Discount` amount capped at 100 (type change or amount edit); `MinValue < 0` forced to 0. | none |
| Exceeds amount (free shipping) | number | none | none | none |
| Active | checkbox | true | none | none |

## Deals (`/DealList`, bundle `DealList2019`)

Read-only style list from `/api/DealList_Index_vDeal` with Deal name, Date from, Date to, Active. Empty text `You do not have any deals at the moment.` No editing, delete or validation in this bundle.

## Cin7 Core to Cin7 Core network (`/DearToDearNetworking`, bundle `DearToDear2019`)

Grid of connections (`Contact`, `Contact type`, `Is invite sent`, `Date when the invite was sent`, `Status`, `Date connected`, `Networking key`), save `PUT /api/DearToDear_Index_vDearToDearNetworking` (error `An error happened during saving.`). Regenerate networking key: confirm `You are going to regenerate your networking key. This will break all your current connections. Would you like to proceed?` -> `POST /api/DearToDear_Index_vIntegration/Regenerate` (success `Regenerated the networking key successfully.`; unsaved changes block it: `Please save the current changes before regenerating the networking key.`). Invitations require a clean state (`Please save your current changes before sending invitations.`); the email dialog requires `To` and subject (`Please specify the 'To' field.` / `Please specify the subject.`) and uses a bot-check token when the service requires one; success `Email has been sent successfully.`. Empty text `You do not have any connections at the moment.`

## Price tiers and currencies (not their own pages)

The module has no price-tier or currency page. Price tier names are fields of the General settings document (`PriceTierName1..10`, edited in `GeneralSettings2019`): tier 1 is always posted; tiers 2 to 10 are posted only when their control does not show the literal `Not Available`. Currency lists come from `/api/currency` and the tenant currency store (`vTenantCurrencyStore`: `Currency`, `Name`, `Default`). Their rules belong to the settings module.

## Not determinable statically

- Server-side checks: maximum lengths for every name/description/code field (the page scripts set none, apart from the 50-character full account code and the 256-character invoice number / customer reference checks), uniqueness enforced on save (carriers, units, categories beyond the client toast), and "in use" delete guards. A guarded delete returns an HTTP error whose `Message` is shown verbatim; the wording is server text and is not in the bundles.
- What makes a record "system" or locked beyond the flags above (for example which accounts carry a system account and cannot change type, or which locations are protected). The client only reads `SystemAccount`, `IsDefault`, `FFServiceID`, `IsCoMan`, `IsDeprecated`.
- The `DFVHandler` / `DefaultFieldValuesConstant` helpers (field names and the exact load/save calls) for Default field values, and the shared accounting-dimensions helpers (`Common_AccountingDimensions_*`), are not part of the cached bundles read.
- Default field values for Customer: how `SetDefaultValues` is triggered (the call site is in the missing handler).
- Select options rendered by the server HTML only (for example attribute types, location type labels) are taken from the UI layout capture, not from the scripts.
- HTML `maxlength` attributes and `required` markers on inputs; this reading covers scripts, not the markup.
- Behaviour behind `CountrySpecificKey` (extra scripts such as `/TenantLocation/CountrySpecific?Key=` and `/AccountMapping/CountrySpecific?Key=`) which are separate downloads.
- Sort order and filtering that happen on the server (`remoteSort`, `Position` ordering of statuses, paging of contacts and tax rules).
- The Delivery calendar editor (factory/delivery calendar helpers inside the location bundle) and the milestone grid of the return policy were read only for names, not field by field.
- The Shipping zone range check (`Max < Min`) reads field names the model does not define, so whether the server rejects bad ranges is unknown.
