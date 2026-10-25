-- Portal: one table per Cin7 Core data model, generated from data/models.json

create table "B2B_SearchProduct" (
  "Id" text,
  "Code" text,
  "Name" text,
  "Type" text
);

create table "vAbandonedCart" (
  "CartID" text,  -- -> Cart
  "DateTime" timestamptz,
  "CustomerContactEmail" text,
  "CustomerID" text,  -- -> Customer
  "CustomerContactName" text,
  "CartTotal" numeric,
  "CartTotalCurrency" text,
  "Quantity" numeric
);

create table "vAbandonedCartProduct" (
  "ProductID" text,  -- -> Product
  "CartID" text,  -- -> Cart
  "ProductName" text,
  "ProductCode" text,
  "Quantity" numeric,
  "PriceValue" numeric,
  "PriceCurrency" text,
  "AvailableQuantity" numeric,
  "Status" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vAddress" (
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text
);

create table "vBulkListingProduct" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Category" text,
  "Price" numeric,
  "OrderedQuantity" numeric,
  "MinimumToOrder" integer,
  "MaximumToOrder" integer,
  "Quantity" numeric,
  "MenuItems" text,
  "IsBackorderEnabled" boolean
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

create table "vCustomerInvite" (
  "ID" text,
  "CustomerID" text,  -- -> Customer
  "CustomerName" text,
  "ContactPerson" text,
  "Email" text,
  "Status" text,
  "Role" text,
  "InviteSendDate" timestamptz,
  "InviteAccepted" boolean,
  "Selected" boolean,
  "SaleRepAccessType" integer
);

create table "vInvoiceTemplate" (
  "TemplateID" text,  -- -> Template
  "Name" text
);

create table "vLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vNameValue" (
  "Name" text,
  "Value" text
);

create table "vNavbarItem" (
  "ID" text,
  "WebPortalID" text,  -- -> Portal
  "NavbarType" text,
  "Item" text,
  "ItemId" text,  -- -> Item (context-specific)
  "ItemName" text,
  "DisplayName" text,
  "ItemType" text,
  "LineOrder" integer
);

create table "vOverviewAbandonedCarts" (
  "ID" text,
  "DateTime" timestamptz,
  "ContactName" text,
  "Quantity" numeric,
  "CartTotal" numeric
);

create table "vOverviewCustomers" (
  "CustomerID" text,  -- -> Customer
  "CustomerName" text,
  "Sales" integer,
  "Amount" numeric
);

create table "vOverviewSales" (
  "ID" text,
  "Date" timestamptz,
  "Number" text,
  "CustomerName" text,
  "CustomerID" text,  -- -> Customer
  "Amount" numeric,
  "Status" text,
  "TaskType" text
);

create table "vPaymentMethod" (
  "Value" text,
  "Name" text
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

create table "vPortalPriceList" (
  "WebPortalID" text,  -- -> Portal
  "Name" text,
  "ID" text,
  "LineOrder" integer
);

create table "vPriceListBrand" (
  "ID" text,
  "WebPortalPriceListID" text,  -- -> WebPortalPriceList
  "BrandID" text,  -- -> Brand
  "Name" text
);

create table "vPriceListCategory" (
  "ID" text,
  "WebPortalPriceListID" text,  -- -> WebPortalPriceList
  "CategoryID" text,  -- -> ProductCategory
  "Name" text
);

create table "vPriceListTag" (
  "ID" text,
  "WebPortalPriceListID" text,  -- -> WebPortalPriceList
  "Tag" text
);

create table "vProductAttributeRow" (
  "ID" text,
  "DisplayName" text,
  "SetID" text,  -- -> AttributeSet
  "ColumnNumber" text,
  "AttributeSetName" text,
  "ColumnName" text,
  "ColumnType" text,
  "ColumnValues" text,
  "AttributeName" text
);

create table "vShippingMethod" (
  "ID" text,
  "Name" text
);

create table "vShippingService" (
  "ID" text,
  "Name" text
);

create table "vSortingOption" (
  "WebPortalID" text,  -- -> Portal
  "ID" text,
  "Name" text,
  "B2BName" text,
  "IsDefault" boolean
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

create table "vWebPortalPageElements" (
  "Id" text,
  "WebPortalId" text,  -- -> Portal
  "Name" text,
  "LineOrder" integer,
  "IsRemovable" boolean,
  "IsVisible" boolean,
  "SectionType" text,
  "Location" text,
  "HideNavigationMenu" boolean
);

create table "vWebPortalPageElementsDetails" (
  "Id" text,
  "WebPortalPageElementId" text,  -- -> WebPortalPageElement
  "DetailsType" text,
  "LineOrder" integer,
  "LinkType" text,
  "ContentType" text,
  "LinkItem" text,
  "LinkMessage" text,
  "LinkUrl" text,
  "Text" text,
  "FileName" text,
  "FileHtml" text,
  "IsFamily" text
);

create table "vWebPortalSale" (
  "TaskId" text,  -- -> Task (any document)
  "OrderDate" timestamptz,
  "Customer" text,
  "SaleOrderNumber" text,
  "Status" text,
  "PaymentStatus" text,
  "InvoiceAmount" numeric,
  "Reference" text
);
