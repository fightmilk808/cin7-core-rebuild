# RMA Portal: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/RmaPortal` | RMA Portal | [`RmaPortal2019`](#rmaportal2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/RmaPortal`: RMA Portal

Frame: `task-upload-frame`.

```text
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview | New portal #tab-add-new (hidden) | Help #tab-portal-help
block #page-container
  block #portal-setup-left-menu (hidden)
    button "Status"#PortalStatusTabButton
    button "General"#SetupTabButton
    button "Appearance"
    button "Content pages"#ContentPagesButton
    button "Email templates"
  block #tab-overview-content
    slot #FeatureModuleDetailsBlock (hidden)
    heading "Overview"
    text "Read the documentation for RMA Portal and Cin7 Core integration."
    button "Read documentation" primary
    button "Help"#btn-show-help primary
  block #tab-portal-status (hidden)
    heading "Portal status"
    label "Active" for #RmaPortal_Index_IsActive
    input checkbox#RmaPortal_Index_IsActive
    slot #RmaPortal_Index_URL
    button "Go to portal"#linkGoToPortal
    button "Copy URL"
    text ""myportalname" is now active. Change domain anytime by clicking “Change domain” and set custom domain by “Configure cust"
    link "Configure custom domain name"
    button "Change domain"#ChangeDomainButton primary
  block #tab-portal-settings (hidden)
    heading "Portal settings"
    button "Save" primary
    block #divGeneral
      label "Portal name"
      input text#RmaPortal_Index_PortalName placeholder "Portal name"
      label "Portal address"
      slot #RmaPortal_Index_Address
      label "Portal contacts"
      slot #RmaPortal_Index_Contacts
      label ""
      label "Tracker ID"
      input text#RmaPortal_Index_GoogleAnalyticsTrackerID placeholder "Google Analytics Tracker ID"
      label "Measurement ID"
      input text#RmaPortal_Index_GoogleAnalytics4TrackerID placeholder "Google Analytics 4 Measurement ID"
    form#sslform
      heading "Custom domain for portal"
      slot #RmaPortal_Index_PortalCustomDomainStatusBadge (hidden)
      block #customDomainSettings
        label "Connect a custom domain to your portal so customers can access it at your own URL"
        block #RmaPortal_Index_PortalCustomDomainFormControl
          input text#fakedusername name=fakeusernameremembered (hidden)
          input password#fakedpassword name=fakepasswordremembered (hidden)
          input text#RmaPortal_Index_PortalCustomDomainName name=DomainName placeholder "Example: shop.yourcompany.com"
          label "Custom domain (URL)"
        block #RmaPortal_Index_PortalCustomDomainError (hidden)
      block #RmaPortal_Index_CustomDomainDnsBlock (hidden)
        button "Refresh"#refresh-cdn-button primary
        text "Add the following TXT and CNAME records at your DNS provider to activate your custom domain. The TXT value will populate"
        table: Type | Name / Host | Value
      block #RmaPortal_Index_CustomDomainLegacyBlock (hidden)
        text "Reconnect your custom domain To keep your custom domain working, you need to reconnect it to our new system. This takes "
      text "Set custom domain"#set-cdn-button
      text "Remove custom domain"#remove-cdn-button (hidden)
    heading "Social media links"
    label "Facebook"
    input text#RmaPortal_Index_SocialNetworksFacebook
    label "Google+"
    input text#RmaPortal_Index_SocialNetworksGooglePlus
    label "Twitter"
    input text#RmaPortal_Index_SocialNetworksTwitter
    label "Instagram"
    input text#RmaPortal_Index_SocialNetworksInstagram
    block #b2b-disconnect-area
      button "Disconnect portal"#remove-store-button
      form#frmDisconnect
  block #tab-portal-appearance (hidden)
    heading "Portal appearance"
    button "Preview portal"#PriviewPortalButton
    button "Save" primary
    text "Select portal appearance template Custom appearance"
    heading "Portal custom appearance"
    text "Logo will show on your portal and can be changed at anytime. It must be .jpg and .png high resolution."
    label "Upload logo"
    form#frmUploadLogo
      slot #RmaPortal_Index_Logo
    heading "Header area"
    text "A range of parameters to customize RMA portal header colors."
    label "Header background"
    input text#cpHeaderBackgroundColor
    label "Pre-header background"
    input text#cpPreHeaderBackgroundColor
    label "Navigation text"
    input text#cpNavigationTextColor
    label "Navigation text hover"
    input text#cpNavigationTextHoverColor
    label "Contacts text"
    input text#cpContactsTextColor
    label "Slogan background"
    input text#cpSloganBackgroundColor
    slot #b2bHtmlSlogan
    heading "Content area"
    text "A range of parameters to customize RMA portal content colors."
    label "Page background"
    input text#cpPageBackgroundColor
    label "Content text"
    input text#cpContentColor
    label "Button background"
    input text#cpButtonsBackgroundColor
    label "Content link"
    input text#cpContentLinkColor
    label "Button text"
    input text#cpButtonsColor
    label "Pre-footer text"
    input text#cpPreFooterTextColor
    label "Pre-footer background"
    input text#cpPreFooterBackgroundColor
    label ""
    label ""
    heading "Footer area"
    text "A range of parameters to customize RMA portal content colors."
    label "Footer background"
    input text#cpFooterBackgroundColor
    label "Footer text"
    input text#cpFooterTextColor
    label "Footer link"
    input text#cpFooterLinkColor
    label ""
    button "Reset to default"#btnResetAppearance
  block #tab-portal-content-pages (hidden)
    heading "Content pages"
    button "Save" primary
    tabs#ulContentPages: 
    button "New page"#divAddNewPortalPageItem primary
    block #b2bHtmlPageEditorDiv
      input text#RmaPortal_Index_PageTitle
      label "Page title"
      slot #b2bHtmlPageEditor
  block #tab-portal-email-templates (hidden)
    heading "Email templates"
    button "Save" primary
    tabs#ulEmailTemplates: 
    block #b2bHtmlPageEditorDiv
      slot #txtEmailTemplateTitle
      input text#RmaPortal_Index_EmailTemplateSubject
      label "Email subject"
      slot #b2bHtmlEmailTemplateEditor
  block #tab-add-new (hidden)
    heading "Add RMA Portal"
    input text#RmaPortal_Index_ShopName
    label "Portal name"
    input text#RmaPortal_Index_ShopDomain
    label "Portal domain"
    button "Create portal" primary
    heading "Your portal URL will be:"
  block #tab-help (hidden)
    heading "Help"
modal#EmailTemplateKeywordsDialog small
  heading "Keywords"
  button "×"
  slot #divEmailTemplateKeywords
  button "Close"
modal#changeDomainConfirmationDialog small
  heading "Change domain"
  button "×"
  input text#RmaPortal_Index_OldPortalDomain
  label "Current domain" for #RmaPortal_Index_OldPortalDomain
  text "Would you like to change the web portal domain name? Current users will no longer be able to access your RMA portal, you"
  input text#RmaPortal_Index_NewPortalDomain
  label "New domain" for #tdNewPageElementDialog_Name
  block #CustomerList_Delete_ValidationContainerWarning
    slot #changeDomainConfirmationDialog_Error (hidden)
  button "Change domain name" primary
  button "Cancel"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `RmaPortal2019`

0 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `RmaPortal_Index_Contacts` | `vContactsStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `RmaPortal_Index_Address` | `vAddressesStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| file field |  | `RmaPortal_Index_Logo` | `attachedFile` |  |

