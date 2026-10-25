-- RMA Portal: one table per Cin7 Core data model, generated from data/models.json

create table "vAddress" (
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text
);

create table "vAppearance" (
  "WebPortalID" text,  -- -> Portal
  "Name" text,
  "ButtonsBackgroundColor" text,
  "ButtonsColor" text,
  "ContactsTextColor" text,
  "ContentColor" text,
  "ContentLinkColor" text,
  "FooterBackgroundColor" text,
  "FooterLinkColor" text,
  "FooterTextColor" text,
  "HeaderBackgroundColor" text,
  "NavigationTextColor" text,
  "NavigationTextHoverColor" text,
  "PageBackgroundColor" text,
  "PreFooterBackgroundColor" text,
  "PreFooterTextColor" text,
  "PreHeaderBackgroundColor" text,
  "SloganBackgroundColor" text,
  "Status" text
);

create table "vContact" (
  "ID" text,
  "ECSConfigID" text,  -- -> IntegrationConfig
  "ECSName" text,
  "IsOrganization" boolean,
  "ContactType" text,
  "Status" text,
  "Tags" text
);

create table "vPortalEmailTemplate" (
  "WebPortalID" text,  -- -> Portal
  "Name" text,
  "Content" text,
  "Description" text,
  "Subject" text
);

create table "vPortalPage" (
  "WebPortalPageID" text,  -- -> WebPortalPage
  "WebPortalID" text,  -- -> Portal
  "Name" text,
  "LineOrder" text,
  "Content" text,
  "IsActive" text,
  "Type" text
);

create table "vWebPortal" (
  "WebPortalID" text,  -- -> Portal
  "Name" text,
  "Type" text,
  "Domain" text,
  "Description" text,
  "IsActive" boolean,
  "HorizontalNavbarDataType" text,
  "DefaultCustomer" text,
  "AllowBackorder" boolean,
  "ShowAdditionalAttributes" boolean,
  "ShowOutOfStockItems" boolean,
  "ShowMinimumOrderQuantityForProducts" boolean,
  "ShowMaximumOrderQuantityForProducts" boolean,
  "FacebookURL" text,
  "GooglePlusURL" text,
  "TwitterURL" text,
  "InstagramURL" text,
  "YouTubeURL" text,
  "LinkedInURL" text,
  "TenantContactID" text,  -- -> TenantContact
  "TenantAddressID" text,  -- -> TenantAddress
  "LocationID" text,  -- -> Location
  "ShowImagesInShoppingCart" boolean,
  "SalesRepresentative" text,
  "GoogleAnalyticsTrackerID" text,  -- -> GoogleAnalyticsTracker
  "GoogleAnalytics4TrackerID" text,  -- -> GoogleAnalytics4Tracker
  "UseHubSpotTracking" boolean,
  "ShowAllCustomerOrders" boolean,
  "CreateSaleAs" text,
  "InvoiceTemplateID" text,  -- -> InvoiceTemplate
  "PriceListTemplateID" text,  -- -> PriceListTemplate
  "HeaderBackgroundColor" text,
  "NavigationTextColor" text,
  "NavigationTextHoverColor" text,
  "ContactsTextColor" text,
  "PageBackgroundColor" text,
  "PreHeaderBackgroundColor" text,
  "TitleTextColor" text,
  "ContentColor" text,
  "ContentLinkColor" text,
  "ButtonsBackgroundColor" text,
  "CategoryTextBackgroundColor" text,
  "CategoryTextColor" text,
  "SloganBackgroundColor" text,
  "Slogan" text,
  "PreFooterBackgroundColor" text,
  "PreFooterTextColor" text,
  "FooterBackgroundColor" text,
  "FooterTextColor" text,
  "TableHeaderBackgroundColor" text,
  "TableHeaderColor" text,
  "DefaultRevenueAccount" text,
  "LogoGuid" text,
  "CartImageGuid" text,
  "NoImageGuid" text,
  "ShowAvailableQuantity" text,
  "ShowNotDiscountedPrice" boolean,
  "IncludeAvailableQtyToPriceList" boolean,
  "ProductExtraParams" text,
  "NewTagName" text,
  "ShippingService" text,
  "FamilyPriceFormat" text,
  "ProductListLayout" text,
  "ShowTaxPercents" boolean,
  "ShowTaxMethod" boolean,
  "HideImagesInProductList" boolean,
  "OutOfStockColor" text,
  "InStockColor" text,
  "IsAttachmentMandatory" boolean,
  "AllowGuestAccess" boolean,
  "PriceTierForGuestUser" integer,
  "ButtonsColor" text,
  "PriceColor" text,
  "FooterLinkColor" text,
  "CustomMenuFirstLevelBgColor" text,
  "CustomMenuFirstLevelHoverBgColor" text,
  "CustomMenuFirstLevelTextColor" text,
  "CustomMenuSecondLevelBgColor" text,
  "CustomMenuSecondLevelHoverBgColor" text,
  "CustomMenuSecondLevelTitleColor" text,
  "CustomMenuSecondLevelTextColor" text,
  "CustomMenuThirdLevelBgColor" text,
  "CustomMenuThirdLevelHoverBgColor" text,
  "CustomMenuThirdLevelTitleColor" text,
  "CustomMenuThirdLevelTextColor" text,
  "CustomMenuSeparatorColor" text,
  "CustomDomain" text,
  "MinimumOrderAmount" numeric,
  "MaximumOrderAmount" numeric,
  "HideShippingCost" boolean,
  "EnableOrderRouting" boolean,
  "ShowDealInformation" boolean,
  "RRPPriceTier" integer,
  "AllowCreateOrderWhenCreditHold" boolean,
  "FamilyProductsView" integer,
  "EnabledProductReturn" boolean,
  "ReturnDeliveryLocationID" text,  -- -> ReturnDeliveryLocation
  "ShowLeftMenuBrands" boolean,
  "ShowLeftMenuCategories" boolean,
  "ShowLeftMenuTags" boolean,
  "EnabledAbandonedCarts" boolean,
  "AbandonedCartTimeValue" integer,
  "AbandonedCartTimeUnit" text,
  "MaxMenuItemCount" integer,
  "ShowSeparateProductsForFamily" boolean,
  "ShowSingleMultipleDeliveryOptions" boolean,
  "LogInInfo" text,
  "ShowCustomerAttachmentsOnly" boolean
);
