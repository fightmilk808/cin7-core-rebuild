# Imports and line uploads

Column layouts Cin7 Core expects in its CSV imports, read from the page code: each import validates rows into a model where every column `X` has a matching `XError`, so those `X` columns are the file's columns. Date columns named `…_YYYYMMDD` take that format.

## Document line uploads

Upload lines into an open document (sale quote/order, purchase order/invoice, stock received, stocktake, transfer, write-off, production output). Each has a download → edit → upload cycle on its document page.

| Upload | Model | Columns |
|---|---|---|
| Sale quote lines | `SaleQuoteLineUploadError` | `SKU`, `Name`, `Comment`, `Quantity`, `Price`, `Discount` |
| Sale order lines | `SaleOrderLineUploadError` | `SKU`, `Name`, `Comment`, `Quantity`, `Price`, `Discount` |
| Purchase order lines | `PurchaseOrderLineUploadError` | `SKU`, `Name`, `Quantity`, `Price`, `Discount`, `Comment` |
| Purchase invoice lines | `PurchaseInvoiceLineUploadError` | `SKU`, `Name`, `Quantity`, `Price`, `Discount`, `Comment` |
| Purchase stock received (intermediate) | `PurchaseIntStockLineUploadError` | `SKU`, `ProductName`, `BatchSerialNumber`, `ExpiryDate_YYYYMMDD`, `Quantity`, `DateReceived_YYYYMMDD` |
| Stock adjustment / transfer lines | `StocktakeLineUploadError` | `LineType`, `Location`, `SKU`, `Name`, `Bin`, `BatchSerialNumber`, `ExpiryDate_YYYYMMDD`, `Quantity`, `UnitCost`, `Comments`, `ReceivedDate_YYYYMMDD` |
| Stock transfer order lines | `StockTransferOrderLineUploadError` | `SKU`, `Name`, `Quantity`, `Comments` |
| Stocktake counts | `StocktakeImportError` | `ProductCode`, `ProductName`, `Bin`, `Unit`, `BatchSN`, `ExpiryDate_YYYYMMDD`, `QuantityOnHand`, `StocktakeQuantity`, `ReceivedDate_YYYYMMDD` |
| Inventory write-off components | `ComponentLineUploadError` | `SKU`, `Bin`, `BatchSN`, `ExpiryDate`, `ExpenseAccount`, `Quantity`, `Cost` |
| Production order output (yield) | `YieldLineUploadError` | `SKU`, `Name`, `BatchSerialNumber`, `ExpiryDate_YYYYMMDD`, `Quantity`, `Location`, `DateReceived_YYYYMMDD` |
| Opening balances (outstanding invoices) | `ExceptionsList` | `SupplierName`, `SupplierReference`, `InvoiceDate`, `Amount`, `CurrencyConversionRate` |

Also built in the browser: MRP forecast upload (`Demand Location, Product SKU, Product Name, Quantity, Required by Date`) and FBA shipment items (`Box Number, SKU, Items per box, Box Weight (lbs), Width (in), Height (in), Depth (in)`).

## Master-data imports

Bulk imports post the parsed file as JSON to a controller action. The table lists each distinct column layout found in the page code, the bundle it lives in, and the import endpoints that bundle calls. Which endpoint takes which layout is matched by position in the code and should be confirmed before relying on it.

| Columns | Bundle | Import endpoints in that bundle |
|---|---|---|
| `Name`, `Status`, `Currency`, `PaymentTerm`, `TaxRule`, `AccountReceivable`, `SaleAccount`, `PriceTier`, `Discount`, `CreditLimit`, `Carrier`, `SalesRepresentative`, `Location`, `TaxNumber`, `Tags`, `DisplayName`, `IsLegalEntity`, `ParentCustomer`, `IsBillParent`, `AttributeSet`, `AdditionalAttribute1`, `AdditionalAttribute2`, `AdditionalAttribute3`, `AdditionalAttribute4`, `AdditionalAttribute5`, `AdditionalAttribute6`, `AdditionalAttribute7`, `AdditionalAttribute8`, `AdditionalAttribute9`, `AdditionalAttribute10`, `Comments`, `ContactName`, `Phone`, `Fax`, `Email`, `Website`, `ContactComment`, `ContactDefault` | `Home2019` | `/Product/ImportInventoryListJson`, `/CustomerList/ImportCustomerListJson` |
| `Name`, `Status`, `Currency`, `PaymentTerm`, `TaxRule`, `AccountPayable`, `Carrier`, `Discount`, `TaxNumber`, `AttributeSet`, `AdditionalAttribute1`, `AdditionalAttribute2`, `AdditionalAttribute3`, `AdditionalAttribute4`, `AdditionalAttribute5`, `AdditionalAttribute6`, `AdditionalAttribute7`, `AdditionalAttribute8`, `AdditionalAttribute9`, `AdditionalAttribute10`, `Comments`, `ContactName`, `Phone`, `Fax`, `Email`, `Website`, `ContactComment`, `ContactDefault`, `ContactIncludeInEmail`, `JobTitle`, `MobilePhone` | `Home2019` | `/SupplierList/ImportSuppliersListJson` |
| `CustomerName`, `InvoiceNumber`, `CustomerReference`, `InvoiceDate`, `Amount`, `CurrencyConversionRate` | `OpeningBalances2019` | `/OpeningBalances/ImportOutstandingPurchasesJson`, `/OpeningBalances/ImportOutstandingSalesJson` |
| `Action`, `ProductSKU`, `ProductName`, `PriceTier`, `MarkupType`, `UseType`, `Value` | `Product2019` | `/Product/ImportMarkupPricesJson` |
| `Action`, `BaseSKU`, `BaseProductName`, `BaseUnitsOfMeasure`, `AdditionalUnitsOfMeasureSKU`, `AdditionalUnitsOfMeasureName`, `AdditionalUnitsOfMeasureProductName`, `NumberOfBaseUnitsInAdditionalUnit`, `IAmSellingThisProduct` | `Product2019` | `/Product/ImportSKUUpdatesJson`, `/Product/ImportUoMJson`, `/CustomerList/ImportCustomPricesJson`, `/Product/ImportCustomPricesJson` |
| `ProductCode`, `Quantity`, `AverageCost`, `Location`, `BatchOrSerialNumber`, `ExpiryDate_YYYYMMDD`, `ReceivedDate_YYYYMMDD` | `Product2019` | `/Product/ImportStockOnHandJson`, `/Product/ImportFixedAssetsJson` |
| `ProductSKU`, `ImageUrl`, `ImageFileName` | `Product2019` | `/Product/ImportImagesJson` |
| `ProductSKU`, `ImageUrl`, `ImageFileName` | `ProductFamily2019` | `/ProductFamily/ImportImagesJson` |
| `ProductCode`, `CommodityDescription`, `CommodityComposition` | `Shiptheory2019` | `/Product/ImportProductCommodityDetailsJson` |
| `ProductCode`, `ProductName`, `Bin`, `Unit`, `BatchSN`, `ExpiryDate_YYYYMMDD`, `QuantityOnHand`, `StocktakeQuantity`, `ReceivedDate_YYYYMMDD` | `Stocktake2019` | `/Stocktake/Import` |
