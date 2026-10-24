# Portal: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Portal` | Portal | [`Portal2019`](#portal2019) |

## Components by bundle

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


