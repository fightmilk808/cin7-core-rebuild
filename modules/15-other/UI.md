# Unassigned endpoints: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Components by bundle

### `ActivityLogs`

1 grids · 0 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ActivityLogs_Container` · store `ActivityLogsStore` · placeholder `There are no records in activity log at the moment.`
  - *columns:*
    - *(component built elsewhere: `gridColumns`)*

#### Menus, buttons and other parts

- **date column** “Date” · field `Date` · id `ActivityLogs_Date`
- **column** “Activity” · field `Message` · id `ActivityLogs_Message`
- **column** “Username” · field `UserName` · id `ActivityLogs_UserName`
- **column** “Reference” · field `Reference` · id `ActivityLogs_Reference`

### `BankAccount2019`

13 grids · 34 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `"recLineBankRuleGrid-".concat(…)` · store `window["recLineBankRuleStore-".concat(recId)]` · placeholder `No reconciliation rules found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reconcilation rule | `BankRuleName` |  | flex 3 | renderer() |  |
    | Payee | `BankRuleContactName` |  | flex 2 | RenderHTMLText |  |
    |  | `` |  | flex 3 | renderer() |  |
    |  | `` |  | flex 2 | renderer() |  |

- **grid** · renders into `"recLineMatchGrid-".concat(…)` · store `window["recLineMatchStore-".concat(recId)]` · placeholder `No matching transactions found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Transaction | `DocPerson` |  | flex 2 | renderer() |  |
    | Date | `DocDate` |  | flex 1 | renderer() |  |
    | Reference | `DocReference` |  | flex 2 | RenderHTMLText |  |
    | Amount | `ReconciledAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `"recLineDataGrid-".concat(…)` · store `window["recLineDataStore-".concat(recLine.get('ReconcileID'))]`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Payee | `Contractor` |  | flex 1 | RenderHTMLText |  |
    | Description | `Description` |  | flex 1 | RenderHTMLText |  |
    | Reference | `Reference` |  | flex 1 | RenderHTMLText |  |
    | Spent | `Amount` |  | flex 1 | renderer() |  |
    | Received | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBankRuleConditions` · store `window.vConditionStore` · placeholder `No conditions.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Field | `Field` |  | flex 2 | renderer() |  |
    | Condition | `Condition` |  | flex 2 | renderer() |  |
    | Expected value | `Expected` |  | flex 4 | renderer() |  |

- **grid** · renders into `divBankRuleFixedLines` · store `window.vFixedBankRuleLineStore` · placeholder `No fixed value line items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 4 | renderer() |  |
    | Account | `AccountCode` |  | flex 4 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 3 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBankRuleRelativeLines` · store `window.vRelativeBankRuleLineStore` · placeholder `No ratio value line items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 4 | renderer() |  |
    | Account | `AccountCode` |  | flex 4 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 3 | renderer() |  |
    | Percent | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `findMatchTransactionsGrid` · store `dialogMainStore` · placeholder `No transactions to reconcile.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 36 | renderer() |  |
    | Transaction | `Payee` |  | flex 2 | renderer() |  |
    | Date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Description | `Description` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    |  | `Split` |  | 44 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |

- **grid** · renders into `findMatchSelectedTransactionsGrid` · store `dialogSelectedStore` · placeholder `No selected transactions.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 36 | renderer() |  |
    | Transaction | `Payee` |  | flex 2 | renderer() |  |
    | Date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Description | `Description` |  | flex 1 | RenderHTMLText |  |
    | Reference | `Reference` |  | flex 2 | RenderHTMLText |  |
    |  | `` |  | 44 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |

- **grid** · renders into `findMatchAdditionalTransactionsGrid` · store `BankFeeAdjustmentStore` · placeholder `No additional transactions or bank fees.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `TransactionType` |  | flex 3 | renderer() |  |
    | To / from | `To` |  | flex 6 | renderer() |  |
    | Description / reference | `Description` |  | flex 4 | renderer() |  |
    | Account | `AccountCode` |  | flex 4 | renderer() |  |
    | Tax rule | `TaxRate` |  | flex 4 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |

- **grid** · renders into `findMatchMinorAdjustmentsGrid` · store `MinorAdjustmentStore` · placeholder `No minor adjustments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ID` |  | flex 3 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMoneyTaskLines` · store `window.vMoneyTaskLineStore` · placeholder `No line items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 4 | renderer() |  |
    | Account | `AccountCode` |  | flex 4 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 3 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divStatementsGrid` · store `window.vBankStatementStore` · placeholder `You do not have any bank statements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Imported date | `ImportedDate` |  | flex 1 | renderer() |  |
    | Start date | `StartDate` |  | flex 1 | renderer() |  |
    | End date | `EndDate` |  | flex 1 | renderer() |  |
    | Start balance | `OpenBalance` |  | flex 1 | renderer() |  |
    | End balance | `CloseBalance` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `transactionsGridContainer` · store `window.vTransactionsStore` · placeholder `No transactions to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Transaction | `Contact` |  | flex 3 | renderer() |  |
    | Date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Description | `Description` |  | flex 2 | RenderHTMLText |  |
    | Payment reference | `PaymentReference` |  | flex 2 | RenderHTMLText |  |
    | Spent | `Amount` |  | flex 1 | renderer() |  |
    | Received | `Amount` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo (+ add new) |  | `"divRecSpendReceiveCustomerSupplier-".concat(…)` | `vCustomersWithSuppliersStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| text field |  | `"divRecSpendReceiveReference-".concat(…)` | `` | placeholder `write...` |
| numeric field |  | `"divRecTransferAmount-".concat(…)` | `` |  |
| text field |  | `"divRecTransferReference-".concat(…)` | `` | placeholder `write...` |
| text field |  | `divBankRuleName` | `` |  |
| combo |  | `divBankRuleTarget` | `window.vBankRuleAccountMappingStore` | shows `AccountName` · value `AccountID` · placeholder `Target account` · pick-only |
| combo |  | `divBankRulePriority` | `window.vBankRulePriorityStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `divBankRuleContitionType` | `window.vBankRuleContitionTypeStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `divBankRuleContact` | `window.vBankRuleCustomerWithSuppliers` | shows `Name` · value `ID` · placeholder `Entered during reconciliation...` |
| combo |  | `divBankRuleReference` | `window.TextFieldsStore` | shows `description` · value `name` · pick-only |
| checkbox |  | `divFindMatchCurrency` | `` | checked |
| checkbox |  | `divFindMatchSameAmountSign` | `` | checked |
| text field |  | `divNewCustomerName` | `` |  |
| combo |  | `divNewCustomerPaymentTerm` | `window.vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| combo |  | `divNewCustomerSaleAccount` | `window.vChartOfAccountsLinesStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewCustomerSalesRep` | `window.vTenantContactsStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `divNewCustomerDefaultLocation` | `window.vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `divNewCustomerDiscount` | `` |  |
| combo |  | `divNewCustomerCurreny` | `window.currencyStore` | shows `Code` · value `Code` |
| combo |  | `divNewCustomerAccountReceivable` | `window.vChartOfAccountsNewCustomerStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewCustomerTaxRule` | `window.vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `divNewCustomerDefaultCarrier` | `window.vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| text field |  | `divNewCustomerTaxNumber` | `` |  |
| combo |  | `divNewCustomerSalePriceTier` | `window.vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| text field |  | `divNewSupplierName` | `` |  |
| combo |  | `divNewSupplierCurreny` | `window.currencyStore` | shows `Code` · value `Code` |
| combo |  | `divNewSupplierTaxRule` | `window.vPurchaseTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `divNewSupplierPaymentTerm` | `window.vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| text field |  | `divNewSupplierDiscount` | `` |  |
| combo |  | `divNewSupplierAccountPayable` | `window.vChartOfAccountsNewSupplierStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewSupplierDefaultCarrier` | `window.vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| text field |  | `divNewSupplierTaxNumber` | `` |  |
| combo (+ add new) |  | `divMoneyTaskContact` | `window.vMoneyTaskCustomerWithSuppliers` | shows `Name` · value `ID` · placeholder `Choose a contact...` |
| text field |  | `divMoneyTaskReference` | `` |  |

#### Menus, buttons and other parts

- **component** · id `"cmpRecSpendReceiveAccount-".concat(…)` · renders into `"divRecSpendReceiveAccount-".concat(…)` · store `vChartOfAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · id `"cmpRecSpendReceiveTaxRule-".concat(…)` · renders into `"divRecSpendReceiveTaxRule-".concat(…)` · store `window.vSpendReceiveTenantTaxationRuleStore` · shows `Description` · value `RuleID` · placeholder `Choose...`
- **component** · id `"cmpRecTransferBankAccount-".concat(…)` · renders into `"divRecTransferBankAccount-".concat(…)` · store `vBankAccountStore` · shows `AccountName` · value `ID` · placeholder `Choose...`

### `BankStatement2019`

3 grids · 2 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divTransactionLines` · store `transactionStore` · placeholder `The statement contains no transaction.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column |  | renderer() |  |
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Spent | `Amount` |  | flex 1 | renderer() |  |
    | Received | `Amount` |  | flex 1 | renderer() |  |
    | Status | `Status` |  |  | renderer() |  |

- **grid** · renders into `divMappingRules` · store `mappingStore`
  - *columns:*
    - *(component built elsewhere: `mappingColumns`)*
- **grid** · renders into `divMappingResults` · store `TargetResultsFieldStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ID` |  | 5 |  | hidden |
    | Property | `field` |  | 175 | renderer() |  |
    | Assigned data... | `Data` |  | flex 1 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `BankStatement_Index_DateFormat` | `dateFormatStore` | shows `Value` · value `Value` · placeholder `Statement date format` |
| combo |  | `divCmbPreset` | `vBankTransactionMappingProfileStore` | shows `Name` · value `ProfileID` · placeholder `You may select a preset...` · pick-only |

#### Menus, buttons and other parts

- **column** “Statement data...” · field `Source`
- **column** · field `Data`
- **column** “Assign to...” · field `Target`

### `GSuites2019Partial`

0 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Menus, buttons and other parts

- **button** “Save to Google Drive” · itemId `gdriveItem` · on click `handler()`

### `InventoroSettings2019`

10 grids · 1 standalone fields · 0 windows · 28 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `Grid_Index_classPrivateFieldGet(_SELECTORS,this).DIV_GRID` · store `store`
- **grid** · id `FSAI_Locations260324` · renders into `LocationsSettings_Grid_Index_classPrivateFieldGet(Index_SELECTORS,thi…` · store `store` · placeholder `CommonService.gridEmptyBlock`
- **grid** · id `SUPPLIERS_GRID_STATE_ID` · renders into `$container[0]` · store `store` · placeholder `CommonService.gridEmptyBlock`
- **grid** · id `FSAI_ProductRules` · renders into `SELECTORS.CONTAINER` · store `store` · placeholder `EMPTY_BLOCK`
- **grid** · id `FSAI_ProductRulesAffectedProducts` · renders into `GRID_DIV_ID` · store `store` · placeholder `CommonService.gridEmptyBlock`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | RenderHTMLText |  |
    | Product name | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Location | `Location` |  | flex 1 | RenderHTMLText |  |

- **grid** · id `FSAI_Log_Products_260408` · renders into `ProductLog_assertClassBrand(_ProductLog_brand,this,_getConta(…)` · store `store` · placeholder `CommonService.gridEmptyBlock`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU / Filter name | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Location | `Location` |  | flex 1 | RenderHTMLText |  |
    | Parameter | `Parameter` |  | flex 1 | renderer() |  |
    | Previous value | `PreviousValue` |  | flex 1 | renderer() |  |
    | New value | `CurrentValue` |  | flex 1 | renderer() |  |
    | Date | `TimeStamp` |  | flex 1 | renderer() |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |

- **grid** · id `FSAI_Log_Strategy_140726` · renders into `StrategyLog_assertClassBrand(_StrategyLog_brand,this,Strateg(…)` · store `store` · placeholder `CommonService.gridEmptyBlock`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Previous value | `PreviousValue` |  | flex 1 | renderer() |  |
    | New value | `CurrentValue` |  | flex 1 | renderer() |  |
    | Date | `TimeStamp` |  | flex 1 | renderer() |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |

- **grid** · id `FSAI_Log_Suppliers_220534` · renders into `SupplierLog_assertClassBrand(_SupplierLog_brand,this,Supplie(…)` · store `store` · placeholder `CommonService.gridEmptyBlock`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `SupplierName` |  | flex 1 | RenderHTMLText |  |
    | Parameter | `Parameter` |  | flex 1 | renderer() |  |
    | Previous value | `PreviousValue` |  | flex 1 | renderer() |  |
    | New value | `CurrentValue` |  | flex 1 | renderer() |  |
    | Date | `TimeStamp` |  | flex 1 | renderer() |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |

- **grid** · id `FSAI_Log_ProductRules_310912` · renders into `ProductRuleLog_assertClassBrand(_ProductRuleLog_brand,this,P(…)` · store `store` · placeholder `CommonService.gridEmptyBlock`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Rule name | `RuleName` |  | flex 1 | RenderHTMLText |  |
    | Parameter | `Parameter` |  | flex 1 | renderer() |  |
    | Previous value | `PreviousValue` |  | flex 1 | renderer() |  |
    | New value | `CurrentValue` |  | flex 1 | renderer() |  |
    | Date | `TimeStamp` |  | flex 1 | renderer() |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |

- **grid** · id `FSAI_Log_Locations_270634` · renders into `LocationLog_assertClassBrand(_LocationLog_brand,this,Locatio(…)` · store `store` · placeholder `CommonService.gridEmptyBlock`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationName` |  | flex 1 | RenderHTMLText |  |
    | Parameter | `Parameter` |  | flex 1 | renderer() |  |
    | Previous value | `PreviousValue` |  | flex 1 | renderer() |  |
    | New value | `CurrentValue` |  | flex 1 | renderer() |  |
    | Date | `TimeStamp` |  | flex 1 | renderer() |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `"extFilterValue_".concat(…)` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Predecessor” · field `PredecessorProductID`
- **column** “Replenished by” · field `ReplenishedBy`
- **column** “{title}” · field `fieldName` · id `"colFsaiProducts".concat(…)`
- **column** “{title}” · field `fieldName` · id `"colFsaiProducts".concat(…)`
- **column** “{"".concat(…)}” · field `IsActive`
- **column** “SKU” · field `ProductCode` · id `colProductCode`
- **column** “Location” · field `LocationName` · id `colFsaiProductsLocationName`
- **column** “Available for order” · field `CanBeOrdered`
- **column** “Smart Reorder suggestions” · field `ReplenishmentRecommendations` · hidden
- **column** “Product segment” · field `Segment` · hidden
- **column** “{"Attribute ".concat(…)}” · field `"CustomField".concat(…)` · id `"colCustomField".concat(…)` · hidden
- **component** · renders into `"extFilterValue_".concat(…)` · store `ParametersEditor_assertClassBrand(_ParametersEditor_brand,th \| @para…` · shows `paramRemoteData.NameField` · value `paramRemoteData.ValueField` · placeholder `Value`
- **column** “Hierarchy” · field `LocationName`
- **column** “{"".concat(…)}” · field `IsActive`
- **column** “{title}” · field `fieldName`
- **column** “{title}” · field `fieldName`
- **column** “Supplier” · field `SupplierName`
- **column** “{text}” · field `MinimumOrderAmount`
- **column** “Purchase order period” · field `PurchaseOrderPeriod`
- **column** “Lead time” · field `LeadTime`
- **column** “Set period and time” · field `BasedOnYourData`
- **column** · field `ID`
- **column** “Rule name” · field `Name`
- **column** “Criteria summary” · field `CriteriaSummary`
- **column** “Matching products count” · field `AffectedProductsCount`
- **component** · renders into `extPeriodComponentStartDate`
- **component** · renders into `extPeriodComponentEndDate`
- **component** · renders into `extCmbFsaiLogUser` · store `userStore` · shows `Name` · value `Value` · placeholder `All users`

### `QuickbooksSynchronisation2019`

1 grids · 2 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `History` · store `store` · placeholder `You do not have any synchronization items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `StatusBtn` |  | 28 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `DateCreated` |  | flex 1 | renderer() |  |
    | What to sync | `Description` |  | flex 2 | renderer() |  |
    | Error/Comment | `Error` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `tdFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `divUpdateStatus` | `updateStatusStore` | shows `text` · value `value` · placeholder `Change status` · pick-only |

### `StockTransferList2019`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `Grid` · renders into `StocktransferList_Index_Container` · store `mainStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 58 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |
    | Transfer # | `Number` |  | flex 1 |  |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | From | `From` |  | flex 1 | renderer() |  |
    | To | `To` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | User | `LastUpdatedBy` |  | flex 1 |  |  |
    | Reference | `CustomerReference` |  | flex 1 | RenderHTMLText |  |


#### Menus, buttons and other parts

- **component** · renders into `config.ctrlId` · store `config.store` · shows `displayFieldName` · value `valueFieldName` · placeholder `config.emptyText`

### `Stripe2019`

3 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `logsGridContainer` · store `self.logsStore` · placeholder `No log entries to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `InitTime` | date column | flex 2 | renderer() |  |
    | Sale invoice | `` |  | flex 1 | renderer() |  |
    | Amount | `` |  | flex 1 | renderer() |  |
    | Account | `` |  | flex 2 | renderer() |  |
    | Stripe payment ID | `` |  | flex 3 | renderer() |  |
    | Payment status | `StatusText` |  | flex 1 |  |  |

- **grid** · renders into `overviewDashboardGridContainer` · store `self.overviewDashboardStore` · placeholder `No payments to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `InitTime` | date column | flex 1 | renderer() |  |
    | Sale invoice | `` |  | flex 1 | renderer() |  |
    | Amount | `` |  | flex 1 | renderer() |  |

- **grid** · renders into `TenantBrand_Index_Container` · store `store` · placeholder `You do not have any brands at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Brand | `Brand` |  | flex 1 | RenderHTMLText |  |
    |  | `` | action column | 23 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `txtStripeAccountName` | `` | read-only |
| text field |  | `txtTimeZone` | `` |  |
| combo |  | `cmbTargetAccount` | `accountStore` | shows `DisplayName` · value `Code` · pick-only |
| number field |  | `numTestPaymentAmount` | `` | required |
| combo |  | `cmbCurrency` | `currencyStore` | shows `Code` · value `Code` |

