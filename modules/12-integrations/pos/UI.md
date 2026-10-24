# POS: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/DearPos` | POS | [`Pos2019`](#pos2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/DearPos`: POS

Frame: `ifrmUpload`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    slot #FeatureModuleDetailsBlock (hidden)
    text "Point of Sale"
    text "Read the full information sheet about Point Of Sale and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      heading #overview-portal-name
      block #overview-base-portal-settings (hidden)
        text "Base settings"
        slot #overview-portal-settings (hidden)
        slot #overview-portal-link
      block #overview-portal-logo (hidden)
      text "Sales summary"
      button "Refresh"#divRefreshSalesSummary
      slot #overview-sales-summary (hidden)
      tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers
      tab pane#overview-tab-sales
        input text#divSearchOverviewSales placeholder "Type text to search"
        button "Search" primary
        slot #overviewSalesGridContainer
      tab pane#overview-tab-customers
        input text#divSearchOverviewCustomers placeholder "Type text to search"
        button "Search" primary
        slot #overviewCustomersGridContainer
tab pane#tab-portal-settings
  tabs: Setup #tab-portal-setup | Quick Keys #tab-portal-quickKeys | Outlets #tab-portal-outlets | Users #tab-portal-users | Catalog #tab-portal-catalog | Bulk listing #tab-portal-bulkLoad | Sales #tab-portal-pendingOrders | Export payments #tab-portal-exportPayments | Log #tab-portal-log | Surcharge #tab-portal-surcharge | Credits, loyalty points, and email recei #tab-cclp | Cash payment setup #tab-portal-cashPaymentSetup | Cash reasons #tab-portal-cashManagementReasons | Barcode setup #tab-portal-barcodeSetup
  text "Point of Sale"
  text "Read the full information sheet about Point Of Sale and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  block #RegisterDataDetailsBlockOutlet
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your POS store requires reauthorization."
      form#frmReConnect
        button "Reconnect to POS" primary
    text "POS URL"
    link "https://pos.dearsystems.com"
    slot #customerStoreCreditAccountNotMappedError (hidden)
    slot #setupValidation (hidden)
    text "General settings"
    slot #consolidationTypeWarning (hidden)
    label "Capture POS sale when it is"
    slot #DearPos_Index_Topic
    label "Consolidate sales"
    slot #DearPos_Index_ConsolidationType
    block #divNonConsolidateWarning (hidden)
      text "Sales will be automatically processed every hour."
    block #divConsolidateWarning (hidden)
      text "On accounts sales will be automatically processed every hour. Other sales will be processed at designated time below."
    block #liDearPos_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #DearPos_Index_ConsolidationTime
    label "Customer"
    slot #DearPos_Index_Customer
    label "Sale price tier"
    slot #DearPos_Editor_PrimaryPriceTier
    label "Default sales tax"
    slot #tdDefaultSalesTax
    label "Zero tax"
    slot #tdZeroTax
    label "Tax inclusive"
    input checkbox#divECSspecificParameter2
    label "Pick, pack, and ship processing mode"
    slot #DearPos_Editor_AutoFulfilmentMode
    label "Process auto-assembly"
    slot #DearPos_Editor_CreateAssembly
    block #chkIgnoreRestockForNotFulfilledContainer
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
    label "Check availability on checkout"
    input checkbox#divCheckAvailabilityOnCheckout
    label "Customers load mode"
    slot #DearPos_Editor_LoadCustomersMode
    label "Ignore customer tax rule"
    input checkbox#divIgnoreCustomerTaxRule
    label "Payment workflow order"
    slot #DearPos_Editor_PaymentDisplayOrder
    label "Send receipt to customer"
    input radio#rbnSendReceiptToCustomerEmailBody name=SendReceiptToCustomer
    label "As part of the email body" for #rbnSendReceiptToCustomerEmailBody
    input radio#rbnSendReceiptToCustomerAttachment name=SendReceiptToCustomer
    label "As an attachment" for #rbnSendReceiptToCustomerAttachment
    text "Account and cash settings"
    label "Invoice status"
    slot #DearPos_Editor_InvoiceStatus
    label "Till discrepancy account"
    slot #tdECSspecificParameter7
    label "Petty cash"
    slot #DearPos_Editor_PettyCash
    label "Cash in/out"
    slot #DearPos_Editor_CashInOut
    label "Cash float account"
    slot #tdECSspecificParameter6
    label "Rounding account"
    slot #tdRounding
    label "Round to"
    slot #tdRoundTo
    label "Rounding rule"
    slot #tdRoundingRule
    label "Optional revenue account"
    slot #DearPos_Editor_RevenueAccount
    label "Use as sales rep"
    slot #DearPos_Editor_CmbCustomSalesRepresentative
    block #txtCustomSalesRepresentativeContainer
      label "Custom sale representative"
      slot #DearPos_Editor_CustomSalesRepresentative
    label "Receipt template"
    slot #tdECSspecificParameter3
    label "Enable loyalty"
    input checkbox#divECSspecificParameter4
    block #liLoyaityExpenseAccount
      label "Loyalty expense account"
      slot #tdLoyaltyExpenseAccount
    block #liLoyaltyEarning
      label "Earning loyalty"
      slot #divECSspecificParameter5
    text "Security settings"
    label "Default user's password"
    slot #divECSspecificParameter1
    label "Reply-to address"
    slot #DearPos_Editor_ReplyEmail
    label "Enable PIN"
    input checkbox#divEnablePin
    block #liPinLength
      label "PIN code length"
      slot #divPinLength
    label "Enable auto lock"
    input checkbox#divAutoLockEnabled
    block #divAutoLockAfterContainer
      label "Auto lock after (seconds)"
      slot #divAutoLockAfter
    text "POS integrations"
    label "Use Tyro"
    input checkbox#divUseTyro
    block #liTyroMerchantID
      label "Tyro merchant ID"
      slot #divTyroMerchantID
    label "Use Vantiv triPOS"
    input checkbox#divUseTriPOS
    block #liTriPOSAccountID
      label "triPOS account ID"
      slot #divTriPOSAccountID
    block #liTriPOSAcceptorID
      label "triPOS acceptor ID"
      slot #divTriPOSAcceptorID
    block #liTriPOSAccountToken
      label "triPOS account token"
      slot #divTriPOSAccountToken
    label "Use Paymentsense"
    input checkbox#divUsePaymentSense
    block #grpLoyaltyLion
      label "Use LoyaltyLion rewards"
      input checkbox#divUseLoyaltyLion
    label "Use Linkly Cloud"
    input checkbox#divUseLinkly
    label "Use Windcave"
    input checkbox#divUseWindcave
    block #liWindcaveUsername (hidden)
      label "Windcave username"
      slot #tdWindcaveUsername
    block #liWindcaveKey (hidden)
      label "Windcave key"
      slot #tdWindcaveKey
    text "POS UI settings"
    label "Catalog size"
    slot #tdCatalogTilesSize
    label "Tiles visibility"
    slot #tdCatalogTilesVisibility
    label "Product availability icon"
    input checkbox#cbCatalogShowProductAvailability
    label "Surcharge tax rule"
    slot #tdSurchargeTaxRule
    label "Use customer price tier"
    input checkbox#divUseCustomerPriceTier
    label "Use advanced barcodes"
    slot #tdAdvancedBarcodeMode
    text "POS templates"
    label "Closure register"
    slot #tdClosureRegisterReportTemplate
    label "POS email/print template"
    slot #tdSaleQuoteTemplate
    text "POS delivery scheduling settings"
    label "Enable delivery scheduling"
    input checkbox#cbDeliverySchedulingEnable
    block #divDeliveryArea
      label "No. Of deliveries per day"
      slot #divDeliveryNumberPerDay
      label "Delivery time interval, mins"
      slot #divDeliveryTimeInterval
      label "Delivery schedule template"
      slot #tdDeliveryTemplate
      label "Process sale order in 'Ship' status when delivery is marked as 'Completed'"
      input checkbox#cbDeliveryProcessShipSales
    text "Link POS payment methods to payment accounts"
    button #divAddCustomPayment primary
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    block #divDisconnect
      text "Disconnect from your POS store"
      button "Disconnect from POS store"
      form#frmDisconnect
  tab pane#tab-portal-quickKeys
    heading "Quick Keys"
    text "Quick Key templates"
    button "New"#newQuickKey
    slot #divQuickKeySelector
    text "Quick Key template details"
    block #quickKeyContainer
      block #quickKeyHeader
        slot #validationContainerQuickKeys (hidden)
        heading #titleQuickKeyName
        button "Reorder"#quickKeyReorder primary
        button "Save"#quickKeySave primary
        label "Quick Key template name"
        slot #tdquickKeyName
        heading "Quick Keys"
        button "New"#quickKeyAdd
    block #quickKeyAddBottom (hidden)
      button #quickKeyAdd primary
  tab pane#tab-portal-outlets
    heading "Outlets"
    button "Save"#divSavePosOutlet primary
    text "Outlets"
    button "Outlet"#newOutlet
    slot #divOutletSelector
    text "Outlet details"
    button "Register"#newRegistry
    form#frmEditOutletTemplate
      slot #divRegistryPlates (hidden)
      block #divRegistryPlatesNote (hidden)
        text "Please save this outlet before adding new registers."#divConsolidateWarning
      slot #validationContainerOutletEdit (hidden)
      button "Delete"#divDeleteOutlet primary
      label "Active"
      input checkbox#OutletActive
      label "Outlet name"
      slot #tdOutletNameEdit
      label "Outlet location"
      slot #tdOutletMappingValue
      label "Default sales tax"
      slot #tdOutletTaxRuleEdit
      label "Time zone"
      slot #tdOutletTimeZoneEdit
      label "Cash account"
      slot #tdOutletLedgerAccountEdit
      label "Receipt template"
      slot #tdOutletReceiptEdit
      label "Square integration to process returns"
      slot #tdOutletSquareIntegration
      block #liUsePaymentSenseURL
        label "Paymentsense outlet URL"
        slot #tdPaymentSenseURLEdit
      block #liUsePaymentSenseAPIKey
        label "Paymentsense outlet API key"
        slot #tdPaymentSenseAPIKeyEdit
      label "Print notes"
      input checkbox#PrintNotes
      label "Print discounts"
      input checkbox#PrintDiscounts
      label "Surcharge tax rule"
      slot #tdOutletSurchargeTaxRule
      label "Tyro merchant ID"
      slot #tdOutTyroMerchantID
      label "triPOS account ID"
      slot #tdOutTriPOSAccountID
      label "triPOS acceptor ID"
      slot #tdOutTriPOSAcceptorID
      label "triPOS account token"
      slot #tdOutTriPOSAccountToken
      label "Customized customer display view"
      input checkbox#CustomizedCustomerDisplayUI
      block #customization-section
        button "Add logo"#addLogoBtn primary
        block #outletLogoForm
          input file#outletLogoFile name=outletLogo
        label "Background"
        input text#cpBackgroundColor
      link "Link payment methods to payment accounts on outlet level"#btShowPaymentMappings
      link "Set product outlet level SKUs for advanced barcodes"#btShowOutletSKU
    text "Register details"
    form#frmEditRegistry
      slot #Registry_Index_ValidationContainer (hidden)
      button "Save"#divSavePosRegistry primary (hidden)
      button "Delete"#divDeletePosRegistry
      label "Active"
      input checkbox#RegisterActive
      label "Outlet"
      slot #registryOutletName
      label "Name"
      slot #tdRegistryCode
      label "Cash account"
      slot #tdRegistryLedgerAccount
      label "Receipt template"
      slot #tdRegistryReceipt
      label "Till discrepancy"
      slot #tdRegistryTillDiscrepancy
      label "Petty cash"
      slot #tdRegistryPettyCash
      label "Cash in/out"
      slot #tdRegistryCashInOut
      label "Cash float"
      slot #tdRegistryCashFloat
      label "Receipt prefix"
      slot #tdRegistryPrefix
      label "Receipt suffix"
      slot #tdRegistrySuffix
      label "Quick Key"
      slot #tdRegistryQuickKey
      block #liTyroTerminalID
        label "Tyro terminal ID"
        slot #tdTyroTerminalID
      block #liTriPOSLaneID
        label "triPOS lane ID"
        slot #tdTriPOSLaneID
      block #liLinklyUserName
        label "Linkly Cloud username"
        slot #tdLinklyUserName
      block #liLinklyPassword
        label "Linkly Cloud password"
        slot #tdLinklyPassword
      block #liWindcaveStation
        label "Windcave station"
        slot #tdWindcaveStation
      label "Catalog size"
      slot #tdRegistryCatalogTilesSize
      label "Tiles visibility"
      slot #tdRegistryCatalogTilesVisibility
      label "Product availability icon"
      input checkbox#cbRegistryShowProductAvailability
  tab pane#tab-portal-users
    heading "Users"
    button "New user"#divAddUser primary
    slot #userManagementGridContainer
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    slot #catalogGridContainer
  tab pane#tab-portal-bulkLoad
    heading "Bulk listing"
    slot #tdBulkCategory
    label "Category"
    slot #tdBulkListingBrand
    label "Brand"
    slot #tdBulkFamily
    label "Family"
    slot #tdBulkTag
    label "Product tag"
    slot #tdBulkListingStatus
    label "Listing status"
    slot #tdBulkListingListedIn
    label "Products listed in"
    input text#divSearchBulk placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshBulkCatalog
    button "List"#btnListBulk
    button "Unlist"#btnUnlistBulk
    button #Grid_bulkGrid_Options
    slot #DearPos_BulkListing_ValidationContainer (hidden)
    slot #divBulkList
  tab pane#tab-portal-pendingOrders
    heading "Sales"
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshPendingOrders
    button "Load sales"#divDownloadOrders
    button "Process"#divProcessOrders
    button #Grid_PendingOrders_Options
    slot #divPendingOrdersGrid
  tab pane#tab-portal-exportPayments
    heading "Export payments"
    input text#divSearchExportPayments placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshExportPayments
    button "Export to POS"#divExportPaymentsToDearPos
    button #Grid_ExportPaymentsGrid_Options
    slot #exportPaymentsGridContainer
  tab pane#tab-portal-log
    heading "Log"
    input text#divSearchLog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshLog
    slot #divExportLogPeriod
    slot #divExportLogFrom
    slot #divExportLogTo
    button "Export"#divExportLog
    slot #logGridContainer
  tab pane#tab-portal-surcharge
    heading "Surcharge"
    button "New surcharge"#divAddSurcharge primary
    block #divSurchargeWarning
      text "Please select surcharge tax rule in POS setup to enable surcharges."
    slot #surchargeGridContainer
  tab pane#tab-cclp
    heading "Credits, loyalty points, and email receipts"
    input text#divSearchCCLP placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCCLP
    button "Export"#divExportCCLP
    button "Import"#divImportCCLP
    button #Grid_cclpGrid_Options
    slot #cclpGridContainer
  tab pane#tab-portal-cashPaymentSetup
    heading "Cash payment setup"
    button "Denomination"#divAddDenomination primary
    block #divCashPaymentSetup (hidden)
    slot #cashPaymentSetupGridContainer
  tab pane#tab-portal-cashManagementReasons
    heading "Cash reasons"
    button "Reason"#divAddCashManagementReason primary
    block #divCashManagementReasons (hidden)
    slot #cashManagementReasonGridContainer
  tab pane#tab-portal-barcodeSetup
    heading "Barcode setup"
    block #divBarcodeSetup
      text "Please setup barcode configurations"
    text "Barcode settings"
    label "Advanced barcode SKU length"
    slot #divAdvancedBarcodeSKULength
    label "Advanced barcode value length"
    slot #divAdvancedBarcodeValueLength
    block #sectionAdvancedBarcodeValueDecimalPoint
      label "Advanced barcode value decimal point"
      slot #divAdvancedBarcodeValueDecimalPoint
    label "Advanced barcode uses outlet SKUs"
    input checkbox#divAdvancedBarcodeUseOutletSKU
    label "Advanced barcode has delimiter"
    input checkbox#divAdvancedBarcodeHasDelimiter
    text "Sample barcode format"
    block #AdvancedBarcodeSampleManual (hidden)
      block #gt1Manual
      slot #gtDelta1Manual
      block #gt3Manual
      block #gt5Manual
      block #gSKUManual
      block #gDelimiterManual
      block #gValueManual
      block #gt2Manual
      slot #gtDeltaManual
      block #gt4Manual
    block #AdvancedBarcodeSampleGS1Main (hidden)
      block #gt1GS1Main
      slot #gtDelta1GS1Main
      block #gt3GS1Main
      block #gt5GS1Main
      block #gSKUGS1Main
      block #gDelimiterGS1Main
      block #gValueGS1Main
      block #gt2GS1Main
      slot #gtDeltaGS1Main
      block #gt4GS1Main
    block #AdvancedBarcodeSampleGS1Exception (hidden)
      block #gt1GS1Exception
      slot #gtDelta1GS1Exception
      block #gt3GS1Exception
      block #gt5GS1Exception
      block #gSKUGS1Exception
      block #gDelimiterGS1Exception
      block #gValueGS1Exception
      block #gt2GS1Exception
      slot #gtDeltaGS1Exception
      block #gt4GS1Exception
tab pane#tab-add-new
  heading "Create new POS"
  button "Add new POS"#btnConnectToPos primary
  block #addNewNote
    heading 
  form#frmAuthorise
    label "Your POS name"
    slot #DearPos_Index_PosName
tab pane#tab-portal-help
  heading "Help"
  button "Read information sheet" primary
modal#DearPos_Index_Catalog small
  heading "POS product management"
  button "×"
  slot #DearPos_Catalog_ValidationContainer (hidden)
  label "SKU"
  slot #DearPos_Catalog_ProductCode
  label "Product name"
  slot #DearPos_Catalog_ProductName
  label "Status"
  slot #DearPos_Catalog_Status
  label "Earning loyalty"
  block #popoverProductLoyaltyPoints
    slot #DearPos_Catalog_Loyalty
  block #DearPos_Catalog_AllActions
    button "Save"#DearPos_Catalog_Update primary
    button "List on POS"#DearPos_Catalog_List primary
    button "Remove from POS"#DearPos_Catalog_Remove
    button "Close"
modal#DearPos_AddUser_Content small
  heading "Add a user to POS"
  button "×"
  slot #DearPos_AddUser_ValidationContainer (hidden)
  block #DearPos_AddUser_Fields
    slot #divAddUserName
    slot #divAddName
    slot #tdAddUserRole
    slot #tdAddUserOutlet
    slot #addUserPermissionsContainer
  block #DearPos_AddUser_Actions
    button "Add" primary
    button "Cancel"
modal#DearPos_EditPermissions_Content small
  heading "Edit permissions"
  button "×"
  slot #DearPos_EditPermissions_ValidationContainer (hidden)
  block #DearPos_EditPermissions_Fields
    slot #editPermissionsContainer
  block #DearPos_EditPermissions_Actions
    button "Save" primary
    button "Cancel"
modal#DearPos_AddSurcharge_Content small
  heading "Add a surcharge to POS"
  button "×"
  block #DearPos_AddSurcharge_Fields
    slot #DearPos_AddSurcharge_ValidationContainer (hidden)
    slot #divAddSurchargeName
    slot #tdAddSurchargeType
    slot #tdAddSurchargeValue
    label "Refund surcharge"
    input checkbox#divAddRefundSurcharge
    label "Active"
    input checkbox#divAddSurchargeIsActive
  block #DearPos_AddSurcharge_Actions
    button "Add" primary
    button "Close"
modal#DearPos_ExportPayments_Content small
  heading "Export payments to POS"
  button "×"
  slot #DearPos_ExportPayments_ValidationContainer (hidden)
  text "Payments for sales that exist in Cin7 Core but not in POS will be exported to POS. This operation may take a long time. "
  block #DearPos_ExportPayments_Actions
    button "Start" primary
    button "Close"
modal#DearPos_DownloadOrders_Content small
  heading "Load sales from POS"
  button "×"
  slot #DearPos_DownloadOrders_ValidationContainer (hidden)
  text "All orders from POS will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please leave t"
  label "Sales created since"
  slot #DearPos_FromOrders
  block #DearPos_DownloadOrders_Actions
    button "Load from POS" primary
    button "Close"
modal#DearPos_UserImages_Content medium
  heading "User image management"
  button "×"
  slot #divAttachmentList
  block #divUploadContainer
    slot #ifrmUpload (hidden)
    form#frmUpload
      heading "Drop files here or click to upload."
  button "Close"
form#frmProcess
block #editQuickKeyTemplate (hidden)
  block #quickKeyBock-{0}
    button #removeFolder-{0}
    block #quickKeyNewWarning-{0} (hidden)
      text "Please save this Quick Key to allow an image upload."
    slot #iQuickUpload-{0} (hidden)
    form#quickKeyImageUploadForm-{0}
      slot #tdUploadQuickKeyImageControl-{0} (hidden)
      label "Image"
      button "Upload image"
      button "Delete"#btnDeleteQuickKeyImage-{0}
    slot #validationContainerQuickKeys-{0} (hidden)
    form#quickKeyForm-{0}
      label "Quick Key name"
      slot #tdquickKeyFolderName-{0}
      label "Grouping operator"
      slot #cmbGroupingOperator-{0}
      label "Brands"
      slot #cmbBrands-{0}
      button "Brand"#newBrand-{0} primary (hidden)
      slot #brandsPlaceholder-{0} (hidden)
      heading "Brands:"
      label "Categories"
      slot #cmbCategories-{0}
      button "Category"#newCategory-{0} primary (hidden)
      slot #categoriesPlaceholder-{0} (hidden)
      heading "Categories:"
      label "Tags"
      slot #cmbTags-{0}
      button "Tag"#newTag-{0} primary (hidden)
      slot #tagsPlaceholder-{0} (hidden)
      heading "Tags:"
form#frmExport
form#frmOutletLevelSKUExport
modal#DearPos_QuickKey_Reorder medium
  heading "Reorder quick keys"
  button "×"
  slot #DearPos_QuickKey_Reorder_ValidationContainer
  input text#inpSearchQuickKey placeholder "Type text to search for Quick Key"
  heading "Ordered Quick Keys"
  slot #QuickKeyOrderedList
  heading "Temporary container"
  slot #QuickKeyTemporaryContainer
  block #DearPos_QuickKey_Actions
    button "Save" primary
    button "Cancel"
modal#DearPos_PaymentsMapping_Content medium
  heading 
  button "×"
  block #DearPos_PaymentsMapping_Fields
    button #divAddCustomPaymentMapping primary
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentsMapping
  block #DearPos_PaymentsMapping_Actions
    button "Close"
modal#DearPos_OutletLevelSKU_Content medium
  heading "Outlet level product SKUs"
  button "×"
  block #DearPos_OutletLevelSKU_Fields
    button #divAddOutletLevelSKU primary
    button "Export"#divExportOutletLevelSKU
    button "Import"#divImportOutletLevelSKU
    input text#divSearchOutletSKU placeholder "Type text to search"
    button "Search" primary
    slot #divOutletLevelSKU
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Pos2019`

18 grids · 104 standalone fields · 4 windows · 6 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divOutletLevelSKU` · store `vPosProductStore` · placeholder `No outlet products SKU was found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Outlet SKU | `OutletSKU` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping \| divPaymentsMapping` · store `vPaymentMethodStore \| @vPaymentMethodStoreSub` · placeholder `Loading POS payment methods mappings... \| No payment methods mapping…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentMethodName` |  | flex 1 |  |  |
    | Payment account code | `Value` |  | 250 | renderer() |  |
    | Surcharges | `SurchargeIDs` |  | flex 1 | renderer() |  |

- **grid** · renders into `cashManagementReasonGridContainer` · store `cashManagementReasonStore` · placeholder `Reasons are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reason | `ReasonName` |  | flex 1 | renderer() |  |

- **grid** · renders into `cashPaymentSetupGridContainer` · store `cashPaymentSetupStore` · placeholder `Banknote denominations are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Denomination | `Nominal` | number column | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `exportPaymentsGridContainer` · store `exportPaymentsStore` · placeholder `No payments to export.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | POS sale # | `OrderNumber` |  | 160 | RenderHTMLText |  |
    | Invoice # | `InvoiceNumber` |  | 160 | renderer() |  |
    | Error | `Error` |  | flex 1 | renderer() |  |

- **grid** · renders into `userManagementGridContainer` · store `userManagementStore` · placeholder `Users are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Email address | `UserName` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Role | `RoleName` |  | flex 1 | renderer() |  |
    | Outlet | `PosOutletIDs` |  | flex 1 | renderer() · edit: cell editor |  |
    | Permissions | `` |  | 110 | renderer() |  |
    | User images | `ImagesCount` |  | 100 | renderer() |  |

- **grid** · renders into `surchargeGridContainer` · store `surchargeStore` · placeholder `Surcharges are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Value | `Value` |  | flex 1 | renderer() |  |
    | Refund surcharge | `RefundSurcharge` | check column | 100 | renderer() |  |
    | Active | `IsActive` | check column | 100 | renderer() |  |

- **grid** · renders into `cclpGridContainer` · store `cclpStore` · placeholder `Customers are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Loyalty points | `LoyaltyPoints` |  | 160 | renderer() |  |
    | Customer's credits | `StoreCredits` |  | 160 | renderer() |  |
    | Email POS receipts automatically | `SendReceiptViaEmail` |  | 160 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending POS sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured POS orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 2 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | POS invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBulkList` · store `bulkStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 |  |  |
    | Price | `Price` |  | 100 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | flex 1 | renderer() |  |
    | Number | `SaleOrderNumber` |  | 130 | renderer() |  |
    | Date | `SaleOrderDate` |  | 130 | renderer() |  |
    | Customer | `CustomerName` |  | flex 3 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 3 | renderer() |  |
    | Sales | `OrderCount` |  | 100 |  |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |
    |  | `` | action column | 25 |  |  |

- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 1 | renderer() |  |
    | Default | `isDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `divHolidaysGrid` · placeholder `You do not have any holidays yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Description | `Comment` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSpecialsGrid` · placeholder `You do not have any custom working days yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 100 | edit: date field |  |
    | Start | `StartTime` |  | 130 | renderer() |  |
    | End | `EndTime` |  | 130 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |

- **grid** · renders into `divDaysGrid` · placeholder `You do not have any working days yet.` · layout column
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Day | `DayOfWeek` |  | flex 1 | renderer() | pick-only |
    | Start | `StartTime` |  | flex 1 | renderer() |  |
    | End | `EndTime` |  | flex 1 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |
    |  | `` |  | 57 | renderer() |  |


#### Windows and dialogs

- **window** “Update quantities in POS” · modal · layout fit
- **window** “Load stock operations from POS” · modal · layout fit
- **window** “Load customers from POS” · modal · layout fit
- **window** “Load suppliers from POS” · modal · layout fit

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdAdvancedBarcodeMode` | `AdvancedBarcodeModeStore` | shows `name` · value `value` |
| number field |  | `divAdvancedBarcodeSKULength` | `` |  |
| number field |  | `divAdvancedBarcodeValueLength` | `` | read-only |
| number field |  | `divAdvancedBarcodeValueDecimalPoint` | `` |  |
| text field |  | `tdOutTyroMerchantID` | `` | placeholder `Tyro merchant ID` |
| text field |  | `tdOutTriPOSAccountID` | `` | placeholder `triPOS account ID` |
| text field |  | `tdOutTriPOSAcceptorID` | `` | placeholder `triPOS acceptor ID` |
| text field |  | `tdOutTriPOSAccountToken` | `` | placeholder `triPOS account token` |
| text field |  | `DearPos_Index_PosName` | `` | placeholder `New POS name` |
| combo |  | `DearPos_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `DearPos_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `DearPos_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` |
| combo |  | `DearPos_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| text field |  | `divECSspecificParameter1` | `` |  |
| number field |  | `divPinLength` | `` |  |
| number field |  | `divDeliveryNumberPerDay` | `` |  |
| number field |  | `divDeliveryTimeInterval` | `` |  |
| number field |  | `divAutoLockAfter` | `` |  |
| text field |  | `divTyroMerchantID` | `` |  |
| text field |  | `divTriPOSAccountID` | `` |  |
| text field |  | `divTriPOSAcceptorID` | `` |  |
| text field |  | `divTriPOSAccountToken` | `` |  |
| combo |  | `tdECSspecificParameter3` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdClosureRegisterReportTemplate` | `vClosureRegisterReportTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdDeliveryTemplate` | `vDeliveryTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdSaleQuoteTemplate` | `vSaleQuoteTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdECSspecificParameter6` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdRounding` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdRoundTo` | `RoundingDenominationStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `tdRoundingRule` | `RoundingRulesStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `tdECSspecificParameter7` | `TillDiscrepancyStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdLoyaltyExpenseAccount` | `ExpenseAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdDefaultSalesTax` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `tdSurchargeTaxRule` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `tdZeroTax` | `ZeroTaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_LoadCustomersMode` | `LoadCustomersModeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_PaymentDisplayOrder` | `PaymentDisplayOrderStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_PettyCash` | `PettyCashStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_CashInOut` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `DearPos_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| text field |  | `DearPos_Editor_ReplyEmail` | `` | placeholder `write...` |
| combo |  | `DearPos_Editor_CmbCustomSalesRepresentative` | `customSalesRepresentativeComboStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| text field |  | `tdWindcaveUsername` | `` | placeholder `Windcave username` |
| text field |  | `tdWindcaveKey` | `` | placeholder `Windcave key` |
| number field |  | `DearPos_Catalog_Loyalty` | `` |  |
| text field |  | `divAddUserName` | `` | placeholder `Email address / Login` |
| text field |  | `divAddName` | `` | placeholder `Name` |
| combo |  | `tdAddUserRole` | `RoleStore` | shows `RoleName` · value `RoleId` · placeholder `Role` · pick-only |
| combo |  | `tdAddUserOutlet` | `outletSelectorStore` | shows `OutletName` · value `PosOutletID` · placeholder `Outlet` · pick-only · multi-select |
| text field |  | `divAddSurchargeName` | `` | placeholder `Name` |
| combo |  | `tdAddSurchargeType` | `SurchargeTypeStore` | shows `name` · value `value` · placeholder `Type` · pick-only |
| number field |  | `tdAddSurchargeValue` | `` | placeholder `Value` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| text field |  | `tdOutletNameEdit` | `` |  |
| text field |  | `tdPaymentSenseURLEdit` | `` | placeholder `Paymentsense outlet URL` |
| text field |  | `tdPaymentSenseAPIKeyEdit` | `` | placeholder `Paymentsense outlet API key` |
| combo |  | `tdOutletMappingValue` | `LocationStore` | shows `Description` · value `LocationID` · pick-only |
| combo |  | `tdOutletTimeZoneEdit` | `vTimezoneStore` | shows `displayName` · value `name` · placeholder `Choose the store's timezone...` · pick-only |
| combo |  | `tdOutletTaxRuleEdit` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Default sales tax` |
| combo |  | `tdOutletSurchargeTaxRule` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Surcharge tax rule` |
| combo |  | `tdOutletLedgerAccountEdit` | `AccountStore` | shows `DisplayName` · value `Code` · read-only |
| combo |  | `tdOutletReceiptEdit` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Receipt template` · pick-only |
| combo |  | `tdOutletSquareIntegration` | `SquareIntegrationStore` | shows `ShopName` · value `ID` · placeholder `Square integration to process returns` |
| text field |  | `tdRegistryCode` | `` |  |
| combo |  | `tdRegistryLedgerAccount` | `AccountStore` | shows `DisplayName` · value `Code` · placeholder `Cash account` |
| combo |  | `tdRegistryReceipt` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Receipt template` |
| combo |  | `tdRegistryTillDiscrepancy` | `TillDiscrepancyStore` | shows `DisplayName` · value `Code` · placeholder `Till discrepancy` |
| combo |  | `tdRegistryCashFloat` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Cash float` |
| combo |  | `tdRegistryPettyCash` | `PettyCashStore` | shows `DisplayName` · value `Code` · placeholder `Petty cash` |
| combo |  | `tdRegistryCashInOut` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Cash in/out` |
| text field |  | `tdRegistryPrefix` | `` | placeholder `Receipt prefix` |
| text field |  | `tdRegistrySuffix` | `` | placeholder `Receipt suffix` |
| text field |  | `tdTyroTerminalID` | `` | placeholder `Tyro terminal ID` |
| text field |  | `tdTriPOSLaneID` | `` | placeholder `triPOS lane ID` |
| text field |  | `tdLinklyUserName` | `` | placeholder `Linkly Cloud username` |
| text field |  | `tdLinklyPassword` | `` | placeholder `Linkly Cloud password` |
| text field |  | `tdWindcaveStation` | `` | placeholder `Windcave station` |
| date field |  | `DearPos_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdRegistryQuickKey` | `window.vPosQuickKeyStore` | shows `Name` · value `QuickKeyID` · placeholder `Quick Key` |
| text field |  | `tdquickKeyName` | `` |  |
| combo |  | `tdCatalogTilesSize` | `CatalogTilesSizeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `tdRegistryCatalogTilesSize` | `CatalogTilesSizeStore` | shows `name` · value `value` · placeholder `Catalog size` |
| combo |  | `tdCatalogTilesVisibility` | `CatalogTilesVisibilityStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `tdRegistryCatalogTilesVisibility` | `CatalogTilesVisibilityStore` | shows `name` · value `value` · placeholder `Tile visibility` |
| combo |  | `"cmbGroupingOperator-".concat(…)` | `GroupingOperatorStore` | shows `name` · value `value` · pick-only |
| combo |  | `"cmbBrands-".concat(…)` | `brandStore` | shows `Brand` · value `Brand` · placeholder `type to search brands` |
| combo |  | `"cmbCategories-".concat(…)` | `CategoryStore2` | shows `Category` · value `Category` · placeholder `Type to search categories` |
| combo |  | `"cmbTags-".concat(…)` | `TagsStore` | shows `Value` · value `Value` · placeholder `type to search tags` |
| file field |  | `"tdUploadQuickKeyImageControl-".concat(…)` | `"attachedQuickKeyImageFile-".concat(…)` |  |
| text field |  | `"tdquickKeyFolderName-".concat(…)` | `` | placeholder `Name here` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| combo |  | `weekStartCmb` | `WeekDaysStore` | shows `name` · value `value` |
| multi-select combo |  | `weekEndsCmb` | `WeekDaysStore` | shows `name` · value `value` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **button** “Download customers” · on click `DearPos_Index_DownloadCustomersShow`
- **button** “Download suppliers” · on click `DearPos_Index_DownloadSuppliersShow`
- **button** “Update quantity” · on click `DearPos_Index_UpdateQuantityShow`
- **button** “Reset layout” · on click `handler()`
- **component** · renders into `divECSspecificParameter5`
- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

