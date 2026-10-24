# Inventory: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/GiftCards` | Gift cards | [`GiftCards2019`](#giftcards2019) |
| `/PriceList` | Price list | [`PriceList2019`](#pricelist2019) |
| `/Product` | Products | [`MultilingualSupport2019`](#multilingualsupport2019), [`Customization2019`](#customization2019), [`FixedAssetType2019`](#fixedassettype2019), [`Product2019`](#product2019) |
| `/ProductFamily` | Product family | [`ProductFamily2019`](#productfamily2019) |
| `/ProductFamilyList` | Product families | [`ProductFamilyList2019`](#productfamilylist2019) |
| `/Recall` | Batch/lot recall | [`RecallReport2019`](#recallreport2019) |
| `/Stock` | Product availability | [`Stock2019`](#stock2019) |
| `/StockAdjustment` | Stock adjustment | [`StockAdjustment2019`](#stockadjustment2019) |
| `/StockAdjustmentList` | Stock adjustments and stocktakes | [`StockAdjustmentList2019`](#stockadjustmentlist2019) |
| `/StockTake` | Stocktake/adjustments | [`Stocktake2019`](#stocktake2019) |
| `/StockTransfer` | Stock transfer | [`StockTransfer2019`](#stocktransfer2019) |
| `/StockTransferList` | Stock transfers | [`StocktransferList2019`](#stocktransferlist2019) |
| `/Stocktake/New` | Stocktake/adjustments | [`Stocktake2019`](#stocktake2019) |
| `/Stocktransfer` | Stock transfer | [`StockTransfer2019`](#stocktransfer2019) |
| `/StocktransferList` | Stock transfers | [`StocktransferList2019`](#stocktransferlist2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/GiftCards`: Gift cards

Frame: `task-upload-frame`.

```text
link "Home"
block #divImportCnt
  button "Import"#divImport
button "Export"#divExport ▾
link "Selected cards"
link "All expired"
link "All active"
block #divForfeightCnt
  button "Forfeit"#breakerageAction ▾
  link "Selected cards"
  link "All expired"
input text#divSearch placeholder "Type text to search"
button "Search" primary
input checkbox#divShowUsedCards
label "Show used cards" for #divShowUsedCards
button #divRefresh
button #Grid_gridName_Options
slot #GiftCards_Index_Container
form#frmExport
modal#GiftCards_Allocated_Details medium
  heading #allocationHeader
  button "×"
  slot #divAllocatedDetailsGridContainer
  button "Close"
```

### `/PriceList`: Price list

Frame: `task-upload-frame`.

```text
link "Home"
heading "Price list"
button "Print" primary
form#frm
  select#fCategory
  label "Category"
  select#fBrand
  label "Brand"
  select#fFormat
  label "Format"
  select#fTag
  label "Tag"
  select#fTemplate
  label "Template"
```

### `/Product`: Products

Frame: `iUpload`.

```text
block #bc-product
  link "Home"
  link "Products"
  text "Product details"#bc-product-name
  button "Print"#divPrint ▾
  slot #productDetailprintDropdownList
  button "Save"#saveAction1 primary
  button "Clone"#cloneAction
  button "Back to list"#backAction
block #bc-product-list
  link "Home"
text "DEMO PRODUCTION BOM PRODUCTS FOR REFERENCE Don't show me this again"
link "All products"#vProducts
link "Combined view"#vCombined
block #divTabArea (hidden)
  button "General"
  button "Prices"
  button "Stock"
  button "Dimensions"
  button "Alternative products"
  button "Additional attributes"
  button "Suppliers"
  button "Custom prices"
  button "Reorder levels"
  button "Movements"
  button "Service usage"
  button "Bill of materials"
  button "Production BOM"
  button "Make-to-order BOM"
  button "Discounts"
  button "Images and attachments"
  button "Additional units of measure"
  button "Additional descriptions"
  button "Channels"
  button "Activity log"
  button "Accounting dimensions"
block #divProductList (hidden)
  heading "Products"
  block #divImport
    button "Import" ▾
    block #importDropdownList
      link "Inventory list"
      link "Stock on hand"
      link "Fixed assets"
      link "Discount matrix"
      link "Assembly BOM"
      link "Production BOM"
      link "Units of measure"
      link "Stock reorder locations"
      link "Product prices by supplier"
      link "Reorder parameters"
      link "Images and attachments"
      link "Markup prices"
      link "Simple prices"
      link "Custom prices"
      link "Bulk SKU change"
      link "Bulk costing method change"
  block #divExport
    button "Export" ▾
    block #exportDropdownList
      link "Inventory list"
      link "Inventory list (without descriptions)"
      link "Stock on hand"
      link "Fixed assets"
      link "Discount matrix"
      link "Assembly BOM"
      link "Production BOM"
      link "Units of measure"
      link "Stock reorder locations"
      link "Product prices by supplier"
      link "Reorder parameters"
      link "Images and attachments"
      link "Markup prices"
      link "Simple prices"
      link "Custom prices"
      link "Bulk SKU change"
      link "Bulk costing method change"
  button "Print"#divPrint ▾
  slot #printDropdownList
  button "More actions"#divMore ▾
  link "Delete deprecated products"
  link "Merge selected products"
  link "Replace BOM component"
  block #divMissingExpenseAccountInBOMMessage (hidden)
    text "For the products below please fix the following configuration issues: - BOM definition. Service items do not have an exp"
  block #divProblematicProductCodesMessage (hidden)
    text "The following products have numeric product codes (SKUs) starting with '0'. You will experience issues when exporting/im"
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  input checkbox#divOnlyActive
  label "Only active" for #divOnlyActive
  button #divRefresh
  button #Grid_gridName_Options
  block #divSelectedItemCount
    slot #lSelectedCounter
  block #CombinedProduct_Index_Container_Wrapper
    slot #CombinedProduct_Index_Container
  block #Product_Index_Container_Wrapper
    slot #Product_Index_Container
block #divProductDetails (hidden)
  block #divProductDetailsHeader
    block #Product_Status
    heading 
    button 
  block #divTaskHeader
    slot #Product_Index_ValidationContainer
    block #btnProductPreview
    input text#Product_Index_ProductCode
    label "SKU" for #Product_Index_ProductCode
    input text#Product_Index_ProductName
    label "Product name" for #Product_Index_ProductName
    slot #Product_Index_Type
    label "Type" for #Product_Index_Type
    block #liFixedAssetType
      slot #Product_Index_FixedAssetType
      label "Fixed asset type" for #Product_Index_FixedAssetType
    slot #Product_Index_Category
    label "Category" for #Product_Index_Category
    slot #Product_Index_Brand
    label "Brand" for #Product_Index_Brand
    block #liCostingMethod
      select#Product_Index_CostingMethod
      label "Costing method" for #Product_Index_CostingMethod
    block #liDefaultUnitOfMeasure
      slot #Product_Index_DefaultUnitOfMeasure
      label "Unit of measure" for #Product_Index_DefaultUnitOfMeasure
    slot #Product_Index_Status
    label "Status" for #Product_Index_Status
    block #liDefaultLocation
      slot #Product_Index_DefaultLocation
      label "Default location" for #Product_Index_DefaultLocation
    block #liProductAttributeSet
      slot #Product_Index_ProductAttributeSet
      label "Additional attributes set" for #Product_Index_ProductAttributeSet
    block #liBarcode
      input text#Product_Index_Barcode
      label "Barcode" for #Product_Index_Barcode
    block #liMinimumBeforeReorder
      input text#Product_Index_MinimumBeforeReorder
      label "Minimum before reorder" for #Product_Index_MinimumBeforeReorder
    block #liReorderQuantity
      input text#Product_Index_ReorderQuantity
      label "Reorder quantity" for #Product_Index_ReorderQuantity
    block #liDropShipMode
      slot #Product_Index_DropShipMode
      label "Drop ship" for #Product_Index_DropShipMode
    block #liBillOfMaterial
      slot #Product_Index_BillOfMaterial
      label "Bill of materials" for #Product_Index_BillOfMaterial
    input text#Product_Index_Tags
    label "Tags" for #Product_Index_Tags
    block #liPickZones
      input text#Product_Index_PickZones
      label "Pick zones" for #Product_Index_PickZones
    slot #Product_Index_NotSellable
    label "I am selling this product" for #Product_Index_NotSellable
    block #liInventoryAccount
      slot #Product_Index_InventoryAccount
      label "Inventory account" for #Product_Index_InventoryAccount
    block #liRevenueAccount
      slot #Product_Index_RevenueAccount
      label "Revenue account" for #Product_Index_RevenueAccount
    block #liExpenseAccount
      slot #Product_Index_ExpenseAccount
      label "Expense account" for #Product_Index_ExpenseAccount
    block #liCOGSAccount
      slot #Product_Index_COGSAccount
      label "COGS account" for #Product_Index_COGSAccount
    block #liPurchaseTaxRule
      slot #Product_Index_PurchaseTaxRule
      label "Purchase tax rule" for #Product_Index_PurchaseTaxRule
    block #liSaleTaxRule
      slot #Product_Index_SaleTaxRule
      label "Sale tax rule" for #Product_Index_SaleTaxRule
    block #liDiscount
      slot #Product_Index_Discount
      label "Product discount" for #Product_Index_Discount
    block #liStockLocator
      input text#Product_Index_StockLocator
      label "Stock locator" for #Product_Index_StockLocator
    block #liAlwaysShowQuantity
      input text#Product_Index_AlwaysShowQuantity
      label "Always show quantity" for #Product_Index_AlwaysShowQuantity
    block #liWarrantySetup (hidden)
      slot #Product_Index_WarrantySetup
      label "Warranty" for #Product_Index_WarrantySetup
    block #liHSCode
      input text#Product_Index_HSCode
      label "HS code" for #Product_Index_HSCode
    block #liCountryOfOrigin
      slot #Product_Index_CountryOfOrigin
      label "Country of origin" for #Product_Index_CountryOfOrigin
    textarea#divShortDescription
    label "Short description" for #divShortDescription
    button "Generate with AI" primary
    block #liDescription
      textarea#divDescription
      label "Description" for #divDescription
      button "Generate with AI" primary
    block #liDescriptionHTML (hidden)
      slot #productDescriptionEditor
    block #liIntNote
      textarea#divIntNote
      label "Internal note" for #divIntNote
    block #liIntNoteHTML (hidden)
      slot #productIntNoteEditor
  block #divPrice (hidden)
    heading "Prices"
    block #liAverageTextCost
      label "Current average cost"
      slot #Product_Index_AverageCostHtml
    block #liAverageCost
      input text#Product_Index_AverageCost
      label "Average cost" for #Product_Index_AverageCost
    slot #Markup_Container
    block #markupTextArea (hidden)
      text "All calculated prices are in [USD]. If you sell in different currencies the selling price will be recalculated using the"
  block #divStock (hidden)
    block #divList
      heading "Stock"
      text "If you would like to change the stock level of this product, please create a stock adjustment here: Stock adjustment"
      button #divStockRefresh
      button #StockGrid_gridName_Options
      input text#divStockSearch placeholder "Type text to search"
      button "Search" primary
      input checkbox#divNonZero
      label "Show only non-zero quantities" for #divNonZero
      select#batchFilter
      slot #Stock_Index_Container
    block #divAllocatedDetails
      heading "Allocated details"
      button "Back to list"#hideAllocated
      slot #AllocatedGrid_Container
    block #divOnOrderDetails
      heading "On order details"
      button "Back to list"#hideOnOrder
      slot #OnOrderGrid_Container
    block #divInTransitDetails
      heading "In transit details"
      button "Back to list"#hideInTransit
      slot #InTransitGrid_Container
  block #divDimensions (hidden)
    block #divDimensionsBlock
      heading "Dimensions"
      heading "Item size"
      slot #Product_Index_DimensionUnitsFake
      slot #Product_Index_DimensionUnits
      label "Unit of measure" for #Product_Index_DimensionUnits
      input text#Product_Index_Length
      label "Length" for #Product_Index_Length
      input text#Product_Index_Width
      label "Width" for #Product_Index_Width
      input text#Product_Index_Height
      label "Height" for #Product_Index_Width
      heading "Item Weight"
      input text#Product_Index_Weight
      label "Weight" for #Product_Index_Weight
      slot #Product_Index_WeightUnitsFake
      slot #Product_Index_WeightUnits
    block #divImportDimensionsBlock
      heading "Import dimensions"
      heading "Carton size"
      input text#Product_Index_CartonInnerQunaitty
      label "Inner carton quantity" for #Product_Index_CartonInnerQunaitty
      input text#Product_Index_CartonQuantity
      label "Outer carton quantity" for #Product_Index_CartonQuantity
      heading "Volume of outer carton"
      input text#Product_Index_CartonLength
      label "Length" for #Product_Index_CartonLength
      input text#Product_Index_CartonWidth
      label "Width" for #Product_Index_CartonWidth
      input text#Product_Index_CartonHeight
      label "Height" for #Product_Index_CartonHeight
      input text#Product_Index_CartonVolume
      label "" for #Product_Index_CartonVolume
  block #divProductAlternative (hidden)
    heading "Alternative products"
    button #divNew_AlternativeProduct primary
    slot #divAlternativProducts
    button "Add more items"#Product_Index_AddAlternativeProductLink primary
  block #Product_divAttributeSet (hidden)
    heading "Additional attributes"
    block #Product_liCustomField1
      slot #Product_CustomField1
      label "Attribute 1"
    block #Product_liCustomField2
      slot #Product_CustomField2
      label "Attribute 2"
    block #Product_liCustomField3
      slot #Product_CustomField3
      label "Attribute 3"
    block #Product_liCustomField4
      slot #Product_CustomField4
      label "Attribute 4"
    block #Product_liCustomField5
      slot #Product_CustomField5
      label "Attribute 5"
    block #Product_liCustomField6
      slot #Product_CustomField6
      label "Attribute 6"
    block #Product_liCustomField7
      slot #Product_CustomField7
      label "Attribute 7"
    block #Product_liCustomField8
      slot #Product_CustomField8
      label "Attribute 8"
    block #Product_liCustomField9
      slot #Product_CustomField9
      label "Attribute 9"
    block #Product_liCustomField10
      slot #Product_CustomField10
      label "Attribute 10"
  block #divAccountingDimensions (hidden)
    heading "Accounting dimensions"
    slot #divAccountingDimensionsList
  block #divSuppliers (hidden)
    heading "Suppliers"
    button #divNew_Supplier primary
    slot #divSupplierLines
    button "Add more items"#Product_Index_AddSupplierLink primary
    slot #divLeadSafetyLines
  block #divCustomPrices (hidden)
    heading "Custom prices"
    button #divCustomPricesNew primary
    input text#divCustomPricesSearch placeholder "Type text to search"
    button "Search" primary
    button #divCustomPricesRefresh
    button "Auto-fill"#divCustomPricesAutoFill
    button "Clear all"#divCustomPricesClearAll
    slot #CustomPrices_Container
    slot #customPriceLimit (hidden)
  block #divLocations (hidden)
    heading "Reorder levels"
    button #divNew_Location primary
    slot #divLocationLines
    button "Add more items"#Product_Index_AddLocationLink primary (hidden)
  block #divMovements (hidden)
    heading "Movements"
    slot #divMovementType
    input text#divMovementsSearch placeholder "Type text to search"
    button "Search" primary
    slot #divMovementChanel
    slot #divMovementAction
    slot #divMovementLines
    slot #divMovementQuantityLines
    slot #divMovementQuantityChangesLines
  block #divUsage (hidden)
    heading "Service usage"
    input text#divUsageSearch
    slot #divUsageLines
  block #divBillOfMaterial (hidden)
    heading "Bill of materials"
    block #BomDisabledReason
      text "This product is an additional unit of measure of" (hidden)
    slot #liAutoAssembly
    label "Auto-assembly/kit" for #chkAutoAssembly
    slot #liAutoDisassembly
    label "Auto-disassembly" for #chkAutoDisassembly
    slot #liQuantityToProduce
    label "Quantity to produce" for #txtQuantityToProduce
    slot #Product_Index_AssemblyInstructionURL
    label "Assembly instruction URL" for #Product_Index_AssemblyInstructionURL
    button #divNewBOM_Component primary
    button "Export"#btnExportBOM
    form
    slot #liCostType
    label "Cost is estimated using" for #cmbCostType
    slot #divBOMComponents
    button "Add more items"#Product_Index_AddBOMRecordLink primary (hidden)
    text "Wastage % and wastage quantity are mutually exclusive."
    button #divNewBOM_Service primary
    slot #divBOMServices
    button "Add more items"#Product_Index_AddBOMServicesRecordLink primary (hidden)
    slot #Product_Index_BOMTotal
  block #divProductionBom (hidden)
    button "Production BOM"
    button "Settings"
    button "Versions"
    block #divPBom (hidden)
      heading "Production BOM"
      slot #cmbPBomVersion
      label "Version" for #cmbPBomVersion
      slot #liOutputQuantity
      label "Quantity to produce *" for #liOutputQuantity
      block #ProductTracingBlock
        slot #divProductTracing
        label "Product tracing" for #chkProductTracing
      block #IssueMethodBlock (hidden)
        slot #cmb_ProductionIssueMethod
        label "Component issue method *" for #cmbProductionIssueMethod
      block #BackflushDefinedForBlock (hidden)
        slot #cmb_BackflushDefinedFor
        label "Apply backflush method to: *" for #cmbBackflushDefinedFor
      text "The operation below must have a specified duration (cycle time), the number of units that can be produced during the cyc"
      button "Operation"#divBom_AddOperation primary
      block #copyBomBlock
        slot #cmbCopyBom
        button "Clone BOM"#btnCopyBom primary
        button "Add BOM version"#btnAddBomVersion primary
      block #divProductionBomData
        block #noOperationsBlock
      button "Add more operations"#divBom_AddOperation2 primary
      block #finishedProductBlock
        heading "Finished products output"
        slot #cmbFinishedProductCost
        label "Cost allocation type *" for #cmbFinishedProductCost
        slot #divFinishedProductsData
      block #wastageProductsCostBlock
        heading "Cost of wastage"
        slot #divWastageProductsData
      slot #Product_Index_ProductionBOMTotal
    block #divPSettings (hidden)
      heading "Settings"
      slot #Product_Index_ProductionInstructionURL
      label "Production instruction URL" for #Product_Index_ProductionInstructionURL
      slot #liManufacturingBufferTime
      label "Buffer, %" for #liManufacturingBufferTime
      slot #liIgnoreCumulativeLeadTime
      label "Ignore cumulative lead time" for #chkIgnoreCumulativeLeadTime
      block #ComponentProductionLeadTimeContainer
        slot #liComponentProductionLeadTime
        label "Production lead time" for #liComponentProductionLeadTime
      block #ManufacturingDeliveryToBlock
        slot #liManufacturingDeliveryTo
        label "Delivery to" for #liManufacturingDeliveryTo
      slot #liManufacturingMinQuantity
      label "Min quantity to produce per production order" for #liManufacturingMinQuantity
      slot #liManufacturingMaxQuantity
      label "Max quantity to produce per production order" for #liManufacturingMaxQuantity
      slot #liManufacturingDeviationPercent
      label "Order quantity deviation %" for #liManufacturingDeviationPercent
      slot #liManufacturingRunSize
      label "Run size" for #liManufacturingRunSize
    block #divPVersions (hidden)
      heading "Versions"
      slot #divPBom_Versions
  form#productionBomFileUploader
    input file name=file
  block #divMakeToOrderBom (hidden)
    button "Make-to-order BOM"
    button "Make-to-order custom options view"
    button "Make-to-order configuration"
    block #divMTOBom (hidden)
      heading "Make-to-order BOM"
      slot #liMakeToOrderOutputQuantity
      label "Quantity to produce *" for #txtMakeToOrderOutputQuantity
      slot #Product_Index_MakeToOrderInstructionURL
      label "Production instruction URL" for #txtMakeToOrderInstructionURL
      slot #liMakeToOrderManufacturingBufferTime
      label "Buffer, %" for #txtMakeToOrderManufacturingBufferTime
      slot #liMakeToOrderIgnoreCumulativeLeadTime
      label "Ignore cumulative lead time" for #chkMakeToOrderIgnoreCumulativeLeadTime
      block #MakeToOrderComponentProductionLeadTimeContainer
        slot #liMakeToOrderComponentProductionLeadTime
        label "Production lead time" for #txtMakeToOrderComponentProductionLeadTime
      block #MakeToOrderManufacturingDeliveryToBlock
        slot #liMakeToOrderManufacturingDeliveryTo
        label "Delivery to" for #liMakeToOrderManufacturingDeliveryTo
      text "The operation below must have a specified duration (cycle time), the number of units that can be produced during the cyc"
      button "Operation"#divMakeToOrderBom_AddOperation primary
      slot #cmb_MakeToOrderIssueMethod
      label "Issue method" for #cmbMakeToOrderIssueMethod
      block #copyMakeToOrderBomBlock
        slot #cmbMakeToOrderCopyBom
        button "Clone BOM"#btnCopyMakeToOrderBom primary
      block #divMakeToOrderBomData
        block #noOperationsBlock
      button "Add more operations"#divMakeToOrderBom_AddOperation2 primary
      block #makeToOrderFinishedProductBlock
        heading "Finished products output"
        slot #cmbMakeToOrderFinishedProductCost
        label "Cost allocation type *" for #cmbMakeToOrderFinishedProductCostId
        slot #divMakeToOrderFinishedProductsData
      block #makeToOrderWastageProductsCostBlock
        heading "Cost of wastage"
        slot #divMakeToOrderWastageProductsData
      slot #Product_Index_MakeToOrderBOMTotal
    block #divMTOProductView (hidden)
      heading "Make-to-order product view"
      button "Add menu item"#MTOProductView_AddMenuItem primary
      button "Preview"#MTOProductView_Preview primary
      block #menu-item-template
        button 
        button 
      block #menu-subitem-template
        button 
        button 
      block #menu-subsubitem-template
        button 
      block #submenu-footer-template
        button "Add submenu item" primary
      block #sketch-image-template
        form
          label "" + file
      block #optional-required-control-template
        label "Optional" + radio
        label "Required" + radio
      block #type-dropdown-template
        button "Select type" ▾
        menu: 
      block #type-dropdown-option-template
        link "Item type option"
      block #default-control-template
        input checkbox#default-control-template-input name=isDefault
        label "Default" for #default-control-template-input
      block #description-button-template
        button "Description" primary
      block #general-form-control-template
        slot #divGeneralFormControl
        label "Label" for #ctrlGeneralFormControl
      block #conditions-button-template
        button  primary
      block #detailed-image-template
        form
          label "" + file
      block #readonly-badge-template
      block #general-form-text-template
        input text
        label ""
      block #general-form-cmb-template
        select
        label ""
      block #make-to-order-config
        button "Add menu item"#MTOProductView_AddMenuItem2 primary (hidden)
    modal#customizationDialog large
      heading "Customization for product:"
      button "×"
      block #customizationContainer
        button "➜"
        button "Set to default"
        button "➜"
        button "Set to default"
        input text#searchFiled placeholder "Type to search..."
        button "Search"
        button 
        input number#quantity
        button 
        button "Reset to default"
        slot #totalAmount
        button "Confirm order" (hidden)
        button 
        button "➜"
        button "Clear selected"
        label "Custom element text" for #artText
        input text#artText placeholder "Type custom element text"
        text "For example your initials. Maximum 64 characters including punctuation."
        label "Choose file" for #artFile + file #artFile
        text "Choose the image that you want to apply. Size should be lesser than 16MB."
        button "Confirm changes"
      block #zoomPopup (hidden)
      button "Save"#btnSaveCustomization primary
      button "Close"
    block #divMTOConfiguration (hidden)
      button "Configuration"#MTOConfiguration_AddConfiguration primary
      slot #MTOBOMConfigurations
      block #configuration-panel-template
        heading "Make-to-order configuration"
        button "Delete"#MTOConfiguration_DeleteConfiguration
        button 
        heading "1. Connect BOM template"
        slot #divMTOConfigTemplate
        label "Template" for #cmbMTOConfigTemplate
        slot #divMTOConfigMenuItem
        label "Menu item" for #cmbMTOConfigMenuItem
        heading "2. Assign production components"
        slot #divMTOProductMapGrid
        heading "3. Specify production quantity"
        text "Not enough data to generate quantity grid."
        heading "3. Specify production quantity"
        text "No update for quantity matrix required."
        heading "3. Specify production quantity"
        slot #divMTOQuantityMenuItem
        label "Which menu items define the component quantities?" for #cmbMTOQuantityMenuItem
        slot #divMTOQuantityMenuItemList
        button "Generate quantity variants" primary
        input file (hidden)
        button "Import"
        button "Export"
        text "Quantity table update is required!"
      button "Configuration"#MTOConfiguration_AddConfiguration2 primary
    block #divColumnFilterPopup (hidden)
      input text#txtSearchOptions placeholder "Type text to search"
      link "Select all"#linkSelectAllFilterOptions
      link "Clear"#linkClearFilterOptions
      slot #divFilterValues
      button "Ok"#btnSaleFilterOptions primary
      button "Cancel"#btnCloseFilterOptions
  modal#divMTODetailsModal medium
    heading "Item details"
    button "×"
    textarea#txtDetailsModalDescription placeholder "Write the description of your option here ..."
    label "Description"
    button "Save"#MTODetailsModal_Save primary
    button "Close"
  modal#divMTOConditionsConfig large
    heading "Set up conditions"
    button "×"
    text "Current option will be"#divMTOConditionsConfigSubtitle
    slot #divMakeToOrderConditionalVisibility
    slot #divMakeToOrderJoinCondition
    slot #divMakeToOrderConditionsGrid
    block #MTOConditionsModal_GridToolbar
      button "New condition" primary
    button "Save"#MTOConditionsModal_Save primary
    button "Close"
  form#makeToOrderBomFileUploader
    input file name=file
  block #divDiscount (hidden)
    heading "Discounts"
    block #divNew_Discount
    slot #divDiscountLines
    button "Add more items"#Product_Index_AddDiscountMatrixLink primary (hidden)
    text "Fields Customer and Customer tag are mutually exclusive."
  block #divAttachments (hidden)
    heading "Images and attachments"
    select#cmbProductAttachmentsView: List view | Thumb view
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#frmUpload
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    block #divAttachmentsListView
      slot #divAttachmentList
    slot #divAttachmentsThumbView (hidden)
    block #dlgPreviewZoomModal (hidden)
  block #divAdditionalUnitsOfMeasure (hidden)
    heading "Additional units of measure"
    block #divNew_AdditionalUnitOfMeasure
    link "Create a product"
    link "Select an existing product"
    slot #divAdditionalUnitOfMeasureLines
  block #divAdditionalDescriptions (hidden)
    heading "Additional descriptions"
    slot #divAdditionalDescriptionsNotes
    block #divAdditionalDescriptionsSelect (hidden)
      slot #AdditionalDescriptionsSelect
      label "Select an eCommerce shop"
    slot #ECSIntegrationLogo
    slot #ECSProductID
    block #divProductVariationID (hidden)
      slot #ECSProductVariationID
    slot #ECSProductSKU
    block #liAdditionalDescription
      textarea#divAdditionalDescription
      label "Description" for #divAdditionalDescription
    block #liAdditionalDescriptionHTML (hidden)
      slot #productAdditionalDescriptionEditor
    block #divCopyAdditionalDescription
    block #divDeleteMapping
  block #divChannels (hidden)
    heading "Channels"
    slot #divChannelsTable
  block #divActivityLogs (hidden)
    heading "Activity log"
    slot #ActivityLogs_Container
  modal#divNewProduct_AdditionalUnitOfMeasureModal small
    heading "Add a new product"
    button "×"
    slot #Product_NewProduct_AdditionalUnitOfMeasure_ValidationContainer
    slot #divNewProduct_AdditionalUnitOfMeasureUnitOfMeasure
    label "Unit of measure" for #divNewProduct_AdditionalUnitOfMeasureUnitOfMeasure
    input text#divNewProduct_AdditionalUnitOfMeasureSKU
    label "SKU" for #divNewProduct_AdditionalUnitOfMeasureSKU
    input text#divNewProduct_AdditionalUnitOfMeasureName
    label "Name" for #divNewProduct_AdditionalUnitOfMeasureName
    button "Save" primary
    button "Close"
  modal#Product_Channels_Profile_SelectDialog small
    heading "Please select a publishing profile"
    button "×"
    slot #Product_Channels_Profile_SelectDialog_ValidationContainer
    label "Publishing profile"
    slot #Product_Channels_PublishingProfiles
    block #Product_Channels_Profile_SelectDialog_AllActions
      button "OK"#Product_Channels_Profile_SelectDialog_PiblishProduct
      button "Close"
modal#dlgProductSuppliersDelevery large
  heading "Add delivery time bucket for products' delivery"
  button "×"
  block #divSupplyIntervalsContainer
  button "Delete"#btnProductSuppliersDeliveryDelete
  button "Save"#btnProductSuppliersDeliverySave primary
  button "Cancel"
block #divSupplyIntervalTemplate (hidden)
  label "Planning method"
  select: Transfer at intervals | Transfer on fixed days
  label "Interval"
  input text
  label "days"
  label "Start date"
  slot #dtSupplyIntervalDate
  label "Fixed days"
  input checkbox#chkFixedMonday
  label "Monday" for #chkFixedMonday
  input checkbox#chkFixedTuesday
  label "Tuesday" for #chkFixedTuesday
  input checkbox#chkFixedWednesday
  label "Wednesday" for #chkFixedWednesday
  input checkbox#chkFixedThursday
  label "Thursday" for #chkFixedThursday
  input checkbox#chkFixedFriday
  label "Friday" for #chkFixedFriday
  input checkbox#chkFixedSaturday
  label "Saturday" for #chkFixedSaturday
  input checkbox#chkFixedSunday
  label "Sunday" for #chkFixedSunday
block #divProductPictureDialog
form#frmPrintList
modal#Product_NewLocation_Content small
  heading "Add a new location"
  button "×"
  slot #Product_NewLocation_ValidationContainer
  input text#tdProduct_NewLocation_Description
  label "Location" for #Product_NewLocation_Description
  button "Save" primary
  button "Close"
modal#Product_NewCategory_Content small
  heading "Add a new product category"
  button "×"
  slot #Product_NewCategory_ValidationContainer
  input text#tdProduct_NewCategory_Category
  label "Category" for #Product_NewCategory_Category
  button "Save" primary
  button "Close"
modal#Product_NewBrand_Content small
  heading "Add a new brand"
  button "×"
  slot #Product_NewBrand_ValidationContainer
  input text#tdProduct_NewBrand_Brand
  label "Brand" for #Product_NewBrand_Brand
  button "Save" primary
  button "Close"
modal#Product_NewUnit_Content small
  heading "Add a new unit of measure"
  button "×"
  slot #Product_NewUnit_ValidationContainer
  input text#tdProduct_NewUnit_Unit
  label "Unit" for #Product_NewUnit_Unit
  button "Save" primary
  button "Close"
modal#Product_Delete_Content small
  heading "Delete deprecated products"
  button "×"
  slot #Product_Delete_ValidationContainer
  slot #Delete_ResultContainer (hidden)
  block #Product_Delete_Actions
    button "Delete"
    button "Close"
modal#Product_Merge_Content small
  heading "Merge selected products"
  button "×"
  slot #Product_Merge_ValidationContainer
  select#tdPrimaryMergeProduct
  label "Primary product" for #cmbPrimaryMergeProduct
  label "Merge products"
  slot #MergeProductGridContainer
  block #Product_Merge_Actions
    button "Merge"#Product_Merge_Execute primary
    button "Close"
modal#Product_BulkComponentUpdateInBOMs_Content small
  heading "Replace BOM component"
  button "×"
  block #Product_Update_BOM_Components
    text "Replace one component with another in all affected BOMs. Not applicable to make-to-order BOMs."
    slot #Product_Index_BulkComponentUpdateInBOMs_OldComponent
    slot #Product_Index_BulkComponentUpdateInBOMs_NewComponent
    slot #Product_BulkComponentUpdateInBOMs_CompenentSelection_ValidationContainer
    slot #Product_Index_BulkComponentUpdate_SelectedComponents
  block #Product_Update_BOM_List
    slot #Product_Index_BulkComponentUpdate_SelectedComponents_With_BOM_Count
    slot #Product_Index_BulkComponentUpdate_SuccessCount
    slot #Product_Index_BulkComponentUpdate_FaildCount
  block #Product_Update_BOM_Actions
    button "Continue"#Product_Update_BOM_Start primary
    button "Replace"#Product_Update_Bulk_BOM_Start primary
    button "Close"
modal#divNewFixedAssetTypeDialog
  heading "Add a new fixed asset type"#divNewFixedAssetTypeDialogTitle
  button "×"
  input text#tdFixedAssetTypeName placeholder "Enter a name"
  label "Name"
  select#tdFixedAssetTypeDepreciationMethod
  label "Depreciation method"
  label "Averaging method"
  select#tdFixedAssetTypeAveragingMethod
  select#tdFixedAssetTypeAssetAccountCode
  label "Asset account"
  select#tdFixedAssetTypeAccumulatedDepreciationAccountCode
  label "Accumulated depreciation account"
  select#tdFixedAssetTypeDepreciationExpenseAccountCode
  label "Depreciation expense account"
  input radio#radFixedAssetTypeRate name=rbRate
  label "Rate (%)" for #radFixedAssetTypeRate
  input radio#radFixedAssetTypeEffectiveLife name=rbRate
  label "Effective life (Yrs)" for #radFixedAssetTypeEffectiveLife
  input text#tdFixedAssetTypeRate (hidden)
  input text#tdFixedAssetTypeEffectiveLife (hidden)
  button "Save" primary
  button "Close"
modal#Product_CostingMethodModal small
  heading "Non-zero stock details for"
  button "×"
  input text#inpCostingMethodModal_Number
  label "Batch/ serial #"
  slot #divCostingMethodModal_ExpiryDate
  label "Expiry date"
  button "Save" primary
  button "Close"
modal#Product_ChatGptDialog large
  heading "Generate product description"
  slot #FeatureModuleDetailsBlock (hidden)
  button "×"
  textarea#Product_ChatGpt_Request
  label "Prompt"
  button "Generate with AI"#btnProduct_ChatGpt_GenerateDescription primary
  block #Product_ChatGpt_OldDescriptionDiv
    textarea#Product_ChatGpt_OldDesription
    label "Old description"
  block #Product_ChatGpt_NewDescriptionDiv
    textarea#Product_ChatGpt_NewDesription
    label "New description"
    slot #Product_ChatGpt_NewDescriptionValidation (hidden)
  button "Apply"#btnProduct_ChatGpt_Apply primary
  button "Cancel"
slot #CountrySpecificScript
```

### `/ProductFamily`: Product family

Frame: `iUpload`.

```text
modal#ProductFamily_RemovalAlert small
  heading "Delete family"
  button "×"
  slot #ProductFamily_RemovalAlert_Message
  block #ProductFamily_RemovalAlert_Hint
  block #ProductFamily_RemovalAlert_Buttons
    button "Delete"#ProductFamily_RemovalAlert_ButtonDelete
    button "Remove"#ProductFamily_RemovalAlert_ButtonRemove
    button "Close"
link "Home"
link "Product families"
button "Delete"#deleteAction
button "Save"#saveAction primary
button "Clone"#cloneAction (hidden)
button "Generate BOM"#generateBom primary (hidden)
button "Back to list"#backAction
heading #formCaption
button 
slot #ProductFamily_Index_MainValidationContainer
block #divGeneral
  slot #tdSKU
  label "Family SKU" for #txtSKU
  slot #tdName
  label "Family name" for #txtName
  slot #tdCategory
  label "Category" for #cmbCategory
  slot #tdBrand
  label "Brand" for #cmbBrand
  slot #tdCostingMethod
  label "Costing method" for #cmbCostingMethod
  slot #tdDropShipMode
  label "Drop ship" for #cmbDropShipMode
  slot #tdDropShipSupplier
  label "Drop ship supplier" for #cmbDropShipSupplier
  block #liLastSupplier
    slot #tdLastSupplier
    label "Last supplier" for #cmbLastSupplier
  slot #tdSupplierPrice
  label "Supplier price" for #txtSupplierPrice
  slot #tdOption1Name
  label "Option 1 label" for #txtOption1Name
  slot #tdOption2Name
  label "Option 2 label" for #txtOption2Name
  slot #tdOption3Name
  label "Option 3 label" for #txtOption3Name
  slot #tdUnitOfMeasure
  label "Unit of measure" for #cmbUnitOfMeasure
  slot #tdInventoryAccount
  label "Inventory account" for #cmbInventoryAccount
  slot #tdRevenueAccount
  label "Revenue account" for #cmbRevenueAccount
  slot #tdCOGSAccount
  label "COGS account" for #cmbCOGSAccount
  slot #tdPurchaseTaxRule
  label "Purchase tax rule" for #cmbPurchaseTaxRule
  slot #tdSaleTaxRule
  label "Sale tax rule" for #cmbSaleTaxRule
  slot #tdDefaultLocation
  label "Default location" for #cmbDefaultLocation
  slot #tdAttributeSet
  label "Additional attributes set" for #cmbAttributeSet
  slot #tdMinimumBeforeReorder
  label "Minimum before reorder" for #txtMinimumBeforeReorder
  slot #tdReorderQuantity
  label "Reorder quantity" for #txtReorderQuantity
  input text#tdTags
  label "Tags" for #txtTags
  block #liWarrantySetup (hidden)
    slot #tdWarrantySetup
    label "Warranty" for #tdWarrantySetup
  block #liHSCode
    input text#tdHSCode
    label "HS code" for #tdHSCode
  block #liCountryOfOrigin
    slot #divCountryOfOrigin
    label "Country of origin" for #divCountryOfOrigin
  slot #tdPriceTier1
  label "" for #txtPriceTier1
  slot #tdPriceTier2
  label "" for #txtPriceTier2
  slot #tdPriceTier3
  label "" for #txtPriceTier3
  slot #tdPriceTier4
  label "" for #txtPriceTier4
  slot #tdPriceTier5
  label "" for #txtPriceTier5
  slot #tdPriceTier6
  label "" for #txtPriceTier6
  slot #tdPriceTier7
  label "" for #txtPriceTier7
  slot #tdPriceTier8
  label "" for #txtPriceTier8
  slot #tdPriceTier9
  label "" for #txtPriceTier9
  slot #tdPriceTier10
  label "" for #txtPriceTier10
  slot #tdDiscount
  label "Product discount" for #cmbDiscount
  slot #tdBOM
  label "Bill of materials" for #cmbBOM
  textarea#divShortDescription
  label "Short description" for #divShortDescription
  button "Generate with AI" primary
  block #liDescription
    textarea#divDescription
    label "Description" for #divDescription
    button "Generate with AI" primary
  block #liDescriptionHTML (hidden)
    slot #productFamilyDescriptionEditor
block #divOptions (hidden)
  button #divNewOption1 primary
  slot #tdOption1Values
  button #divNewOption2 primary
  slot #tdOption2Values
  button #divNewOption3 primary
  slot #tdOption3Values
block #divVariations (hidden)
  button #divNewProduct primary
  button "Generate"#divGenerate
  slot #tdVariations
  heading "Product dimensions and weight"
  slot #tdVariationDims
  block #divAttributeSet (hidden)
    heading "Product additional attributes"
    slot #tdAdditionalAttributes
block #divProductionBOM (hidden)
  heading "Production BOM"
  slot #liOutputQuantity
  label "Quantity to produce *" for #liOutputQuantity
  slot #ProductFamily_Index_ProductionInstructionURL
  label "Production instruction URL" for #ProductFamily_Index_ProductionInstructionURL
  slot #liManufacturingBufferTime
  label "Buffer, %" for #liManufacturingBufferTime
  slot #liIgnoreCumulativeLeadTime
  label "Ignore cumulative lead time" for #chkIgnoreCumulativeLeadTime
  block #ComponentProductionLeadTimeContainer
    slot #liComponentProductionLeadTime
    label "Production lead time" for #liComponentProductionLeadTime
  text "The operation below must have a specified duration (cycle time), the number of units that can be produced during the cyc"
  button "Operation"#divBom_AddOperation primary
  slot #cmb_ProductionIssueMethod
  label "Issue method" for #cmb_ProductionIssueMethod
  slot #cmbCopyBom
  button "Clone BOM"#btnCopyBom primary
  button "Generate BOM"#generateBom2 primary
  block #divProductionBomData
    block #noOperationsBlock
  button "Add more operations"#divBom_AddOperation2 primary
  block #finishedProductBlock
    heading "Finished products output"
    slot #cmbFinishedProductCost
    label "Cost allocation type *" for #cmbFinishedProductCost
    slot #divFinishedProductsData
  block #wastageProductsCostBlock
    heading "Cost of wastage"
    slot #divWastageProductsData
  slot #ProductFamily_Index_ProductionBOMTotalMin
  slot #ProductFamily_Index_ProductionBOMTotalMax
  modal#ProductFamily_VariationQuantity small
    heading "Set up of quantity for variation"
    button "×"
    select#cmbProductFamily_VariationQuantity
    label "Select quantity condition" for #cmbProductFamily_VariationQuantity
    block #controlQuantityAll
      input text#tdProductFamily_VariationQuantity placeholder "Enter the quantity"
      label "Quantity" for #tdProductFamily_VariationQuantity
    slot #listControlsQuantityOption1 (hidden)
    slot #listControlsQuantityOption2 (hidden)
    slot #listControlsQuantityOption3 (hidden)
    button "Save" primary
    button "Close"
  form#productionBomFileUploader
    input file name=file
block #divMapVariations (hidden)
  block #toggleableColumn
    tabs: 
  input file#fileImportVariations (hidden)
  button "Import"#btnImportVariations
  button "Export"#btnExportVariations
  heading "Variations"
  heading "Product family:"
block #divAttachments (hidden)
  block #divAttachmentUpload
    block #divUploadContainer
      block #preview-template (hidden)
      slot #iUpload (hidden)
      form#frmUpload
        heading "Drop files here or click to upload."
  block #divUploadImpossible
  button "Attach from Google Drive" primary
  slot #divAttachmentList
block #divUsedIn (hidden)
  slot #divUsedInProductsData
block #divActivityLogs (hidden)
  slot #ActivityLogs_Container
modal#ProductFamily_Clone_Content small
  heading "New product family"
  button "×"
  input text#tdProductFamily_CloneFamily_Sku
  label "Family SKU" for #tdProductFamily_CloneFamily_Sku
  input text#tdProductFamily_CloneFamily_Name
  label "Family name" for #tdProductFamily_CloneFamily_Name
  button "Clone" primary
  button "Cancel"
modal#ProductFamily_NewLocation_Content small
  heading "Add a new location"
  button "×"
  input text#tdProductFamily_NewLocation_Description
  label "Location" for #ProductFamily_NewLocation_Description
  button "Save" primary
  button "Close"
modal#ProductFamily_NewCategory_Content small
  heading "Add a new category"
  button "×"
  input text#tdProductFamily_NewCategory_Category
  label "Category" for #ProductFamily_NewCategory_Category
  button "Save" primary
  button "Close"
modal#ProductFamily_NewBrand_Content small
  heading "Add a new brand"
  button "×"
  input text#tdProductFamily_NewBrand_Brand
  label "Brand" for #ProductFamily_NewBrand_Brand
  button "Save" primary
  button "Close"
modal#ProductFamily_NewUnit_Content small
  heading "Add a new unit of measure"
  button "×"
  label "Unit" for #ProductFamily_NewUnit_Unit
  input text#tdProductFamily_NewUnit_Unit
  button "Save" primary
  button "Close"
modal#Product_ChatGptDialog large
  heading "Generate product description"
  slot #FeatureModuleDetailsBlock (hidden)
  button "×"
  textarea#Product_ChatGpt_Request
  label "Prompt"
  button "Generate with AI"#btnProduct_ChatGpt_GenerateDescription primary
  block #Product_ChatGpt_OldDescriptionDiv
    textarea#Product_ChatGpt_OldDesription
    label "Old description"
  block #Product_ChatGpt_NewDescriptionDiv
    textarea#Product_ChatGpt_NewDesription
    label "New description"
    slot #Product_ChatGpt_NewDescriptionValidation (hidden)
  button "Apply"#btnProduct_ChatGpt_Apply primary
  button "Cancel"
```

### `/ProductFamilyList`: Product families

Frame: `task-upload-frame`.

```text
link "Home"
button "More"#divMore ▾
link "Delete product families"
button "Import"#divImport ▾
link "Images and attachments"
button "Export"#divExport ▾
link "Images and attachments"
button #divNew primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
button #divRefresh
button #GridOptions
slot #ProductFamilyList_Index_Container
block #divProductPictureDialog
form#frmExportImages
modal#ProductFamilyList_Delete_Content small
  heading "Delete families"
  button "×"
  slot #ProductFamilyList_Delete_ValidationContainer
  block #ProductFamilyList_RemovalAlert_Hint
  block #ProductFamilyList_Delete_Actions
    button "Delete"#ProductFamilyList_Delete_Execute
    button "Remove"#ProductFamilyList_RemovalAlert_ButtonRemove
    button "Close"
```

### `/Recall`: Batch/lot recall

Frame: `task-upload-frame`.

```text
block #BatchLotRecallReport
  block #MainContent
    link "Home"
    heading "Batch/lot recall"
    slot #tdProduct
    label "Product / Batch / Lot / Serial number"
    slot #divShowRelated
    label "Show all related" for #chkShowRelated
    button "Show" primary
    button "CUSTOMERS"
    button "STOCK ON HAND"
    button "SUPPLIERS"
    button "USED IN"
    block #divCustomers (hidden)
      button "Refresh"#divRefresh_Customers
      button "Print"#printAction primary
      button "Export"#divExport_Customers primary
      button #Grid_Customer_Options
      input text#divSearchCustomers placeholder "Type text to search"
      button "Search" primary
      slot #divCustomerLines
    block #divOnHand (hidden)
      button "Refresh"#divRefresh_OnHand
      button "Export"#divExport_OnHand primary
      button #Grid_OnHand_Options
      input text#divSearchOnHand placeholder "Type text to search"
      button "Search" primary
      slot #divOnHandLines
    block #divSuppliers (hidden)
      button "Refresh"#divRefresh_Suppliers
      button "Export"#divExport_Suppliers primary
      button #Grid_Supplier_Options
      input text#divSearchSuppliers placeholder "Type text to search"
      button "Search" primary
      slot #divSupplierLines
    block #divUsedIn (hidden)
      button "Refresh"#divRefresh_UsedIn
      button "Export"#divExport_UsedIn primary
      input text#divSearchUsedIn placeholder "Type text to search"
      button "Search" primary
      slot #divUsedInLines
    form#frmExport
    form#frmPrint
```

### `/Stock`: Product availability

Frame: `task-upload-frame`.

```text
link "Home"
block #divList
  heading "Product availability"
  block #divSuggestReorder (hidden)
    button "Suggest reorder"
  button "Print"#divPrint ▾
  slot #printDropdownList
  button "Export"#divExport
  button #divRefresh
  button #Grid_gridName_Options
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  input checkbox#divOnlyActive
  label "Only active" for #divOnlyActive
  input checkbox#divNonZero
  label "Show only non-zero" for #divNonZero
  select#inventoroAvailabilityFilter
  select#batchFilter
  block #divSelectedItemCount
    slot #lSelectedCounter
  slot #Stock_Index_Container
block #divAllocatedDetails
  heading "Allocated details"
  button "Back to list"#hideAllocated
  slot #AllocatedGrid_Container
block #divOnOrderDetails
  heading "On order details"
  button "Back to list"#hideOnOrder
  slot #OnOrderGrid_Container
block #divInTransitDetails
  heading "In transit details"
  button "Back to list"#hideInTransit
  slot #InTransitGrid_Container
form#frmExport
form#frmPrintList
modal#dlgAddNewStockOnHand large
  heading "Add new stock on hand quantity"
  button "×"
  slot #divRemaining (hidden)
  slot #divNoStock (hidden)
  button "Save"#btnSaveAdjustment primary
  button "Close"#btnCancelAdjustment
```

### `/StockAdjustment`: Stock adjustment

Frame: `iUpload`.

```text
link "Home"
link "Stock adjustments and stocktakes"
button "Save"#saveAction primary
button "Back to list"#backAction
block #divMainContent
  slot #tdStatus
  heading 
  button "Void"#voidAction
  button "Complete"#completeAction primary
  button "Export"#exportNewAction
  button "Import"#importNewAction
  button "Print" ▾
  slot #divPrintContainer
  button "Undo"#undoAction
  block #divStockAdjustmentTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #tdEffectiveDate
    label "Effective date"
    slot #tdAccount
    label "Expense account"
    block #rowEffectiveDate
      slot #tdCustomerReference
      label "Reference"
    slot #tdComment
    label "Comment"
    block #infoAlertContainer (hidden)
      slot #infoAlert
  button "Non-zero stock"
  button "Zero stock"
  button "Activity logs"
  button "Attachments"
  button "Financials"
  block #divNonZero (hidden)
    heading "Non-zero stock on hand product"
    button #divNewExisting primary
    button "Scan"#scanNonZeroAction
    slot #divRemaining
    button "Add more items"#divNewNonZeroLine primary (hidden)
  block #divZero (hidden)
    heading "Zero stock on hand product"
    button #divNew primary
    button "Scan"#scanAction
    slot #liCostType
    label "Cost is estimated using" for #cmbCostType
    slot #divNoStock
    button "Add more items"#divNewZeroLine primary (hidden)
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#attachmentsUploadForm
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Event type
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
  form#frmPrint
  modal#divUploadNewLines medium
    heading "Upload a new stock adjustment"
    button "×"
    heading "1. Download this stock adjustment"
    text "Download CSV file"#downloadThisStockList
    heading "2. Add new and modify existing lines in the file."
    heading "3. Upload"
    block #ImportLinesExceptionsContainer (hidden)
      block #ImportLinesDownloadExceptions (hidden)
        button "Download invalid lines"
        button "Download full file with errors"
      block #ImportLinesUploadValidLines (hidden)
        button "Upload valid lines" primary
      slot #ImportLinesExceptionsGrid
    slot #ifrmExportInvalidLines (hidden)
    form#frmExportInvalidLines
    slot #ifrmUpload (hidden)
    form#frmUpload
      heading "Drop files here or click to upload."
    slot #ifrmDownloadNewLines (hidden)
    form#frmDownloadNewLines
    button "Close"
  slot #divFooterPlaceholder
  modal#divScan small
    heading "Scanning"
    button "×"
    tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
    block #divScanLocation
      slot #tdScanLocation
      label "Location to pick from" for #cmbScanLocation
    block #scanDesc
    block #scanBar
      block #dScan
        slot #spScan
    slot #ScanValidationContainer (hidden)
    block #liScanPackBoxAutomatic (hidden)
      slot #tdScanPackBoxAutomatic
      label "Box #" for #txtScanPackBoxInventory
    input text#txtScanFocus
    block #divScanInfo (hidden)
      heading "Found product:"
      slot #divScanProductSelection (hidden)
      block #liScanPackBox (hidden)
        label "Box #:"
        slot #tdScanPackBox
      label "SKU:"
      block #tdScanProductCode
      label "Name:"
      block #tdScanName
      label "Barcode:"
      block #tdScanBarcode
      block #liScanBatchSN (hidden)
        label "Batch/serial number:"
        slot #tdScanBatchSN
      block #liScanExpiryDate (hidden)
        label "Expiry date:"
        slot #tdScanExpiryDate
      block #liScanQuantity (hidden)
        label "Quantity:"
        slot #tdScanQuantity
    block #ScanInventoryModeContainer (hidden)
      slot #divInventoryModeBarcodes
      label "Barcodes"
      block #liScanPackBoxInventory (hidden)
        slot #tdScanPackBoxInventory
        label "Box #"
    block #ScanInventoryModeControls (hidden)
      button "Save"#liScanSaveInventory primary
      button "Close"
    block #ScanManualModeControls (hidden)
      button "Save"#liScanSave primary (hidden)
      button "Close"
    block #divScanAutoActions
      button "Close"
  modal#StocktakeSortingDialog small
    heading "Print"
    button 
    select#stocktakeSortingDropdown: Product name | SKU | Bin
    label "Sort data by" for #stocktakeSortingDropdown
    button "Print"#btnPrintAction primary
    button "Close"
```

### `/StockAdjustmentList`: Stock adjustments and stocktakes

Frame: `task-upload-frame`.

```text
link "Home"
block #divList
  heading "Stock adjustments and stocktakes"
  button #divNew primary
  slot #newDropdownList
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  button #divRefresh
  button #Grid_gridName_Options
  slot #StockAdjustmentContainer
```

### `/StockTake`: Stocktake/adjustments

Redirects to `/StockTake/New`.

Frame: `iUpload`.

```text
link "Home"
link "Stock adjustments and stocktakes"
button "Save"#saveAction primary
button "Back to list"
block #divMainContent
  slot #tdStatus
  heading 
  button "Void"#voidAction
  button "Start"#startAction primary
  button "Scan barcode"#scanAction
  button "Sync"#syncAction primary
  button "Complete"#completeAction primary
  button "Print" ▾
  slot #divPrintContainer
  button "Undo"#undoAction
  block #divStocktakeTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divHeader
    block #divTaskHeader
      slot #tdEffectiveDate
      label "Effective date"
      slot #tdLocation
      label "Location"
      slot #tdIncludeQuantityOnHand
      label "Include quantity on hand"
      slot #tdAccount
      label "Expense account"
      slot #tdCustomerReference
      label "Reference"
      slot #tdComment
      label "Comment"
    heading "Additional filters"
    block #divAdditionalFilters
      slot #Stocktake_New_StockLocators
      label "Stock locator"
      slot #stockLocatorsPlaceholder
      slot #Stocktake_New_Categories
      label "Category"
      slot #categoriesPlaceholder
      slot #Stocktake_New_Brands
      label "Brand"
      slot #brandsPlaceholder
      slot #Stocktake_New_Tags
      label "Tag"
      slot #tagsPlaceholder
      slot #Stocktake_New_Bins
      label "Bin"
      slot #binsPlaceholder
      slot #Stocktake_New_BinGroups
      label "Bin group"
      slot #binGroupsPlaceholder
      slot #Stocktake_New_PickZones
      label "Pick zone"
      slot #pickZonesPlaceholder
      block #foundFilteredItemsContainer
        slot #foundFilteredItems
  button "Non-zero stock"
  button "Zero stock"
  button "Activity logs"
  button "Attachments"
  button "Financials"
  block #divNonZero (hidden)
    heading "Non-zero stock on hand product"
    block #divSTNote1
      text "the sync screen"#stSyncLink
    input text#divSearch placeholder "Type text to search"
    button "Search" primary
    slot #divRemaining
    button "Export"#exportAction primary
    button "Import"#importAction primary
  block #divZero (hidden)
    heading "Zero stock on hand product"
    button #divNew primary
    slot #divNoStock
    button "Add more items"#Stocktake_New_AddNewLineLink primary
    button "Export"#exportNewAction primary
    button "Export all products"#exportNewActionAll primary
    button "Import"#importNewAction primary
  block #divActivityLogs (hidden)
    heading "Activity log"
    slot #ActivityLogs_Container
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Event type
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#attachmentsUploadForm
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    slot #divAttachmentList
slot #ifrmDownloadNewLines (hidden)
form#frmDownloadNewLines
form#frmPrint
form#frmExport
form#frmExportNewAllProducts
modal#divUploadNewLines medium
  heading "Upload a new stock adjustment"
  button "×"
  heading "1. Download current lines"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #ImportLinesExceptionsContainer (hidden)
    slot #ImportLinesExceptionsGrid
  slot #ifrmUploadNewLines (hidden)
  form#frmUploadNewLines
    heading "Drop files here or click to upload."
  button "Close"
modal#divImport medium
  button 
  heading "Import stocktake quantities"
  block #divSTNote1
  block #ImportExceptionsContainer (hidden)
    slot #ImportExceptionsGrid
  slot #ifrmImportUpload (hidden)
  form#frmImportUpload
    heading "Drop files here or click to upload."
  button "Close"
modal#StocktakeSortingDialog small
  heading "Print"
  button 
  select#stocktakeSortingDropdown: Product name | SKU | Bin
  label "Sort data by" for #stocktakeSortingDropdown
  button "Print"#btnPrintAction primary
  button "Close"
modal#divScan small
  heading "Scanning"
  button 
  tabs#ModeTabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #Stocktake_New_ScanValidationContainer (hidden)
  block #liScanPackBoxAutomatic (hidden)
    slot #tdScanPackBoxAutomatic
    label "Box #" for #txtScanPackBoxInventory
  input text#txtScanFocus
  block #divInfo (hidden)
    heading "Found product:"#divInfoProductInfo
    slot #divProductSelection (hidden)
    label "SKU:"
    block #tdProductCode
    label "Name:"
    block #tdName
    label "Barcode:"
    block #tdBarcode
    block #liBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdBatchSN
    label "Bin:"
    block #tdBin
    block #liExpiryDate (hidden)
      label "Expiry date:"
      slot #tdExpiryDate
    label "On hand:"
    slot #tdOnHand
    block #liQuantity (hidden)
      label "Quantity:"
      slot #tdQuantity
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    label "Barcodes"
  block #ScanInventoryModeControls (hidden)
    button "Save"#liSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Save"#liSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
```

### `/StockTransfer`: Stock transfer

Frame: `iUpload`.

```text
link "Home"
link "Stock transfers"
button "Save"#saveAction primary
button "Back to list"
block #divMainContent
  slot #StockTransfer_Index_Status
  heading 
  button "Void"#voidAction
  button "Print" ▾
  slot #divPrintContainer
  button "Email" ▾
  slot #divEmailContainer
  button "Undo"#undoAction
  block #divStocktransferTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #tdFrom
    label "From"
    slot #tdTo
    label "To"
    slot #tdCustomerReference
    label "Reference"
    slot #chkSkipOrder
    label "Skip order" for #skipOrder
    slot #chkUsePutAway
    label "Put away" for #usePutAway
    block #divNote
      slot #tdRequiredBy
      label "Shipment required by date"
      slot #tdDepartureDate
      label "Stock sent date"
      slot #tdAccount
      label "In-transit account"
      slot #tdCompletionDate
      label "Stock received date"
    slot #tdComment
    label "Comment"
  button "Order"
  button "Products"
  button "Excise tax"
  button "Put away"
  button "Manual journals"
  button "Activity logs"
  button "Attachments"
  button "Financials"
  block #divOrder (hidden)
    button #divNewOrder primary
    button "Family"#divAddBulk_Order
    button "Scan"#divButtonScanOrder
    button "Export"#exportNewActionOrder
    button "Import"#importNewActionOrder
    button "Print labels"#printLabelsActionOrder
    button "Skip"#divSkip_Order primary
    button "Authorize"#divAuthorise_Order primary
    slot #StockTransfer_Order_Content
    button "Add more items"#StockTransfer_Order_AddLink primary
  block #divProducts (hidden)
    button #divNew primary
    button "Fill from order"#divAuto_Pick
    button "Scan"#divButtonScan
    button "Export"#exportNewAction
    button "Import"#importNewAction
    button "Print labels"#printLabelsAction
    button "Send stock"#sendStockAction primary
    button "Complete"#completeAction primary
    slot #StockTransfer_Index_Content
    button "Add more items"#StockTransfer_AddLink primary
  block #divExciseTax (hidden)
    button "Authorize"#divAuthorise_ExciseTax primary
    slot #tdStockTransfer_ExciseTax_ExciseReferenceNo
    label "Reference #"
    slot #tdStockTransfer_ExciseTax_TransferLicenseNo
    label "Transfer license no."
    slot #tdStockTransfer_ExciseTax_IsCustomsClearanceRequired
    label "Customs clearance required"
    slot #tdStockTransfer_ExciseTax_ExciseDate
    label "Excise tax effective date"
    slot #tdStockTransfer_ExciseTax_DateExciseTaxPaid
    label "Date of excise tax paid"
    slot #divExciseTaxLines
    slot #StockTransfer_ExciseTax_BaseCurrency
    text "{amount}"#StockTransfer_ExciseTax_ExciseTaxTotal
  block #divPutAway (hidden)
    button #divNewPutAway primary
    button "Scan"#divButtonScanPutAway
    button "Load consumption bins"#btnLoadBins (hidden)
    button "Complete"#completePutAwayAction primary
    button "Undo"#undoPutAwayAction
    slot #StockTransfer_PutAway_Content
    button "Add more items"#StockTransfer_AddLinkPutAway primary
  block #divManualJournals (hidden)
    button #divNew_ManualJournals primary
    slot #tdCostDistributionType
    label "Distribute journals using the product"
    slot #divManualJournalsLines
    button "Add more items"#Sale_AdditionalCOGS_AddLineLink primary
    block #StockTransfer_ManualJournals_DistributedCostsHeader (hidden)
      heading "Manual distribution cost"
    block #StockTransfer_ManualJournals_DistributedCostBlock (hidden)
      slot #divManualJournalsDistributedCostLines
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#attachmentsUploadForm
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
form#frmPrint
modal#divUploadNewLines medium
  heading "Upload a new stock transfer"
  button "×"
  heading "1. Download current lines"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  slot #ImportLinesValidationContainer (hidden)
  block #ImportLinesExceptionsContainer (hidden)
    slot #ImportLinesExceptionsGrid
  form#StockTransferDropContainer
    heading "Drop files here or click to upload."
  slot #ifrmDownloadNewLines (hidden)
  form#frmDownloadNewLines
  form#frmUploadNewLines
  button "Close"
modal#divUploadNewLinesOrder medium
  heading "Upload a new stock order list"
  button "×"
  heading "1. Download current lines"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  slot #ImportOrderLinesValidationContainer (hidden)
  block #ImportOrderLinesExceptionsContainer (hidden)
    slot #ImportOrderLinesExceptionsGrid
  form#StockTransferDropContainerOrder
    heading "Drop files here or click to upload."
  slot #ifrmDownloadNewLinesOrder (hidden)
  form#frmDownloadNewLinesOrder
  form#frmUploadNewLinesOrder
  button "Close"
modal#divScanDialog small
  heading "Scanning"
  button 
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  block #divScanLocation
    slot #tdScanLocation
    label "Location to pick from" for #cmbScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #ScanValidationContainer (hidden)
  block #liScanPackBoxAutomatic (hidden)
    slot #tdScanPackBoxAutomatic
    label "Box #" for #txtScanPackBoxInventory
  input text#txtScanFocus
  block #divScanInfo (hidden)
    heading "Found product:"
    slot #divScanProductSelection (hidden)
    block #liScanPackBox (hidden)
      label "Box #:"
      slot #tdScanPackBox
    label "SKU:"
    block #tdScanProductCode
    label "Name:"
    block #tdScanName
    label "Barcode:"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date:"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity:"
      slot #tdScanQuantity
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    label "Barcodes"
    block #liScanPackBoxInventory (hidden)
      slot #tdScanPackBoxInventory
      label "Box #"
  block #ScanInventoryModeControls (hidden)
    button "Save"#liScanSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Save"#liScanSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
modal#secEmail medium
  heading #emailDialogCaption
  button "×"
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  button #DEAREmailTo_btn
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
    button #DEAREmailCC_btn
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
  heading "Select files to attach"
  block #EmailSendTemplate_AttachedFiles
    heading #headerForOrderAttachments
    slot #attachedFiles
  block #EmailSendTemplate_AttachedFiles_Product
    heading "Product"
    slot #attachedFiles_Product
  block #EmailSendTemplate_AttachedFiles_Supplier
    heading "Supplier"
    slot #attachedFiles_Supplier
  block #EmailSendTemplate_AttachedFiles_Customer
    heading "Customer"
    slot #attachedFiles_Customer
  heading "Email template"
  slot #tdEmail_Body
  block #emailReCaptcha (hidden)
  button "Send"#btnSendEmail primary
  button "Close"#emailBackAction
modal#secRecipients medium
  heading "Select a recipient"
  button "×"
  slot #gridRecipients
  button "OK" primary
  button "Close"
slot #btnSendEmail2
modal#dlgFamilyMatrix medium
  heading "Add a product family"
  button "×"
  slot #FamilyMatrix_cmbFamily
  label "Product family"
  input checkbox#FamilyMatrix_cbOnlyAvailable
  label "Show only available variations" for #FamilyMatrix_cbOnlyAvailable_InputId
  slot #FamilyMatrix_divMessage (hidden)
  block #FamilyMatrix_divOptions (hidden)
    tabs: Matrix | List
    tab pane#FamilyMatrix_divFamilyMatrixTab
      block #FamilyMatrix_divBaseOptionContainer (hidden)
        slot #FamilyMatrix_cmbBaseOption
        label "Select base option:"
        slot #FamilyMatrix_cmbBaseOptionValue
        label "and its value:"
      slot #FamilyMatrix_divMatrixContainer
    tab pane#FamilyMatrix_divFamilyListTab
      slot #FamilyMatrix_divListContainer
  button "Add products"#FamilyMatrix_btnAdd primary
  button "Close"#FamilyMatrix_btnClose
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/StockTransferList`: Stock transfers

Frame: `task-upload-frame`.

```text
link "Home"
heading "Stock transfers"
block #bulkActionsNoteSuccess (hidden)
block #bulkActionsNoteWarning (hidden)
block #bulkActionsNoteError (hidden)
button #divNew primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
slot #StockTransfer_FilterSummary
button "Locations"#btnTransferFilters
block #divStatusFilterContainer
  select#divStatusFilter
button #divRefresh
button #Grid_gridName_Options
block #divBulkActions
  slot #lSelectedCounter
  button "Undo"#btnUndo (hidden)
  button "Void"#btnVoid (hidden)
slot #StocktransferList_Index_Container
modal#Stock_Transfer_Filters_Content small
  heading "Location filters"
  button "×"
  label "From location"
  slot #TransferFilters_FromLocation
  label "From bin"
  slot #TransferFilters_FromBin
  label "To location"
  slot #TransferFilters_ToLocation
  label "To bin"
  slot #TransferFilters_ToBin
  button "Clear all" primary
  button "Apply" primary
  button "Cancel"
```

### `/Stocktake/New`: Stocktake/adjustments

Frame: `iUpload`.

```text
link "Home"
link "Stock adjustments and stocktakes"
button "Save"#saveAction primary
button "Back to list"
block #divMainContent
  slot #tdStatus
  heading 
  button "Void"#voidAction
  button "Start"#startAction primary
  button "Scan barcode"#scanAction
  button "Sync"#syncAction primary
  button "Complete"#completeAction primary
  button "Print" ▾
  slot #divPrintContainer
  button "Undo"#undoAction
  block #divStocktakeTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divHeader
    block #divTaskHeader
      slot #tdEffectiveDate
      label "Effective date"
      slot #tdLocation
      label "Location"
      slot #tdIncludeQuantityOnHand
      label "Include quantity on hand"
      slot #tdAccount
      label "Expense account"
      slot #tdCustomerReference
      label "Reference"
      slot #tdComment
      label "Comment"
    heading "Additional filters"
    block #divAdditionalFilters
      slot #Stocktake_New_StockLocators
      label "Stock locator"
      slot #stockLocatorsPlaceholder
      slot #Stocktake_New_Categories
      label "Category"
      slot #categoriesPlaceholder
      slot #Stocktake_New_Brands
      label "Brand"
      slot #brandsPlaceholder
      slot #Stocktake_New_Tags
      label "Tag"
      slot #tagsPlaceholder
      slot #Stocktake_New_Bins
      label "Bin"
      slot #binsPlaceholder
      slot #Stocktake_New_BinGroups
      label "Bin group"
      slot #binGroupsPlaceholder
      slot #Stocktake_New_PickZones
      label "Pick zone"
      slot #pickZonesPlaceholder
      block #foundFilteredItemsContainer
        slot #foundFilteredItems
  button "Non-zero stock"
  button "Zero stock"
  button "Activity logs"
  button "Attachments"
  button "Financials"
  block #divNonZero (hidden)
    heading "Non-zero stock on hand product"
    block #divSTNote1
      text "the sync screen"#stSyncLink
    input text#divSearch placeholder "Type text to search"
    button "Search" primary
    slot #divRemaining
    button "Export"#exportAction primary
    button "Import"#importAction primary
  block #divZero (hidden)
    heading "Zero stock on hand product"
    button #divNew primary
    slot #divNoStock
    button "Add more items"#Stocktake_New_AddNewLineLink primary
    button "Export"#exportNewAction primary
    button "Export all products"#exportNewActionAll primary
    button "Import"#importNewAction primary
  block #divActivityLogs (hidden)
    heading "Activity log"
    slot #ActivityLogs_Container
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Event type
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#attachmentsUploadForm
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    slot #divAttachmentList
slot #ifrmDownloadNewLines (hidden)
form#frmDownloadNewLines
form#frmPrint
form#frmExport
form#frmExportNewAllProducts
modal#divUploadNewLines medium
  heading "Upload a new stock adjustment"
  button "×"
  heading "1. Download current lines"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #ImportLinesExceptionsContainer (hidden)
    slot #ImportLinesExceptionsGrid
  slot #ifrmUploadNewLines (hidden)
  form#frmUploadNewLines
    heading "Drop files here or click to upload."
  button "Close"
modal#divImport medium
  button 
  heading "Import stocktake quantities"
  block #divSTNote1
  block #ImportExceptionsContainer (hidden)
    slot #ImportExceptionsGrid
  slot #ifrmImportUpload (hidden)
  form#frmImportUpload
    heading "Drop files here or click to upload."
  button "Close"
modal#StocktakeSortingDialog small
  heading "Print"
  button 
  select#stocktakeSortingDropdown: Product name | SKU | Bin
  label "Sort data by" for #stocktakeSortingDropdown
  button "Print"#btnPrintAction primary
  button "Close"
modal#divScan small
  heading "Scanning"
  button 
  tabs#ModeTabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #Stocktake_New_ScanValidationContainer (hidden)
  block #liScanPackBoxAutomatic (hidden)
    slot #tdScanPackBoxAutomatic
    label "Box #" for #txtScanPackBoxInventory
  input text#txtScanFocus
  block #divInfo (hidden)
    heading "Found product:"#divInfoProductInfo
    slot #divProductSelection (hidden)
    label "SKU:"
    block #tdProductCode
    label "Name:"
    block #tdName
    label "Barcode:"
    block #tdBarcode
    block #liBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdBatchSN
    label "Bin:"
    block #tdBin
    block #liExpiryDate (hidden)
      label "Expiry date:"
      slot #tdExpiryDate
    label "On hand:"
    slot #tdOnHand
    block #liQuantity (hidden)
      label "Quantity:"
      slot #tdQuantity
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    label "Barcodes"
  block #ScanInventoryModeControls (hidden)
    button "Save"#liSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Save"#liSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
```

### `/Stocktransfer`: Stock transfer

Frame: `iUpload`.

```text
link "Home"
link "Stock transfers"
button "Save"#saveAction primary
button "Back to list"
block #divMainContent
  slot #StockTransfer_Index_Status
  heading 
  button "Void"#voidAction
  button "Print" ▾
  slot #divPrintContainer
  button "Email" ▾
  slot #divEmailContainer
  button "Undo"#undoAction
  block #divStocktransferTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #tdFrom
    label "From"
    slot #tdTo
    label "To"
    slot #tdCustomerReference
    label "Reference"
    slot #chkSkipOrder
    label "Skip order" for #skipOrder
    slot #chkUsePutAway
    label "Put away" for #usePutAway
    block #divNote
      slot #tdRequiredBy
      label "Shipment required by date"
      slot #tdDepartureDate
      label "Stock sent date"
      slot #tdAccount
      label "In-transit account"
      slot #tdCompletionDate
      label "Stock received date"
    slot #tdComment
    label "Comment"
  button "Order"
  button "Products"
  button "Excise tax"
  button "Put away"
  button "Manual journals"
  button "Activity logs"
  button "Attachments"
  button "Financials"
  block #divOrder (hidden)
    button #divNewOrder primary
    button "Family"#divAddBulk_Order
    button "Scan"#divButtonScanOrder
    button "Export"#exportNewActionOrder
    button "Import"#importNewActionOrder
    button "Print labels"#printLabelsActionOrder
    button "Skip"#divSkip_Order primary
    button "Authorize"#divAuthorise_Order primary
    slot #StockTransfer_Order_Content
    button "Add more items"#StockTransfer_Order_AddLink primary
  block #divProducts (hidden)
    button #divNew primary
    button "Fill from order"#divAuto_Pick
    button "Scan"#divButtonScan
    button "Export"#exportNewAction
    button "Import"#importNewAction
    button "Print labels"#printLabelsAction
    button "Send stock"#sendStockAction primary
    button "Complete"#completeAction primary
    slot #StockTransfer_Index_Content
    button "Add more items"#StockTransfer_AddLink primary
  block #divExciseTax (hidden)
    button "Authorize"#divAuthorise_ExciseTax primary
    slot #tdStockTransfer_ExciseTax_ExciseReferenceNo
    label "Reference #"
    slot #tdStockTransfer_ExciseTax_TransferLicenseNo
    label "Transfer license no."
    slot #tdStockTransfer_ExciseTax_IsCustomsClearanceRequired
    label "Customs clearance required"
    slot #tdStockTransfer_ExciseTax_ExciseDate
    label "Excise tax effective date"
    slot #tdStockTransfer_ExciseTax_DateExciseTaxPaid
    label "Date of excise tax paid"
    slot #divExciseTaxLines
    slot #StockTransfer_ExciseTax_BaseCurrency
    text "{amount}"#StockTransfer_ExciseTax_ExciseTaxTotal
  block #divPutAway (hidden)
    button #divNewPutAway primary
    button "Scan"#divButtonScanPutAway
    button "Load consumption bins"#btnLoadBins (hidden)
    button "Complete"#completePutAwayAction primary
    button "Undo"#undoPutAwayAction
    slot #StockTransfer_PutAway_Content
    button "Add more items"#StockTransfer_AddLinkPutAway primary
  block #divManualJournals (hidden)
    button #divNew_ManualJournals primary
    slot #tdCostDistributionType
    label "Distribute journals using the product"
    slot #divManualJournalsLines
    button "Add more items"#Sale_AdditionalCOGS_AddLineLink primary
    block #StockTransfer_ManualJournals_DistributedCostsHeader (hidden)
      heading "Manual distribution cost"
    block #StockTransfer_ManualJournals_DistributedCostBlock (hidden)
      slot #divManualJournalsDistributedCostLines
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#attachmentsUploadForm
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
form#frmPrint
modal#divUploadNewLines medium
  heading "Upload a new stock transfer"
  button "×"
  heading "1. Download current lines"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  slot #ImportLinesValidationContainer (hidden)
  block #ImportLinesExceptionsContainer (hidden)
    slot #ImportLinesExceptionsGrid
  form#StockTransferDropContainer
    heading "Drop files here or click to upload."
  slot #ifrmDownloadNewLines (hidden)
  form#frmDownloadNewLines
  form#frmUploadNewLines
  button "Close"
modal#divUploadNewLinesOrder medium
  heading "Upload a new stock order list"
  button "×"
  heading "1. Download current lines"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  slot #ImportOrderLinesValidationContainer (hidden)
  block #ImportOrderLinesExceptionsContainer (hidden)
    slot #ImportOrderLinesExceptionsGrid
  form#StockTransferDropContainerOrder
    heading "Drop files here or click to upload."
  slot #ifrmDownloadNewLinesOrder (hidden)
  form#frmDownloadNewLinesOrder
  form#frmUploadNewLinesOrder
  button "Close"
modal#divScanDialog small
  heading "Scanning"
  button 
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  block #divScanLocation
    slot #tdScanLocation
    label "Location to pick from" for #cmbScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #ScanValidationContainer (hidden)
  block #liScanPackBoxAutomatic (hidden)
    slot #tdScanPackBoxAutomatic
    label "Box #" for #txtScanPackBoxInventory
  input text#txtScanFocus
  block #divScanInfo (hidden)
    heading "Found product:"
    slot #divScanProductSelection (hidden)
    block #liScanPackBox (hidden)
      label "Box #:"
      slot #tdScanPackBox
    label "SKU:"
    block #tdScanProductCode
    label "Name:"
    block #tdScanName
    label "Barcode:"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date:"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity:"
      slot #tdScanQuantity
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    label "Barcodes"
    block #liScanPackBoxInventory (hidden)
      slot #tdScanPackBoxInventory
      label "Box #"
  block #ScanInventoryModeControls (hidden)
    button "Save"#liScanSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Save"#liScanSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
modal#secEmail medium
  heading #emailDialogCaption
  button "×"
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  button #DEAREmailTo_btn
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
    button #DEAREmailCC_btn
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
  heading "Select files to attach"
  block #EmailSendTemplate_AttachedFiles
    heading #headerForOrderAttachments
    slot #attachedFiles
  block #EmailSendTemplate_AttachedFiles_Product
    heading "Product"
    slot #attachedFiles_Product
  block #EmailSendTemplate_AttachedFiles_Supplier
    heading "Supplier"
    slot #attachedFiles_Supplier
  block #EmailSendTemplate_AttachedFiles_Customer
    heading "Customer"
    slot #attachedFiles_Customer
  heading "Email template"
  slot #tdEmail_Body
  block #emailReCaptcha (hidden)
  button "Send"#btnSendEmail primary
  button "Close"#emailBackAction
modal#secRecipients medium
  heading "Select a recipient"
  button "×"
  slot #gridRecipients
  button "OK" primary
  button "Close"
slot #btnSendEmail2
modal#dlgFamilyMatrix medium
  heading "Add a product family"
  button "×"
  slot #FamilyMatrix_cmbFamily
  label "Product family"
  input checkbox#FamilyMatrix_cbOnlyAvailable
  label "Show only available variations" for #FamilyMatrix_cbOnlyAvailable_InputId
  slot #FamilyMatrix_divMessage (hidden)
  block #FamilyMatrix_divOptions (hidden)
    tabs: Matrix | List
    tab pane#FamilyMatrix_divFamilyMatrixTab
      block #FamilyMatrix_divBaseOptionContainer (hidden)
        slot #FamilyMatrix_cmbBaseOption
        label "Select base option:"
        slot #FamilyMatrix_cmbBaseOptionValue
        label "and its value:"
      slot #FamilyMatrix_divMatrixContainer
    tab pane#FamilyMatrix_divFamilyListTab
      slot #FamilyMatrix_divListContainer
  button "Add products"#FamilyMatrix_btnAdd primary
  button "Close"#FamilyMatrix_btnClose
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/StocktransferList`: Stock transfers

Frame: `task-upload-frame`.

```text
link "Home"
heading "Stock transfers"
block #bulkActionsNoteSuccess (hidden)
block #bulkActionsNoteWarning (hidden)
block #bulkActionsNoteError (hidden)
button #divNew primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
slot #StockTransfer_FilterSummary
button "Locations"#btnTransferFilters
block #divStatusFilterContainer
  select#divStatusFilter
button #divRefresh
button #Grid_gridName_Options
block #divBulkActions
  slot #lSelectedCounter
  button "Undo"#btnUndo (hidden)
  button "Void"#btnVoid (hidden)
slot #StocktransferList_Index_Container
modal#Stock_Transfer_Filters_Content small
  heading "Location filters"
  button "×"
  label "From location"
  slot #TransferFilters_FromLocation
  label "From bin"
  slot #TransferFilters_FromBin
  label "To location"
  slot #TransferFilters_ToLocation
  label "To bin"
  slot #TransferFilters_ToBin
  button "Clear all" primary
  button "Apply" primary
  button "Cancel"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `FixedAssetType2019`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FixedAssetType_Index_Container` · store `store` · placeholder `You do not have any fixed asset types at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Depreciation method | `DepreciationMethod` |  | flex 1 | RenderHTMLText |  |
    | Averaging method | `AveragingMethod` |  | flex 1 | RenderHTMLText |  |
    | Rate | `Rate` |  | flex 1 | renderer() |  |
    | Effective life | `EffectiveLife` |  | flex 1 | renderer() |  |
    | Asset account | `AssetAccountName` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Accumulated depreciation account | `AccumulatedDepreciationAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Depreciation expense account | `DepreciationExpenseAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |


#### Menus, buttons and other parts

- **component**
  - *buttons:*
    - **item**

### `GiftCards2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `GiftCards_Index_Container` · store `mainStore` · placeholder `There are no gift cards at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Number | `GiftCardCode` |  | flex 2 | renderer() |  |
    | Sold in | `SaleOrderNumber` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Expiration date | `ExpirationDate` |  | flex 2 | renderer() |  |
    | Amount/balance | `InitialBalance` |  | flex 2 | renderer() |  |
    | Status | `IsBreakeraged` |  | flex 2 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divAllocatedDetailsGridContainer` · store `vAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Document # | `DocNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Date paid | `DatePaid` |  | flex 1 | renderer() |  |
    | Allocated amount | `Amount` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |


### `Product2019`

33 grids · 72 standalone fields · 1 windows · 11 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPBom_Versions` · store `window.VersionsBomTempStore` · placeholder `There are no production BOM versions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Number | `Version` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Created | `CreatedDate` |  | flex 1 | renderer() |  |
    | Default | `IsDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `CustomPrices_Container` · store `CustomPricesGridStore` · placeholder `There are no custom prices at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Customer currency | `CurrencyCode` |  | flex 1 | renderer() |  |
    | Latest price | `LatestPrice` |  | flex 1 | renderer() |  |
    | Custom price | `CustomPrice` | number column | flex 1 | renderer() |  |
    | Last sold | `LatestDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `Markup_Container` · store `MarkupGridStore` · placeholder `There are no price tiers at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Price tier | `TierNumber` |  | flex 1 | renderer() |  |
    | Price | `Price` | number column | 100 | renderer() |  |
    | Calculated | `Calculated` | check column | 100 | renderer() |  |
    | Type | `MarkupType` |  | flex 1 | renderer() |  |
    | Use | `UsePriceType` |  | flex 1 | renderer() |  |
    | Value | `MarkupValue` | number column | 100 | renderer() |  |

- **grid** · renders into `MergeProductGridContainer` · store `selectedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMovementLines` · store `vProductMovementStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From/to | `FromTo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Cost | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMovementQuantityLines` · store `vProductMovementQuantityStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From/To | `FromTo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divMovementQuantityChangesLines` · store `vProductQuantityChangesStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ChangeDate` |  | 135 | renderer() |  |
    | User name | `UserName` |  | flex 1 |  |  |
    | Action | `Action` |  | flex 2 |  |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 2 | renderer() |  |
    | Qty moved | `QtyMoved` |  | 85 | renderer() |  |
    | Available qty in stock | `Available` |  | 100 |  |  |
    | Status | `Status` |  | 75 | renderer() |  |

- **grid** · renders into `divUsageLines` · store `vServiceUsageStore` · placeholder `Service has never been used.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Document number | `Number` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBOMComponents` · placeholder `You do not have any components in BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Wastage % | `WastagePercent` |  | flex 1 |  |  |
    | Wastage quantity | `WastageQuantity` |  | flex 1 |  |  |
    | Disassembly cost % | `CostPercentage` | number column | flex 1 | renderer() | total sum |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divBOMServices` · placeholder `You do not have any labor or overheads in BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor & overheads | `Name` |  | flex 2 | RenderHTMLText | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Price tier | `PriceTier` |  | flex 1 | renderer() |  |
    | Total cost | `Cost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divDiscountLines` · placeholder `You do not have any customer-specific discounts for this product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Customer` |  | flex 1 | RenderHTMLText |  |
    | Customer tag | `CustomerTag` |  | flex 1 | RenderHTMLText · edit: combo |  |
    | Discount | `DiscountName` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divSupplierLines` · placeholder `No suppliers found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Product name | `SupplierProductName` |  | flex 1 | renderer() |  |
    | Product URL | `URL` |  | flex 1 | renderer() |  |
    | Drop ship | `DropShip` | check column | 80 | renderer() |  |
    | Currency | `Currency` |  | flex 1 |  |  |
    | Latest price | `Cost` |  | flex 1 | renderer() |  |
    | Fixed price | `FixedCost` |  | flex 1 | renderer() |  |
    | Last supplied | `SysDate` |  | flex 1 | renderer() |  |
    | Include in pricing Find out about calculated pricing"> | `IncludeInPricing` | check column | 130 | renderer() |  |

- **grid** · renders into `divLocationLines` · placeholder `No locations found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | Reorder quantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Stock locator | `StockLocator` |  | flex 1 | renderer() |  |
    | Pick zones | `PickZones` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAdditionalUnitOfMeasureLines` · placeholder `You do not have any additional units of measure for this product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Unit of measure | `DefaultUnitOfMeasure` |  | flex 1 | renderer() · edit: combo |  |
    | Conversion rate | `ConversionRate` |  | flex 1 | renderer() |  |
    | I am selling this product | `NotSellable` | check column | flex 1 | renderer() |  |
    | Tier 1 | `PriceTear1` |  | flex 1 | renderer() |  |
    | Tier 2 | `PriceTear2` |  | flex 1 | renderer() | hidden |
    | Tier 3 | `PriceTear3` |  | flex 1 | renderer() | hidden |
    | Tier 4 | `PriceTear4` |  | flex 1 | renderer() | hidden |
    | Tier 5 | `PriceTear5` |  | flex 1 | renderer() | hidden |
    | Tier 6 | `PriceTear6` |  | flex 1 | renderer() | hidden |
    | Tier 7 | `PriceTear7` |  | flex 1 | renderer() | hidden |
    | Tier 8 | `PriceTear8` |  | flex 1 | renderer() | hidden |
    | Tier 9 | `PriceTear9` |  | flex 1 | renderer() | hidden |
    | Tier 10 | `PriceTear10` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `Product_Index_Container` · store `mainStore` · placeholder `No products found.`
- **grid** · renders into `CombinedProduct_Index_Container` · store `combinedProductsStore` · placeholder `No products found.`
- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reorder | `` |  | 80 | renderer() |  |
    | No. | `RowOrderNum` |  | 60 | renderer() |  |
    | Mark as default | `isDefault` | check column | 116 | renderer() |  |
    | Img. preview | `ImageID` |  | 100 | renderer() |  |
    | Filename | `FileName` |  | flex 2 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 200 | renderer() |  |
    | Name | `Name` |  | 300 | renderer() |  |
    | Category | `Category` |  | 200 | renderer() |  |
    | Brand | `Brand` |  | 200 | renderer() |  |
    | Type | `Type` |  | 100 | renderer() |  |
    | Costing method | `CostingMethod` |  | 150 | renderer() |  |
    | Length | `Length` |  | 100 | renderer() |  |
    | Width | `Width` |  | 100 | renderer() |  |
    | Height | `Height` |  | 100 | renderer() |  |
    | Dimension units | `DimensionUnits` |  | 100 | renderer() |  |
    | Weight | `Weight` |  | 100 | renderer() |  |
    | Weight units | `WeightUnits` |  | 100 | renderer() |  |
    | Barcode | `Barcode` |  | 150 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | 100 | renderer() |  |
    | Reorder quantity | `ReorderQuantity` |  | 150 | renderer() |  |
    | Default location | `DefaultLocation` |  | 150 | renderer() |  |
    | Last supplied by | `LastSuppliedBy` |  | 200 | renderer() |  |
    | Supplier product code | `SupplierProductCode` |  | 300 | renderer() |  |
    | Supplier product name | `SupplierProductName` |  | 300 | renderer() |  |
    | Price tier 1 | `PriceTier1` |  | 130 | renderer() |  |
    | Price tier 2 | `PriceTier2` |  | 130 | renderer() |  |
    | Price tier 3 | `PriceTier3` |  | 130 | renderer() |  |
    | Price tier 4 | `PriceTier4` |  | 130 | renderer() |  |
    | Price tier 5 | `PriceTier5` |  | 130 | renderer() |  |
    | Price tier 6 | `PriceTier6` |  | 130 | renderer() |  |
    | Price tier 7 | `PriceTier7` |  | 130 | renderer() |  |
    | Price tier 8 | `PriceTier8` |  | 130 | renderer() |  |
    | Price tier 9 | `PriceTier9` |  | 130 | renderer() |  |
    | Price tier 10 | `PriceTier10` |  | 130 | renderer() |  |
    | Assembly BOM | `AssemblyBOM` |  | 200 | renderer() |  |
    | Auto assemble | `AutoAssemble` |  | 200 | renderer() |  |
    | Auto disassemble | `Auto Disassemble` |  | 200 | renderer() |  |
    | Drop ship | `DropShip` |  | 200 | renderer() |  |
    | Average cost | `AverageCost` |  | 130 | renderer() |  |
    | Default unit of measure | `DefaultUnitOfMeasure` |  | 200 | renderer() |  |
    | Inventory account | `InventoryAccount` |  | 200 | renderer() |  |
    | Revenue account | `RevenueAccount` |  | 200 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | 200 | renderer() |  |
    | COGS account | `COGSAccount` |  | 200 | renderer() |  |
    | Product attribute set | `ProductAttributeSet` |  | 200 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 200 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 200 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 200 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 200 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 200 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 200 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 200 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 200 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 200 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 200 | renderer() |  |
    | Discount name | `DiscountName` |  | 200 | renderer() |  |
    | Product family SKU | `ProductFamilySKU` |  | 200 | renderer() |  |
    | Product family option 1 value | `ProductFamilyOption1Value` |  | 200 | renderer() |  |
    | Product family option 2 value | `ProductFamilyOption2Value` |  | 200 | renderer() |  |
    | Product family option 3 value | `ProductFamilyOption3Value` |  | 200 | renderer() |  |
    | Comma-delimited tags | `CommaDelimitedTags` |  | 200 | renderer() |  |
    | Stock locator | `StockLocator` |  | 200 | renderer() |  |
    | Purchase tax rule | `PurchaseTaxRule` |  | 200 | renderer() |  |
    | Sale tax rule | `SaleTaxRule` |  | 200 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Pick zones | `PickZones` |  | 100 | renderer() |  |
    | Always show quantity | `AlwaysShowQuantity` |  | 200 | renderer() |  |
    | Production BOM | `ProductionBOM` |  | 200 | renderer() |  |
    | Quantity to produce | `QuantityToProduce` |  | 200 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 120 | renderer() |  |
    | Product SKU | `ProductSKU` |  | 200 | renderer() |  |
    | Product name | `ProductName` |  | 300 | renderer() |  |
    | Price tier | `PriceTier` |  | 200 | renderer() |  |
    | Type | `MarkupType` |  | 300 | renderer() |  |
    | Use | `UseType` |  | 200 | renderer() |  |
    | Value | `Value` |  | 200 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Old product SKU | `CurrentSKU` |  | 200 | renderer() |  |
    | Product SKU | `NewSKU` |  | 200 | renderer() |  |
    | Product name | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | flex 1 | renderer() |  |
    | Base SKU | `BaseSKU` |  | flex 1 | renderer() |  |
    | Base product name | `BaseProductName` |  | flex 1 | renderer() |  |
    | Base units of measure | `BaseUnitsOfMeasure` |  | flex 1 | renderer() |  |
    | Additional units of measure SKU | `AdditionalUnitsOfMeasureSKU` |  | flex 1 | renderer() |  |
    | Additional units of measure product name | `AdditionalUnitsOfMeasureProductName` |  | flex 1 | renderer() |  |
    | Additional units of measure name | `AdditionalUnitsOfMeasureName` |  | flex 1 | renderer() |  |
    | Number of base units in additional unit | `NumberOfBaseUnitsInAdditionalUnit` |  | flex 1 | renderer() |  |
    | I am selling this product | `IAmSellingThisProduct` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  |  | renderer() |  |
    | Product SKU | `ProductSKU` |  |  | renderer() |  |
    | Product name | `ProductName` |  | flex 1 | renderer() |  |
    | Customer name | `CustomerName` |  | 200 | renderer() |  |
    | Price | `Price` |  |  | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Average cost | `AverageCost` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Batch or serial number | `BatchOrSerialNumber` |  | 200 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | 100 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 150 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Average cost | `AverageCost` |  | 100 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch or serial number | `BatchOrSerialNumber` |  | 200 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | 150 | renderer() |  |

- **grid** · renders into `divAlternativProducts` · placeholder `No alternative products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `AlternativeProductCode` |  | flex 1 | renderer() |  |
    | Interchangeable | `IsInterchangeable` | check column | 150 | renderer() |  |
    |  | `Matching` |  | 150 | renderer() |  |
    | Use in production | `UseInProduction` | check column | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 110 | renderer() |  |

- **grid** · renders into `Stock_Index_Container` · store `stockStore` · placeholder `You do not have any products matching the specified criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `Location` |  | flex 1 | RenderHTMLText |  |
    | Bin | `Bin` |  | flex 1 | RenderHTMLText |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | RenderHTMLText |  |
    | Expiry date | `ExpiryDate` |  | 100 | renderer() |  |
    | Stock value | `StockOnHand` |  | 100 | renderer() |  |
    | On hand | `OnHand` |  | 90 |  |  |
    | Available | `Available` |  | 90 |  |  |
    | On order | `OnOrder` |  | 90 | renderer() |  |
    | In transit | `InTransit` |  | 80 | renderer() |  |
    | Allocated | `Allocated` |  | 90 | renderer() |  |
    | Next delivery | `NextDeliveryDate` |  | flex 1 | Stock_Index_FormatNextDeliveryDate |  |

- **grid** · renders into `AllocatedGrid_Container` · store `vProductsStockAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task no. | `Number` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |

- **grid** · renders into `OnOrderGrid_Container` · store `vProductsStockOnOrderStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |

- **grid** · renders into `InTransitGrid_Container` · store `vProductsStockInTransitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 150 | RenderHTMLText |  |
    | Product SKU | `ProductSKU` |  | 250 | renderer() |  |
    | URL | `ImageUrl` |  | 600 | renderer() |  |
    | File name | `ImageFileName` |  | 400 | renderer() |  |

- **grid** · renders into `divLeadSafetyLines` · store `vProductLeadSafetyPagedStore` · placeholder `No suppliers found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  (group: Supplier, Lead, Safety, Reorder quantity, Minimum order quantity) | `` |  |  |  |  |
    | Location set up (group: Location, Lead, Safety, Reorder quantity, ) | `` |  |  |  |  |

- **grid** · renders into `"divMTOProductMapGrid-".concat(…)` · store `item.vMakeToOrderBOMProductMaps(…)` · placeholder `Please add at least one choice, product family or custom element item…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Choice | `MenuConfigurationID` |  | flex 1 | renderer() |  |
    | Product | `MappedProductCode` |  | flex 1 | renderer() |  |
    | Unit | `MappedProductUnit` |  | 100 | renderer() |  |

- **grid** · renders into `divMakeToOrderConditionsGrid` · store `vMakeToOrderConditionsStore` · placeholder `There are no conditions added.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Condition item | `RelatedMenuConfigurationID` |  | flex 1 | renderer() |  |
    | Condition | `Condition` |  | flex 1 | renderer() |  |


#### Windows and dialogs

- **window** “Add a new product category” · layout fit

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `cmbPBomVersion` | `PBomVersionStore` | shows `DisplayName` · value `BomID` · pick-only |
| number field |  | `liOutputQuantity` | `` |  |
| text field |  | `Product_Index_ProductionInstructionURL` | `` |  |
| number field |  | `liManufacturingBufferTime` | `` |  |
| combo |  | `liManufacturingDeliveryTo` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| checkbox |  | `liIgnoreCumulativeLeadTime` | `` |  |
| checkbox |  | `divProductTracing` | `` |  |
| number field |  | `liComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_ProductionIssueMethod` | `IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmb_BackflushDefinedFor` | `BackflushDefinedForStore` | shows `name` · value `value` · pick-only |
| number field |  | `liManufacturingMinQuantity` | `` |  |
| number field |  | `liManufacturingMaxQuantity` | `` |  |
| number field |  | `liManufacturingDeviationPercent` | `` |  |
| number field |  | `liManufacturingRunSize` | `` |  |
| combo |  | `cmbFinishedProductCost` | `CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| combo |  | `Product_Index_BulkComponentUpdateInBOMs_OldCompon…` | `vProductListBOMOldComponentStore` | shows `CodeWithName` · value `ProductID` · placeholder `Select old component` |
| combo |  | `Product_Index_BulkComponentUpdateInBOMs_NewCompon…` | `vProductListBOMNewComponentStore` | shows `CodeWithName` · value `ProductID` · placeholder `Select new component` |
| combo |  | `Product_Channels_PublishingProfiles` | `vPublishingProfileStore` | shows `Name` · value `Id` · pick-only |
| combo |  | `Product_Index_Type` | `ProductTypeStore` | shows `name` · value `value` · pick-only |
| combo (+ add new) |  | `Product_Index_FixedAssetType` | `vProductFixedAssetTypeStore` | shows `Name` · value `FixedAssetTypeID` |
| combo (+ add new) |  | `Product_Index_Category` | `vTenantInventoryCategoryStore` | shows `Category` · value `CategoryID` |
| combo (+ add new) |  | `Product_Index_Brand` | `vTenantBrandStore` | shows `Brand` · value `ID` |
| combo (+ add new) |  | `Product_Index_DefaultUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `Product_Index_DropShipMode` | `DropShipModeStore` | shows `DisplayName` · value `DropShipMode` · pick-only |
| combo |  | `Product_Index_BillOfMaterial` | `BomTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `Product_Index_InventoryAccount` | `InventoryAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_RevenueAccount` | `RevenueAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_ExpenseAccount` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_COGSAccount` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_PurchaseTaxRule` | `PurchaseTaxRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `Product_Index_SaleTaxRule` | `SaleTaxRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `Product_Index_Discount` | `vDiscountStore` | shows `Name` · value `ID` |
| combo |  | `Product_Index_WarrantySetup` | `vWarrantySetupStore` | shows `Name` · value `ID` |
| combo |  | `Product_Index_CountryOfOrigin` | `vCountryOfOriginStore` | shows `Name` · value `Code` · placeholder `Not defined` |
| combo |  | `Product_Index_Status` | `StatusStore` | shows `Name` · value `Value` · pick-only |
| combo (+ add new) |  | `Product_Index_DefaultLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` |
| combo |  | `Product_Index_ProductAttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| combo |  | `Product_Index_NotSellable` | `NotSellableTypesStore` | shows `name` · value `value` |
| text field |  | `Product_Index_AssemblyInstructionURL` | `` |  |
| checkbox |  | `liAutoAssembly` | `` |  |
| checkbox |  | `liAutoDisassembly` | `` |  |
| combo |  | `liCostType` | `window.CostTypeStore` | shows `CostTypeName` · value `CostType` · pick-only |
| number field |  | `liQuantityToProduce` | `` |  |
| combo |  | `divMovementType` | `MovementTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `divMovementChanel` | `MovementChanelStore` | shows `name` · value `value` · pick-only |
| combo |  | `divMovementAction` | `MovementActionStore` | shows `name` · value `value` · pick-only |
| combo |  | `divNewProduct_AdditionalUnitOfMeasureUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `Product_Index_WeightUnits` | `MeasurementWeightStore` | shows `UoMName` · value `UoMAbbr` · pick-only |
| combo |  | `Product_Index_DimensionUnits` | `MeasurementDimensionsStore` | shows `UoMName` · value `UoMAbbr` · pick-only |
| combo |  | `AdditionalDescriptionsSelect` | `pProductAdditionalDescriptionsStore` | shows `ShopName` · value `SIMProductID` · pick-only |
| text field |  | `tdProduct_NewFixedAssetType_Category` | `` |  |
| date field |  | `"dtSupplyIntervalDate".concat(…)` | `` | placeholder `Select date` · format `UserDateFormat` |
| date field |  | `divCostingMethodModal_ExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| number field |  | `liMakeToOrderOutputQuantity` | `` |  |
| text field |  | `Product_Index_MakeToOrderInstructionURL` | `` |  |
| number field |  | `liMakeToOrderManufacturingBufferTime` | `` |  |
| checkbox |  | `liMakeToOrderIgnoreCumulativeLeadTime` | `` |  |
| combo |  | `liMakeToOrderManufacturingDeliveryTo` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| number field |  | `liMakeToOrderComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_MakeToOrderIssueMethod` | `window.IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbMakeToOrderFinishedProductCost` | `window.CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbMakeToOrderCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| combo |  | `"divMTOConfigTemplate-".concat(…)` | `vMakeToOrderConfigTemplatesStore` | shows `TemplateName` · value `TemplateID` · pick-only |
| combo |  | `"divMTOConfigMenuItem-".concat(…)` | `vMakeToOrderConfigMenuItemsStore` | shows `Name` · value `MenuConfigurationID` · pick-only |
| combo |  | `divId` | `window[optionStoreName]` | shows `Name` · value `MenuConfigurationID` · pick-only |
| combo |  | `divMakeToOrderConditionalVisibility` | `vMakeToOrderVisibilityOptionsStore` | shows `Label` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `divMakeToOrderJoinCondition` | `vMakeToOrderJoinConditionsStore` | shows `Label` · value `Value` · placeholder `Choose...` · pick-only |

#### Menus, buttons and other parts

- **column** · placeholder `You do not have any components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Component | `Value` |  | flex 1 | renderer() |  |
    |  | `CostCalculationType` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Wastage % | `WastagePercent` |  | flex 1 | renderer() |  |
    |  | `WastageQty` |  | flex 1 | renderer() |  |
    | Sales price | `SalePriceTier` |  | flex 1 | renderer() |  |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 75 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | 75 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | flex 1 | renderer() | hidden |
    | Cycle time | `CycleTimeString` |  | 90 | renderer() |  |
    | Units per cycle | `UnitsPerCycle` |  | flex 1 | renderer() |  |
    | Work center | `WorkCenterID` |  | flex 1 | renderer() |  |
    |  | `IsDropShip` | check column | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |
    | Delivery to | `DeliveryTo` |  | flex 1 | renderer() |  |

- **column** · store `WastageProductsStore` · placeholder `You do not have any finished products or input/output components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Fixed price | `WastageCost` | number column | flex 1 | renderer() |  |
    | Cost per unit | `WastageCost` | number column | flex 1 | renderer() |  |

- **MovementTypeModel** · name `Show availability changes`
- **MovementTypeModel** · name `Show quantity movements`
- **MovementTypeModel** · name `Show quantity and cost movements`
- **form** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |
    | Delivery to | `DeliveryTo` |  | flex 1 | renderer() |  |


### `ProductFamily2019`

8 grids · 48 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Image order | `RowOrderNum` |  | flex 1 | renderer() |  |
    | Name | `FileName` |  | flex 1 | renderer() |  |
    | Default | `isDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `tdOption1Values` · store `StoreOption1Values`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Option 1 values | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `tdOption2Values` · store `StoreOption2Values`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Option 2 values | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `tdOption3Values` · store `StoreOption3Values`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Option 3 values | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `tdVariationDims` · placeholder `You do not have any variants in the family.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Weight | `Weight` |  | 120 | RenderHTMLText |  |
    | Weight units | `WeightUnits` |  | flex 1 | renderer() |  |
    | Width | `Width` |  | 120 | RenderHTMLText |  |
    | Height | `Height` |  | 120 | RenderHTMLText |  |
    | Length | `Length` |  | 120 | RenderHTMLText |  |
    | Dimension units | `DimensionsUnits` |  | flex 1 | renderer() |  |

- **grid** · renders into `tdVariations` · placeholder `You do not have any variants in the family.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Option 1 value | `Option1` |  | flex 1 | RenderHTMLText |  |
    | Option 2 value | `Option2` |  | flex 1 | RenderHTMLText |  |
    | Option 3 value | `Option3` |  | flex 1 | RenderHTMLText |  |
    | Price tier 1 | `PriceTear1` |  | flex 1 | renderer() |  |
    | Price tier 2 | `PriceTear2` |  | flex 1 | renderer() |  |
    | Price tier 3 | `PriceTear3` |  | flex 1 | renderer() |  |
    | Price tier 4 | `PriceTear4` |  | flex 1 | renderer() |  |
    | Price tier 5 | `PriceTear5` |  | flex 1 | renderer() |  |
    | Price tier 6 | `PriceTear6` |  | flex 1 | renderer() |  |
    | Price tier 7 | `PriceTear7` |  | flex 1 | renderer() |  |
    | Price tier 8 | `PriceTear8` |  | flex 1 | renderer() |  |
    | Price tier 9 | `PriceTear9` |  | flex 1 | renderer() |  |
    | Price tier 10 | `PriceTear10` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 150 | RenderHTMLText |  |
    | Product SKU | `ProductSKU` |  | 250 | renderer() |  |
    | URL | `ImageUrl` |  | 600 | renderer() |  |
    | File name | `ImageFileName` |  | 400 | renderer() |  |

- **grid** · renders into `divUsedInProductsData` · placeholder `You do not have any generated production BOMs for variations of the p…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductId` |  | flex 2 | renderer() |  |
    | Production BOM generated. | `HasFamilyDerivedBom` |  | flex 1 | renderer() |  |
    | Used as default version | `IsFamilyDerivedBomDefault` |  | flex 1 | renderer() |  |
    | Mapping is finished | `IsMapped` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `tdSKU` | `` |  |
| text field |  | `tdName` | `` |  |
| combo (+ add new) |  | `tdCategory` | `vTenantInventoryCategoryStore` | shows `Category` · value `CategoryID` |
| combo (+ add new) |  | `tdBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` |
| combo |  | `tdCostingMethod` | `CostingMethodStore` | shows `DisplayName` · value `CostingMethod` |
| combo |  | `tdDropShipMode` | `DropShipModeStore` | shows `DisplayName` · value `DropShipMode` · pick-only |
| combo |  | `tdDropShipSupplier` | `DropShipSupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo |  | `tdLastSupplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| numeric field |  | `tdSupplierPrice` | `` |  |
| text field |  | `tdOption1Name` | `` |  |
| text field |  | `tdOption2Name` | `` |  |
| text field |  | `tdOption3Name` | `` |  |
| combo (+ add new) |  | `tdUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `tdInventoryAccount` | `InventoryAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `tdRevenueAccount` | `RevenueAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `tdCOGSAccount` | `COGSAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `tdPurchaseTaxRule` | `PurchaseTaxRuleStore` | shows `Description` · value `RuleID` · pick-only |
| combo |  | `tdSaleTaxRule` | `SaleTaxRuleStore` | shows `Description` · value `RuleID` |
| combo (+ add new) |  | `tdDefaultLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` |
| combo |  | `divCountryOfOrigin` | `vCountryOfOriginStore` | shows `Name` · value `Code` · placeholder `Not defined` |
| combo |  | `tdAttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| number field |  | `tdMinimumBeforeReorder` | `` |  |
| number field |  | `tdReorderQuantity` | `` |  |
| numeric field |  | `tdPriceTier1` | `` |  |
| numeric field |  | `tdPriceTier2` | `` |  |
| numeric field |  | `tdPriceTier3` | `` |  |
| numeric field |  | `tdPriceTier4` | `` |  |
| numeric field |  | `tdPriceTier5` | `` |  |
| numeric field |  | `tdPriceTier6` | `` |  |
| numeric field |  | `tdPriceTier7` | `` |  |
| numeric field |  | `tdPriceTier8` | `` |  |
| numeric field |  | `tdPriceTier9` | `` |  |
| numeric field |  | `tdPriceTier10` | `` |  |
| combo |  | `tdDiscount` | `vDiscountStore` | shows `Name` · value `ID` |
| combo |  | `tdBOM` | `vBOMStore` | shows `name` · value `value` · pick-only |
| combo |  | `tdWarrantySetup` | `vWarrantySetupStore` | shows `Name` · value `ID` |
| number field |  | `liOutputQuantity` | `` |  |
| text field |  | `ProductFamily_Index_ProductionInstructionURL` | `` |  |
| number field |  | `liManufacturingBufferTime` | `` |  |
| checkbox |  | `liIgnoreCumulativeLeadTime` | `` |  |
| number field |  | `liComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_ProductionIssueMethod` | `IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbFinishedProductCost` | `CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** · renders into `tdAdditionalAttributes` · store `StoreProductsAttributes` · placeholder `You do not have any variants in the family.`
- **column** · placeholder `You do not have any components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | 150 | renderer() |  |
    | Component | `Value` |  | flex 1 | renderer() |  |
    |  | `CostCalculationType` |  | 150 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | 100 | renderer() |  |
    | Wastage % | `WastagePercent` |  | 100 | renderer() |  |
    |  | `WastageQty` |  | 100 | renderer() |  |
    | Sales price | `SalePriceTier` |  | 120 | renderer() |  |
    | Cost per unit | `Cost` |  | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | 100 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 100 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | 150 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Cycle time | `CycleTimeString` |  |  | renderer() |  |
    | Units per cycle | `UnitsPerCycle` |  |  | renderer() |  |
    | Work center | `WorkCenterID` |  |  | renderer() |  |
    |  | `IsDropShip` | check column | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | 100 | renderer() |  |

- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |

- **column** · store `WastageProductsStore` · placeholder `You do not have any finished products or input/output components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Fixed price | `WastageCost` | number column | flex 1 | renderer() |  |
    | Cost per unit | `WastageCost` | number column | flex 1 | renderer() |  |

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `ProductFamilyList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ProductFamilyList_Index_Container` · store `mainStore` · placeholder `You do not have any product families at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ImageID` |  | 60 | renderer() |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Family name | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Brand | `Brand` |  | flex 1 | renderer() |  |
    | Products in the family | `ProductCount` |  | 150 |  |  |
    |  | `` |  | flex 1 | renderer() | hidden |


### `RecallReport2019`

4 grids · 2 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divOnHandLines` · store `pRecallOnHandStore` · placeholder `No products to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | On hand | `OnHand` |  | flex 1 |  |  |
    | Allocated | `Allocated` |  | flex 1 |  |  |
    | In transit | `InTransit` |  | flex 1 |  |  |
    | In WIP | `InWIP` |  | flex 1 |  |  |

- **grid** · renders into `divSupplierLines` · store `pRecallSuppliersStore` · placeholder `No suppliers to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `Supplier` |  | flex 2 | renderer() |  |
    | Phone | `Phone` |  | flex 1 | renderer() |  |
    | Email | `Email` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divCustomerLines` · store `pRecallCustomersStore` · placeholder `No customers to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Customer` |  | flex 2 | renderer() |  |
    | Phone | `Phone` |  | flex 1 | renderer() |  |
    | Email | `Email` |  | flex 1 | renderer() |  |
    | Address line 1 | `CustomerAddressLine1` |  | flex 2 | renderer() |  |
    | Address line 2 | `CustomerAddressLine2` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | SKU | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divUsedInLines` · store `pRecallUsedInStore` · placeholder `No products to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task | `TaskID` |  | flex 2 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| checkbox |  | `divShowRelated` | `` |  |
| combo |  | `tdProduct` | `vProductStore` | shows `Name` · value `CardID` · placeholder `Choose...` |

#### Menus, buttons and other parts

- **button** “{Name}” · id `"Print".concat(…)` · on click `handler()`

### `Stock2019`

6 grids · 0 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRemaining` · placeholder `Click the 'Add more items' button to add a new adjustment`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | On hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Available | `Available` |  | flex 1 |  |  |
    | New quantity | `Adjustment` |  | flex 1 |  |  |
    | Variance | `Adjustment` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divNoStock` · placeholder `Click the 'Add more items' button to add a new adjustment to zero sto…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |

- **grid** · renders into `Stock_Index_Container` · store `mainStore` · placeholder `You do not have any products matching the specified criteria.`
- **grid** · renders into `AllocatedGrid_Container` · store `vProductsStockAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task no. | `Number` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `OnOrderGrid_Container` · store `vProductsStockOnOrderStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `InTransitGrid_Container` · store `vProductsStockInTransitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |


#### Menus, buttons and other parts

- **column** “{_renderHeader(…)}” · field `InventoroWin` · itemId `id` · id `id`
- **column** “{_renderHeader(…)}” · field `InventoroStockout` · itemId `id` · id `id`

### `StockAdjustment2019`

7 grids · 7 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `StockAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divRemaining` · placeholder `Click the 'Add more items' button to add a new adjustment`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | On hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Available | `Available` |  | flex 1 |  |  |
    | New quantity | `Adjustment` |  | flex 1 |  |  |
    | Variance | `Adjustment` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divNoStock` · placeholder `Click the 'Add more items' button to add a new adjustment to zero sto…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `ImportLinesExceptionsGrid` · store `UploadLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Line type | `LineType` |  | 80 | renderer() |  |
    | Location | `Location` |  | 120 | renderer() |  |
    | SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Bin | `Bin` |  | 100 | renderer() |  |
    | Batch S/N | `BatchSerialNumber` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 120 | renderer() |  |
    | Unit cost | `UnitCost` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 120 | renderer() |  |
    | Comments | `Comments` |  | 120 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `tdEffectiveDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdCustomerReference` | `` |  |
| combo |  | `liCostType` | `window.CostTypeStore` | shows `CostTypeName` · value `CostType` · pick-only |
| combo |  | `tdScanLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `tdAccount` · store `AccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **text area** · renders into `tdComment` · placeholder `Write your comment here...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `StockAdjustmentList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `StockAdjustmentContainer` · store `parentStore` · placeholder `You do not have any stock adjustments and stocktakes.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Number | `StocktakeNumber` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | 150 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `LastUpdatedDate` | date column | 120 | renderer() |  |
    | Status | `Status` |  | 120 |  |  |
    | Created by | `LastUpdatedBy` |  | flex 1 | renderer() |  |
    | Reference | `CustomerReference` |  | flex 1 | renderer() |  |


### `StockTransfer2019`

11 grids · 12 standalone fields · 0 windows · 17 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `StockAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `StockTransfer_Index_Content` · placeholder `You do not have any products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitName` |  | flex 1 | RenderHTMLText |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | On hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Available | `QuantityAvailable` |  | flex 1 |  |  |
    | Transfer quantity | `TransferQuantity` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `Enter manual journals to distribute additional costs associated with …`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ID` |  | flex 1 | renderer() | hidden |
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created for this stock transfer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | RenderHTMLText |  |
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | DEARMoneyFormat |  |

- **grid** · renders into `ImportLinesExceptionsGrid` · store `UploadLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch S/N | `BatchSerialNumber` |  | 100 | renderer() |  |
    | Transfer quantity | `TransferQuantity` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 120 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Comments | `Comments` |  | 120 | renderer() |  |

- **grid** · renders into `StockTransfer_PutAway_Content` · placeholder `You do not have any products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitName` |  | flex 1 | RenderHTMLText |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Received quantity | `ReceivedQuantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |

- **grid** · renders into `StockTransfer_Order_Content` · placeholder `You do not have any order products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Unit | `UnitName` |  | flex 1 | RenderHTMLText |  |
    | On hand | `OnHandQuantity` |  | flex 1 | renderer() |  |
    | Available | `AvailableQuantity` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `ImportOrderLinesExceptionsGrid` · store `UploadOrderLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 120 | renderer() |  |
    | Comments | `Comments` |  | 120 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCostLines` · placeholder `Enter manual journals to distribute additional costs associated with …`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Product total | `Total` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `tdFrom` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdTo` | `vTenantLocationSecondStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `tdCustomerReference` | `` |  |
| date field |  | `tdDepartureDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdRequiredBy` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| checkbox |  | `chkSkipOrder` | `` |  |
| checkbox |  | `chkUsePutAway` | `` |  |
| combo |  | `tdCostDistributionType` | `CostDistributionTypeStore` | shows `Name` · value `Value` · pick-only |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **text area** · renders into `tdComment` · placeholder `Write your comment here...`
- **component** · renders into `tdAccount` · store `AssetAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `Stocktake2019`

8 grids · 14 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `StockAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divRemaining` · store `storeExisting` · placeholder `Click start to view existing stock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity on hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Stocktake quantity | `Adjustment` |  | flex 1 |  |  |
    | Variance | `Adjustment` |  | flex 1 | renderer() |  |

- **grid** · renders into `divNoStock` · placeholder `No products added to new stock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName | total count |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `ImportExceptionsGrid` · store `ImportErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | flex 1 |  |  |
    | Product code | `ProductCode` |  | flex 1 | renderer() |  |
    | Product name | `ProductName` |  | flex 2 | renderer() |  |
    | Bin | `Bin` |  | flex 1 | renderer() |  |
    | Batch S/N | `BatchSN` |  | flex 1 | renderer() |  |
    | Quantity on hand | `QuantityOnHand` |  | flex 1 | renderer() |  |
    | Stocktake quantity | `StocktakeQuantity` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | flex 1 | renderer() |  |

- **grid** · renders into `ImportLinesExceptionsGrid` · store `UploadLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | flex 1 |  |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Product name | `Name` |  | flex 2 | renderer() |  |
    | Bin | `Bin` |  | flex 1 | renderer() |  |
    | Batch S/N | `BatchSerialNumber` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit cost | `UnitCost` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductSelection` · store `storeSearchResult`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `tdEffectiveDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdCustomerReference` | `` |  |
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| checkbox |  | `tdIncludeQuantityOnHand` | `` |  |
| combo |  | `Stocktake_New_Categories` | `ProductFiltersCategoriesStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_Brands` | `ProductFiltersBrandsStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_Tags` | `ProductFiltersTagsStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| combo |  | `Stocktake_New_Bins` | `ProductFiltersBinsStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_BinGroups` | `ProductFiltersBinGroupsStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_StockLocators` | `ProductFiltersStockLocatorsStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| combo |  | `Stocktake_New_PickZones` | `ProductFiltersPickZonesStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| text field |  | `tdBatchSN` | `` | placeholder `write...` |
| date field |  | `tdExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `tdAccount` · store `AccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **text area** · renders into `tdComment` · placeholder `Write your comment here...`
- **component** · renders into `tdQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

