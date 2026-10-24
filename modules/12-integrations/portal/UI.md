# Portal: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Portal` | Portal | [`Portal2019`](#portal2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Portal`: Portal

Frame: `task-upload-frame`.

```text
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
block #page-container
  block #portal-overview-left-menu
    button "All portals"
  block #portal-setup-left-menu (hidden)
    button "General"#SetupTabButton
    button "Appearance"
    button "Navigation"#NavigationTabButton
    button "Content pages"#ContentPagesButton
    button "Email templates"
    button "Catalog"
    button "Price lists"
    button "Invitations"
    button "Sales"
    button "Abandoned carts"
  block #tab-overview-content
    slot #FeatureModuleDetailsBlock (hidden)
    block #overview-content-block (hidden)
      heading "All portals"#overview-portal-name
      block #overview-base-portal-settings (hidden)
        slot #overview-portal-logo
        text "Name"
        slot #overview-base-portal-settings-name
        text "Allow backorder"
        slot #overview-base-portal-settings-allow-backorder
        text "Create sale as"
        slot #overview-base-portal-settings-create-sale-as
      block #overview-sales-summary-portlet (hidden)
        heading "Summary"
        button "Refresh"#divRefreshSalesSummary
        slot #overview-sales-summary
      tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers | Abandoned carts #overview-tab-abandonedcarts
      tab pane#overview-tab-sales
        slot #OverviewSalesGrid
      tab pane#overview-tab-customers
        slot #OverviewCustomersGrid
      tab pane#overview-tab-abandonedcarts
        slot #OverviewAbandonedCartsGrid
  block #tab-portal-settings (hidden)
    heading "General"#formCaption
    button "Save" primary
    block #divGeneral
      input text#B2B_Index_PortalName placeholder "Portal name"
      label "Portal name"
      label "Active" for #B2B_Index_IsActive
      input checkbox#B2B_Index_IsActive
      heading "Your store URL"
      slot #B2B_Index_URL
      link "Configure custom domain name"
      button "Change domain"#ChangeDomainButton primary
    heading "General settings"
    label "Portal type"
    slot #B2B_Index_PortalType
    label "Portal contacts"
    slot #B2B_Index_Contacts
    label "Portal address"
    slot #B2B_Index_Address
    label "Portal location"
    slot #B2B_Index_Location
    label "Sales representative"
    input text#B2B_Index_SalesRepresentative placeholder "Sales representative"
    label "Create sale as"
    slot #B2B_Index_CreateSaleAs
    label "Invoice template"
    slot #tdInvoiceTemplate
    label "Default revenue account"
    slot #tdDefaultRevenue
    label "Show available quantity"
    slot #tdShowAvailableQuantity
    label "Family price format"
    slot #tdFamilyPriceFormat
    label "Products list layout"
    slot #tdProductListLayout
    label "Price list template"
    slot #tdPriceListTemplate
    label "Price tier for guest user"
    slot #tdPriceTierForGuestUser
    label "Google Analytics Tracker ID"
    input text#B2B_Index_GoogleAnalyticsTrackerID placeholder "Google Analytics Tracker ID"
    label "Tag name for NEW products"
    slot #B2B_Index_TagNameForMarkedNewProduct
    label "Google Analytics 4 Measurement ID"
    input text#B2B_Index_GoogleAnalytics4TrackerID placeholder "Google Analytics 4 Measurement ID"
    label "Use HubSpot tracking"
    block #B2B_Index_UseHubSpotTracking_Wrapper
      input checkbox#B2B_Index_UseHubSpotTracking
      block #B2B_Index_HubSpotID_Label
      block #B2B_Index_HubSpotID_Wrapper
        input text#B2B_Index_HubSpotID
    label "Shipping service"
    select#tdShippingService
    label "Minimum order amount"
    input text#B2B_Index_MinimumOrderAmount
    label "Maximum order amount"
    input text#B2B_Index_MaximumOrderAmount
    label "Price tier for RRP"
    slot #tdRRPPriceTier
    label "On all orders page"
    block #OnAllOrdersPageField
      input radio#B2B_Index_ShowAllCustomerOrders_true name=B2B_Index_ShowAllCustomerOrders
      label "All orders" for #B2B_Index_ShowAllCustomerOrders_true
      input radio#B2B_Index_ShowAllCustomerOrders_false name=B2B_Index_ShowAllCustomerOrders
      label "B2B orders" for #B2B_Index_ShowAllCustomerOrders_false
    label "Show extra parameters"
    select#tdShowExtraParameters: Show in a separate tab | Show under SKU | Do not show
    heading "Advanced settings"
    label "Allow backorder"
    input checkbox#B2B_Index_AllowBackorder
    label "Show 'Out of stock' items"
    input checkbox#B2B_Index_ShowOutOfStockItems
    label "Show product images in shopping cart"
    input checkbox#B2B_Index_ShowImagesInShoppingCart
    label "Show delivery preference"
    input checkbox#B2B_Index_ShowSingleMultipleDeliveryOptions
    label "Include available quantity in price list"
    input checkbox#tdIncludeAvailableQuantities
    label "Show price before discount"
    input checkbox#tdShowNotDiscountedPrice
    label "Allow guest access"
    input checkbox#tdAllowGuestAccess
    label "Require attachment for order confirmation"
    input checkbox#tdIsAttachmentMandatory
    label "Show tax percentages"
    input checkbox#tdShowTaxPercents
    label "Show tax method"
    input checkbox#tdShowTaxMethod
    label "Show potential deal information in shopping cart page"
    input checkbox#B2B_Index_ShowDealInformation
    label "Allow customer to create new order when on credit hold"
    input checkbox#B2B_Index_AllowCreateOrderWhenCreditHold
    label "Show minimum order quantity for products"
    input checkbox#B2B_Index_ShowMinimumOrderQuantityForProducts
    label "Show maximum order quantity for products"
    input checkbox#B2B_Index_ShowMaximumOrderQuantityForProducts
    label "Show additional attributes"
    input checkbox#B2B_Index_ShowAdditionalAttributes
    label "Hide images in product list"
    input checkbox#tdHideImagesInProductList
    label "Show product family as separate products"
    input checkbox#tdShowSeparateProductsForFamily
    label "Family products view"
    slot #tdFamilyProductsView
    label "Show only B2B attachments"
    input checkbox#tdAttachmentDisplayMode
    heading "Follow us"
    label "Facebook"
    input text#B2B_Index_SocialNetworksFacebook
    label "Google+"
    input text#B2B_Index_SocialNetworksGooglePlus
    label "Twitter"
    input text#B2B_Index_SocialNetworksTwitter
    label "Instagram"
    input text#B2B_Index_SocialNetworksInstagram
    label "YouTube"
    input text#B2B_Index_SocialNetworksYouTube
    label "LinkedIn"
    input text#B2B_Index_SocialNetworksLinkedIn
    heading "Sorting options for products on B2B portal"
    button #divNewSortingOption primary
    slot #SortingOptionsGrid
    heading "Shipping methods"
    button #divNewShippingMethodItem primary
    button "Add all existing carriers"#divAddCarriers
    label "Show shipping costs" for #chkHideShippingCost
    input checkbox#chkHideShippingCost
    slot #shippingMethodsGrid
    heading "Payment methods"
    button #divNewPaymentMethodItem primary
    slot #paymentMethodsGrid
    form#sslform
      heading "Custom domain for portal"
      slot #B2B_Index_PortalCustomDomainStatusBadge (hidden)
      block #customDomainSettings
        label "Connect a custom domain to your portal so customers can access it at your own URL"
        block #B2B_Index_PortalCustomDomainFormControl
          input text#fakedusername name=fakeusernameremembered (hidden)
          input password#fakedpassword name=fakepasswordremembered (hidden)
          input text#B2B_Index_PortalCustomDomainName name=DomainName placeholder "Example: shop.yourcompany.com"
          label "Custom domain (URL)"
        block #B2B_Index_PortalCustomDomainError (hidden)
      block #B2B_Index_PortalCustomDomainDnsBlock (hidden)
        button "Refresh"#refresh-cdn-button primary
        text "Add the following TXT and CNAME records at your DNS provider to activate your custom domain. The TXT value will populate"
        table: Type | Name / Host | Value
      block #B2B_Index_PortalCustomDomainLegacyBlock (hidden)
        text "Reconnect your custom domain To keep your custom domain working, you need to reconnect it to our new system. This takes "
      text "Set custom domain"#set-cdn-button
      text "Remove custom domain"#remove-cdn-button (hidden)
    block #rmaSection (hidden)
      heading "RMA module"
      label "Enabled product return form"
      input checkbox#B2B_Index_EnabledProductReturn
      label "Return delivery location is"
      slot #B2B_Index_ReturnDeliveryLocation
      label "Link to return portal:"
      label ""
    heading "Abandoned carts settings on B2B portal"
    label "Enable abandoned carts"
    input checkbox#B2B_Index_EnableAbandonedCarts
    label "Time to consider cart as abandoned*"
    slot #divAbandonedCartTimeValue
    slot #B2B_Index_AbandonedCartTimeUnit
    block #b2b-disconnect-area
      heading "Disconnect from your store"
      button "Remove store"#remove-store-button
      form#frmDisconnect
  block #tab-portal-appearance (hidden)
    heading "Appearance"#formCaption
    button "Preview portal"#PriviewPortalButton
    button "Save" primary
    heading "Logo"
    form#frmUploadLogo
      slot #B2B_Index_Logo
    heading "Shopping cart custom image"
    button "Restore default"#button-ResetCartImage
    form#frmUploadCartImage
      slot #B2B_Index_CartImage
    heading "Header area"
    text "A range of parameters to customize B2B portal header colors."
    input text#cpHeaderBackground
    label "Header background"
    input text#cpNavigationTextHover
    label "Navigation text hover"
    input text#cpNavigationText
    label "Navigation text"
    input text#cpContactsTextColor
    label "Contacts text color"
    heading "Content area"
    text "A range of parameters to customize B2B portal content colors."
    input text#cpPageBackground
    label "Page background"
    input text#cpCategoryText
    label "Category text"
    input text#cpPreHeaderBackgroundColor
    label "Pre-header background color"
    input text#cpSloganBackgroundColor
    label "Slogan background color"
    input text#cpTitleTextColor
    label "Title text color"
    input text#cpPreFooterBackgroundColor
    label "Pre-footer background"
    input text#cpContentColor
    label "Content color"
    input text#cpPreFooterTextColor
    label "Pre-footer text color"
    input text#cpPriceColor
    label "Price color"
    input text#cpOutOfStockColor
    label "Out of stock text color"
    input text#cpContentLinkColor
    label "Content link color"
    input text#cpInStockColor
    label "In stock text color"
    input text#cpButtonsColor
    label "Buttons color"
    input text#cpTableHeaderBackgroundColor
    label "Table header background (product family grids)"
    input text#cpButtonsBackgroundColor
    label "Buttons background color"
    input text#cpTableHeaderColor
    label "Table header text color (product family grids)"
    input text#cpCategoryTextBackground
    label "Category text background"
    heading "Footer area"
    text "A range of parameters to customize B2B portal footer colors."
    input text#cpFooterBackgroundColor
    label "Footer background"
    input text#cpFooterTextColor
    label "Footer text color"
    input text#cpFooterLinkColor
    label "Footer link color"
    heading "Custom menu area"
    text "A range of parameters to customize B2B custom menu colors."
    table#B2B_Appearance_CustomMenuTable: Menu level | Background | Text | Hover | Title
    button "Restore all colors"
    block #b2bHtmlPageEditorDivs
      heading "Slogan"
      slot #b2bHtmlSlogan
    block #b2bHtmlPageEditorDivsLogInInfo
      heading "Log in information"
      slot #b2bHtmlLogInInfo
  block #tab-portal-navigations (hidden)
    heading "Custom menu"#formCaption
    button "Save" primary
    heading "Horizontal navigation bar"
    slot #B2B_Index_HorizontalNavbarDataType
    block #horizontalNavbarItems
      button "Add menu items"#divNewItemsHorizontal primary
      button "Preview"#customMenuPreviewButton primary (hidden)
      slot #horizontalNavbarItemsGrid
      slot #horizontalCustomMenu
      block #blockMenuCount (hidden)
        label "Max. item number per column"
        input text#B2B_Index_MenuCount
    heading "Vertical widget area"
    slot #B2B_Index_VerticalNavbarDataType
    block #verticalNavbarItems
      text "Brands"
      text "Sort"#btnSortBrands
      label "Show brands" for #toggleSeparateBrands
      input checkbox#toggleSeparateBrands
      slot #verticalNavbarBrandsGrid
      button "Add more items"#divNewBrands primary
      text "Categories"
      text "Sort"#btnSortCategories
      label "Show categories" for #toggleSeparateCategories
      input checkbox#toggleSeparateCategories
      slot #verticalNavbarCategoriesGrid
      button "Add more items"#divNewCategories primary
      text "Tags"
      text "Sort"#btnSortTags
      label "Show tags" for #toggleSeparateTags
      input checkbox#toggleSeparateTags
      slot #verticalNavbarTagsGrid
      button "Add more items"#divNewTags primary
    heading "Page elements"
    slot #divPageElementsGrid
    button "Add section"#divAddNewPageElementItem
    block #divBlockPageElementsDetails_HiddenByDefault
      block #imagesBlockTitle
      button "Link"#divAddNewPageElementDetailsItem primary
      block #divPageElementHideNavigationMenu
        label "Hide carousel menu" for #chkPageElementHideNavigationMenu
        input checkbox#tdPageElementHideNavigationMenu
      slot #divAddNewPageElementDetailsItem
      slot #divPageElementDetailsGrid
      slot #divPageElementDetailsGridInfo (hidden)
  block #tab-portal-content-pages (hidden)
    heading "Content pages"#formCaption
    button "Save" primary
    slot #portalPagesGrid
    button "Add new section"#divAddNewPortalPageItem
    block #b2bHtmlPageEditorDiv
      input text#B2B_Index_PageTitle
      label "Page title"
      slot #b2bHtmlPageEditor
  block #tab-portal-email-templates (hidden)
    heading "Email templates"#formCaption
    button "Save" primary
    slot #portalEmailTemplatesGrid
    block #b2bHtmlEmailTemplateEditorDiv
      slot #txtEmailTemplateTitle
      input text#B2B_Index_EmailTemplateSubject
      label "Email subject:"
      slot #b2bHtmlEmailTemplateEditor
  block #tab-portal-catalog (hidden)
    heading "Catalog"#formCaption
    button "Save" primary
    text "Here you can show or hide products from appearing in the customer’s B2B portal view. Use options below to filter product"
    slot #tdCategoryFilter
    label "Category"
    slot #tdProductTagFilter
    label "Product tag"
    slot #tdFamilyFilter
    label "Family"
    slot #tdBrandFilter
    label "Brand"
    slot #tdMinimumToBuy
    label "Minimum to order"
    slot #tdMaximumToBuy
    label "Maximum to order"
    input text#divSearchCatalog name=divSearch placeholder "Type text to search"
    button "Search" primary
    button "List"#List primary
    button "Unlist"#Delist
    block #B2BCatalogExtraOptions
      button "More options" ▾
      link "Enable backorder"
      link "Disable backorder"
    button #Grid_Catalog_Options
    slot #catalogGridContainer
  block #tab-portal-price-lists (hidden)
    heading "Price lists"#formCaption
    button "Save" primary
    slot #portalPriceListsGrid
    button "Add new price list"#divAddNewPriceList
    block #b2bPriceListEditorDiv
      input text#B2B_Index_PriceListName
      label "Price list name"
      block #priceListContainer
        slot #B2B_Index_PriceListBrands
      slot #brandsPlaceholder
      slot #B2B_Index_PriceListCategories
      slot #categoriesPlaceholder
      slot #B2B_Index_PriceListTags
      slot #tagsPlaceholder
  block #tab-portal-invitations (hidden)
    heading "Invitations"#formCaption
    button "Sale rep invitation"#btnInviteSaleRep
    button "Save" primary
    input text#divInviteSearchField placeholder "Type text to search"
    button "Search" primary
    block #divFilterInviteStatusContainer
      select#divFilterInviteStatus: All | Show only not invited | Show invited but not accepted | Show only who accepted the invite | Show all invited
    button "Refresh"#btnInviteRefresh
    button #Grid_Invitations_Options
    block #divIvitationBulkAction
      text "0"#invitationSelectedCounter
      button "Invite selected"#btnInviteSelectedContainer primary
      link "Send invites to selected contacts"#btnInviteSelected
      link "Generate invites and export to CSV"#btnInviteCsv
      button "Revoke selected"#btnInviteRevokeSelected
    slot #InviteListGrid
  block #tab-portal-sales (hidden)
    heading "Sales"#formCaption
    button "Save" primary
    input text#divSearchSales placeholder "Type text to search..."
    button "Search" primary
    slot #divFilter
    button #Grid_Sales_Options
    slot #salesGridContainer
  block #tab-portal-abandonedcarts (hidden)
    heading "Abandoned carts"#formCaption
    button "Save" primary
    label "From date" for #dtAbandonedCartsFromDate
    slot #divAbandonedCartsFromDate
    label "To date" for #dtAbandonedCartsToDate
    slot #divAbandonedCartsToDate
    input text#divAbandonedCartsSearch placeholder "Type text to search..."
    button "Search" primary
    button "Export"
    button 
    button #Grid_AbandonedCarts_Options
    slot #abandonedCartsGrid
    form#frmExportAbandonedCarts
      input text#Export_webPortalId name=webPortalId (hidden)
      input text#Export_fromDate name=fromDate (hidden)
      input text#Export_toDate name=toDate (hidden)
  block #tab-add-new (hidden)
    heading "Add a new Portal"#formCaption
    button "Add" primary
    label "Your portal name"
    input text#B2B_Index_ShopName
    label "Your portal domain"
    input text#B2B_Index_ShopDomain
  block #tab-help (hidden)
    heading "Help"#formCaption
    link "full information sheet"
modal#SaleRepInvitationDialog small
  heading "Send a sale rep invitation"
  button "×"
  text "Sale rep will have the ability to select any active customer to which account the access is allowed and create a sale ta"
  input email#SaleRepEmail placeholder "Sale Rep Email" required
  label "Email"
  input text#SaleRepName placeholder "Sale Rep Name"
  label "Name"
  slot #SaleRepAccessType
  label "Access type"
  button "Close"
  button "Send an invitation" primary
modal#CustomMenuAddProductsDialog medium
  heading "Add products"#CustomMenuAddProductsDialogTitle
  button "×"
  slot #B2B_CustomMenu_Categories
  slot #customMenuCategoriesPlaceholder
  slot #B2B_CustomMenu_Families
  slot #customMenuFamiliesPlaceholder
  slot #B2B_CustomMenu_Brands
  slot #customMenuBrandsPlaceholder
  slot #B2B_CustomMenu_Tags
  slot #customMenuTagsPlaceholder
  slot #B2B_CustomMenu_ProductAttributes
  block #CustomMenuAttributeValueContainer (hidden)
    slot #CustomMenuAttributeValueField
    button "Add" primary
    button "Cancel"
  slot #CustomMenuAttributeValueSeparator (hidden)
  slot #customMenuProductAttributesPlaceholder
  slot #B2B_CustomMenu_Products
  slot #customMenuProductsPlaceholder
  button "OK" primary
  button "Cancel"
modal#CustomMenuPreviewDialog large
  heading "Custom menu preview"#CustomMenuAddProductsDialogTitle
  button "×"
  slot #CustomMenuPreviewSection
  button "OK" primary
modal#EmailTemplateKeywordsDialog small
  heading "Keywords"
  button "×"
  slot #divEmailTemplateKeywords
  button "Close"
modal#secPageElementConfigDialog small
  heading "Specify the basic settings for the new section"
  button "×"
  input text#tdNewPageElementDialog_Name
  label "Name" for #tdNewPageElementDialog_Name
  slot #tdNewPageElementDialog_SectionType
  label "Section type" for #tdNewPageElementDialog_SectionType
  input checkbox#tdNewPageElementDialog_IsVisible
  label "Visible" for #tdNewPageElementDialog_IsVisible
  button "Add" primary
  button "Close"
modal#changeDomainConfirmationDialog small
  heading "Change domain"
  button "×"
  text "Would you like to change the web portal domain name? Current users and the recipients who have been sent invitations wil"
  input text#B2B_Index_NewPortalDomain
  label "New domain" for #tdNewPageElementDialog_Name
  block #CustomerList_Delete_ValidationContainerWarning
    slot #changeDomainConfirmationDialog_Error (hidden)
  button "Change domain name" primary
  button "Close"
form#frmExportContacts
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Portal2019`

18 grids · 40 standalone fields · 0 windows · 10 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `horizontalNavbarItemsGrid` · store `vHorizontalNavbarItemsStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | 35 | renderer() |  |
    | Item | `ItemId` |  | flex 1 | renderer() |  |

- **grid** · renders into `verticalNavbarBrandsGrid` · store `BrandsSeparateStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | 35 | renderer() |  |
    | Brands | `ItemId` |  | flex 1 | renderer() |  |

- **grid** · renders into `verticalNavbarCategoriesGrid` · store `CategoriesSeparateStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | 35 | renderer() |  |
    | Categories | `ItemId` |  | flex 1 | renderer() |  |

- **grid** · renders into `verticalNavbarTagsGrid` · store `TagsSeparateStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | 35 | renderer() |  |
    | Tags | `ItemId` |  | flex 1 | renderer() |  |

- **grid** · renders into `shippingMethodsGrid` · store `vShippingMethodsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Is active | `IsActive` | check column | 100 | renderer() |  |

- **grid** · renders into `paymentMethodsGrid` · store `vPaymentMethodsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 2 | renderer() |  |
    | Method type | `PaymentMethodType` |  | flex 1 | renderer() |  |
    | Is active | `IsActive` | check column | flex 1 | renderer() |  |

- **grid** · renders into `SortingOptionsGrid` · store `vSortingOptionsStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sorting type | `Name` |  | flex 1 | renderer() |  |
    | Display name | `B2BName` |  | flex 1 | renderer() |  |
    | Default | `IsDefault` | action column | 110 | renderer() |  |

- **grid** · renders into `divPageElementsGrid` · store `vPageElementsStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | RenderHTMLText |  |
    | Visible | `IsVisible` | check column | 50 | renderer() |  |
    |  | `` | action column | 45 | renderer() |  |

- **grid** · renders into `divPageElementDetailsGrid` · store `vPageElementsDetailsStore` · placeholder `Empty`
  - *columns:*
    - *(component built elsewhere: `pageElementsDetailsColumnsSet1`)*
- **grid** · renders into `portalPagesGrid` · store `vPortalPagesStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |
    |  | `Type` | action column | 45 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `vCatalogStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Available/ordered quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Minimum order quantity | `MinimumToOrder` |  | flex 1 |  |  |
    | Maximum order quantity | `MaximumToOrder` |  | flex 1 |  |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Backorder | `IsBackorderEnabled` |  | flex 1 | renderer() |  |
    | Menu items | `MenuItems` |  | flex 1 | renderer() |  |

- **grid** · renders into `salesGridContainer` · store `vSalesStore` · placeholder `Sales are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `OrderDate` |  | flex 1 | renderer() |  |
    | Customer | `Customer` |  | flex 1 | renderer() |  |
    | Sale order | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Amount | `InvoiceAmount` |  | flex 1 | renderer() |  |
    | Order status | `Status` |  | flex 1 | Sale_Shared_RenderStatus |  |
    | Payment status | `PaymentStatus` |  | flex 1 | renderer() |  |

- **grid** · renders into `abandonedCartsGrid` · store `vAbandonedCartsStore` · placeholder `Abandoned carts are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Abandoned date and time | `DateTime` |  | flex 1 | renderer() |  |
    | Quantity in cart | `Quantity` |  | flex 1 | renderer() |  |
    | Cart total | `CartTotal` |  | flex 1 | renderer() |  |
    | Contact | `CustomerContactName` |  | flex 1 | renderer() |  |
    | Email | `CustomerContactEmail` |  | flex 1 | renderer() |  |

- **grid** · renders into `portalEmailTemplatesGrid` · store `vPortalEmailTemplatesStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Email templates | `Description` |  | flex 1 | renderer() |  |

- **grid** · renders into `InviteListGrid` · store `vCustomerInviteStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 45 | renderer() |  |
    | Customer | `CustomerName` |  | flex 3 | renderer() |  |
    | Contact | `ContactPerson` |  | flex 3 | renderer() |  |
    | Email | `Email` |  | flex 3 | renderer() |  |
    | Date | `InviteSendDate` |  | flex 2 | renderer() |  |
    | Status | `Status` |  | flex 2 | renderer() |  |
    | Is invite accepted | `InviteAccepted` |  | flex 2 | renderer() |  |
    | Access type | `SaleRepAccessType` |  | flex 2 | renderer() |  |
    |  | `` | action column | 45 |  |  |

- **grid** · renders into `portalPriceListsGrid` · store `vPortalPriceListsStore` · placeholder `Empty`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Price lists | `Name` |  | flex 1 | renderer() |  |
    |  | `` | action column | 45 | renderer() |  |

- **grid** · renders into `OverviewSalesGrid` · store `vOverviewSalesStore` · placeholder `No data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | 80 | renderer() |  |
    | Number | `Number` |  | 80 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `OverviewCustomersGrid` · store `vOverviewCustomersStore` · placeholder `No data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| file field |  | `B2B_Index_CartImage` | `attachedFile` |  |
| combo |  | `B2B_Index_PortalType` | `PortalTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `B2B_Index_Contacts` | `vContactsStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `B2B_Index_Address` | `vAddressesStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| combo |  | `B2B_Index_Location` | `vLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `B2B_Index_ReturnDeliveryLocation` | `vReturnDeliveryLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| number field |  | `divAbandonedCartTimeValue` | `` |  |
| combo |  | `B2B_Index_AbandonedCartTimeUnit` | `vAbandonedCartTimeUnitsStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `B2B_Index_HorizontalNavbarDataType` | `DataTypeWithCustomMenu` | shows `name` · value `value` · pick-only |
| combo |  | `B2B_Index_CreateSaleAs` | `CreateSaleAsStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `tdDefaultRevenue` | `vAccounts` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdInvoiceTemplate` | `invoiceTemplatesStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdShowAvailableQuantity` | `ShowAvailableQuantityStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `tdFamilyPriceFormat` | `FamilyPriceFormatStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `tdProductListLayout` | `ProductListLayoutStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `tdPriceListTemplate` | `priceListTemplatesStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdPriceTierForGuestUser` | `vPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `tdRRPPriceTier` | `vRRPPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `tdFamilyProductsView` | `FamilyProductsViewStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| text field |  | `` | `` | placeholder `Start typing to see suggestions...` |
| file field |  | `B2B_Index_Logo` | `attachedFile` |  |
| combo |  | `tdNewPageElementDialog_SectionType` | `vPageElementsTypesStrictStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `tdCategoryFilter` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List of all categories` |
| combo |  | `tdProductTagFilter` | `TagsStore` | shows `Value` · value `Value` · placeholder `List of all tags` |
| combo |  | `tdBrandFilter` | `BrandStore` | shows `Brand` · value `ID` · placeholder `List of all brands` |
| number field |  | `tdMinimumToBuy` | `` |  |
| number field |  | `tdMaximumToBuy` | `` |  |
| combo |  | `B2B_Index_TagNameForMarkedNewProduct` | `TagsStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| date field |  | `divAbandonedCartsFromDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| date field |  | `divAbandonedCartsToDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| combo |  | `B2B_Index_PriceListBrands` | `priceListBrandStore` | shows `Brand` · value `ID` · placeholder `type to search brands` |
| combo |  | `SaleRepAccessType` | `SaleRepAccessTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `B2B_Index_PriceListCategories` | `priceListCategoryStore` | shows `Category` · value `CategoryID` · placeholder `Type to search categories` |
| combo |  | `B2B_Index_PriceListTags` | `priceListTagsStore` | shows `Value` · value `Value` · placeholder `type to search tags` |
| combo |  | `B2B_CustomMenu_Products` | `customMenuProductsStore` | shows `Name` · value `ID` · placeholder `Product` |
| combo |  | `B2B_CustomMenu_Families` | `customMenuFamiliesStore` | shows `Name` · value `ID` · placeholder `Product family` |
| combo |  | `B2B_CustomMenu_Categories` | `customMenuCategoryStore` | shows `Category` · value `CategoryID` · placeholder `Category` |
| combo |  | `B2B_CustomMenu_Brands` | `customMenuBrandStore` | shows `Brand` · value `ID` · placeholder `Brand` |
| combo |  | `B2B_CustomMenu_Tags` | `customMenuTagsStore` | shows `Value` · value `Value` · placeholder `Product tag` |
| combo |  | `B2B_CustomMenu_ProductAttributes` | `customMenuProductAttributesStore` | shows `DisplayName` · value `ID` · placeholder `Product additional attribute` |

#### Menus, buttons and other parts

- **column** “Image” · field `FileHtml` · itemId `colPageElementDetailsFileHtml`
- **column** · field `FileName`
- **column** “Use” · field `LinkType`
- **column** “Item” · field `LinkItem`
- **action column** · itemId `colDeletePageElementDetailsEntry`
- **column** “Title” · field `LinkItem`
  - editor: B2B_Actions_CreateTextInlineEditor
- **column** “Tags” · field `LinkMessage`
- **component** · renders into `tdFamilyFilter` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`
- **component** · id `cmbFilter` · renders into `divFilter` · store `FilterStore` · shows `name` · value `Value` · pick-only
- **column** · store `vOverviewAbandonedCartsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Abandoned date | `DateTime` |  | 80 | renderer() |  |
    | Contact | `ContactName` |  | flex 1 | renderer() |  |
    | Quantity in cart | `Quantity` |  | flex 1 | renderer() |  |
    | Cart total | `CartTotal` |  | flex 1 | renderer() |  |


