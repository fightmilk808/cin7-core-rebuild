# Shell and navigation: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Components by bundle

### `Main2019`

6 grids · 10 standalone fields · 0 windows · 19 menus, buttons and other parts · 11 custom components

#### Grids

- **grid** · renders into `ActivityLogs_Container` · store `ActivityLogsStore` · placeholder `There are no records in activity log at the moment.`
  - *columns:*
    - *(component built elsewhere: `gridColumns`)*
- **grid** · renders into `gridRecipients` · store `RecipientsStore` · placeholder `You do not have any contacts with emails at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Checked` | check column | 58 | renderer() |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Email | `Email` |  | flex 1 |  |  |

- **grid** · id `id` · renders into `divTaskDeliveryNotesGrid` · store `store` · placeholder `emptyText`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateTime` |  | flex 1 | renderer() |  |
    | Added by | `UserName` |  | flex 1 | renderer() |  |
    | Notes | `Note` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaskDeliveryItems` · store `DeliveryItemsStore` · placeholder `You do not have any delivery items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | 80 |  |  |

- **grid** · renders into `divAttachmentGrid` · store `TaskFileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `AlternativeProductsModal_Grid` · store `vProductAlternativeStockStore` · placeholder `No alternative products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | 100 | renderer() |  |
    | Product | `ProductName` |  | flex 2 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | On hand | `OnHand` |  | flex 1 | renderer() |  |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | On order | `OnOrder` |  | flex 1 | renderer() |  |
    | Allocated | `Allocated` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| checkbox |  | `EmailSendTemplate_NetworkingCheck` | `` |  |
| combo |  | `divNotesUserFilter` | `usersStore` | shows `UserName` · value `id` · placeholder `Choose...` |
| date field |  | `divNotesDateFilter` | `` | placeholder `Choose...` · format `window.UserDateFormat` |
| date field |  | `Task_tbTaskStart` | `` | format `TaskModule_DateFormatExt` |
| date field |  | `Task_tbTaskEnd` | `` | format `TaskModule_DateFormatExt` |
| combo |  | `TFA_Question_1` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |
| combo |  | `TFA_Question_2` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |
| combo |  | `TFA_Question_3` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |

#### Menus, buttons and other parts

- **tooltip** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **item** “{menuItemText}” · icon `sortCls`
- **button** “{menuItemText}” · icon `sortCls` · on click `function(col){return function(){var subColCount=col.items.ge(…)`
- **column** “{name}” · field `valueProperty` · id `"colDimension_".concat(…)`
- **date column** “Date” · field `Date` · id `ActivityLogs_Date`
- **column** “Activity” · field `Message` · id `ActivityLogs_Message`
- **column** “Username” · field `UserName` · id `ActivityLogs_UserName`
- **column** “Reference” · field `Reference` · id `ActivityLogs_Reference`
- **action column** “{header}”
- **action column** “{header}” · id `"actionColumn_".concat(…)`
- **action column**
  - **component** “test” · on click `handler()`
- **action column**
  - **component** “test” · on click `handler()`
- **component** “Are you sure?”
- **column** “LogicalExpression” · field `Expand` · hidden
- **column** · field `Edit` · hidden
- **column** · field `colDelete`
- **check column** · field `Selected`
- **column** · field `None`

#### Custom components (`Ext.define`)

- **`Ext.draw.Text`** extends `Ext.draw.Component` · alias `widget.text`
- **`Ext.view.AbstractView`** extends `Ext.Component`
- **`Ext.form.Labelable`** extends `?`
- **`Ext.ProgressBar`** extends `Ext.Component` · alias `widget.progressbar`
- **`Ext.menu.Separator`** extends `Ext.menu.Item` · alias `widget.menuseparator`
- **`Ext.grid.column.Column`** extends `Ext.grid.header.Container` · alias `widget.gridcolumn`
- **`Ext.grid.RowNumberer`** extends `Ext.grid.column.Column` · alias `widget.rownumberer`
- **`Ext.toolbar.TextItem`** extends `Ext.toolbar.Item` · alias `widget.tbtext`
- **`Ext.panel.Panel`** extends `Ext.panel.AbstractPanel` · alias `widget.panel`
- **`Ext.tip.QuickTip`** extends `Ext.tip.ToolTip` · alias `widget.quicktip`
- **`Ext.window.MessageBox`** extends `Ext.window.Window` · alias `widget.messagebox`

### `MainAccount2019`

0 grids · 5 standalone fields · 0 windows · 11 menus, buttons and other parts · 11 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| combo |  | `cmbAreaCode` | `countryCodeStore` | shows `FullCode` · value `CountryCode` · placeholder `` |
| combo |  | `cmbAreaCode` | `countryCodeStore` | shows `FullCode` · value `CountryCode` · placeholder `` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |

#### Menus, buttons and other parts

- **tooltip** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **item** “{menuItemText}” · icon `sortCls`
- **button** “{menuItemText}” · icon `sortCls` · on click `function(col){return function(){var subColCount=col.items.ge(…)`
- **column** “{name}” · field `valueProperty` · id `"colDimension_".concat(…)`
- **component** “Are you sure?”
- **column** “LogicalExpression” · field `Expand` · hidden
- **column** · field `Edit` · hidden
- **column** · field `colDelete`
- **check column** · field `Selected`
- **column** · field `None`

#### Custom components (`Ext.define`)

- **`Ext.draw.Text`** extends `Ext.draw.Component` · alias `widget.text`
- **`Ext.view.AbstractView`** extends `Ext.Component`
- **`Ext.form.Labelable`** extends `?`
- **`Ext.ProgressBar`** extends `Ext.Component` · alias `widget.progressbar`
- **`Ext.menu.Separator`** extends `Ext.menu.Item` · alias `widget.menuseparator`
- **`Ext.grid.column.Column`** extends `Ext.grid.header.Container` · alias `widget.gridcolumn`
- **`Ext.grid.RowNumberer`** extends `Ext.grid.column.Column` · alias `widget.rownumberer`
- **`Ext.toolbar.TextItem`** extends `Ext.toolbar.Item` · alias `widget.tbtext`
- **`Ext.panel.Panel`** extends `Ext.panel.AbstractPanel` · alias `widget.panel`
- **`Ext.tip.QuickTip`** extends `Ext.tip.ToolTip` · alias `widget.quicktip`
- **`Ext.window.MessageBox`** extends `Ext.window.Window` · alias `widget.messagebox`

### `MultilingualSupport2019`

1 grids · 0 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `gridCustomId` · renders into `langGridId` · store `MultilingualDataStore`
  - *columns:*
    - *(component built elsewhere: `colSet`)*

#### Menus, buttons and other parts

- **column** · field `TemplateName`
- **column** · field `Text`
- **column** “Language” · field `TemplateName`
- **column** “Translation” · field `Text`

