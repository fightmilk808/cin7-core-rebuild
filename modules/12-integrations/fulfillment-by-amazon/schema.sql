-- Fulfillment by Amazon: one table per Cin7 Core data model, generated from data/models.json

create table "AmazonConf" (
  "ID" text,
  "ShopName" text,
  "Region" text,
  "Country" text,
  "DisplayName" text
);

create table "Carrier" (
  "Key" text,
  "Value" text
);

create table "ChannelMapping" (
  "ChannelName" text,
  "ConfigID" text,
  "FulfillmentBoxSetting" text,
  "LogisticsProviderSetting" text
);

create table "FulfillmentBoxOption" (
  "Name" text,
  "Description" text
);

create table "ImportItemsError" (
  "Line" integer,
  "BoxNumber" integer,
  "SKU" text,
  "ProductName" text,
  "UnitsPerBox" integer,
  "BoxWeight" numeric,
  "BoxWidth" numeric,
  "BoxHeight" numeric,
  "BoxDepth" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "LogisticsProviderOption" (
  "Name" text,
  "Description" text
);

create table "NewStatusStore" (
  "type" text,
  "description" text
);

create table "vEcsConfiguration" (
  "ID" text,
  "TenantID" text,
  "ShopName" text,
  "AccessToken" text,
  "RefreshToken" text,
  "PrimaryPriceTier" integer,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,
  "IsActive" boolean,
  "PickWhenOrderStatus" text,
  "ShippingTaxed" boolean,
  "SyncStockLevel" boolean,
  "ExportShippingInformation" boolean,
  "AutoInvoicingMode" text,
  "AutoFulfilmentMode" text,
  "ECSspecificParameter1" boolean,
  "ECSspecificParameter9" text,
  "ECSspecificParameter8" text,
  "ECSspecificParameter6" boolean,
  "ECSspecificParameter10" text,
  "CustomerName" text,
  "ECSTokenType" text,
  "RevenueAccount" text,
  "MoneySettlementBankAccount" text,
  "CustomSalesRepresentative" text,
  "UseAsMasterSource" boolean,
  "CompatibleToDEAR" boolean,
  "ManualMapping" boolean,
  "AutoCreateNewProductAllowed" boolean,
  "MatchProductByName" boolean,
  "LocationID" text,
  "EnableOrderRouting" boolean,
  "CreateAssembly" text,
  "IgnoreRestockForNotFulfilled" boolean,
  "IsConsolidateBySettlement" boolean,
  "GroupTransactionBy" text,
  "ConsolidationSubType" text
);

create table "vEcsOperationLog" (
  "ID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "Description" text,
  "Category" text,
  "Processed" boolean,
  "Type" integer,
  "UserName" text,
  "ConfigName" text,
  "ConfigType" text,
  "Disabled" boolean
);

create table "vEcsOverviewFulfilmentCustomersList" (
  "CustomerID" text,
  "CustomerName" text,
  "OrderCount" integer,
  "ConfigID" text
);

create table "vEcsOverviewOrdersList" (
  "Date" timestamptz,
  "SaleOrderNumber" text,
  "CustomerName" text,
  "Status" text,
  "FulfillmentOrderID" text,
  "SaleTaskID" text,
  "ConfigID" text
);

create table "vFFProduct" (
  "ID" text,
  "ConfigID" text,
  "FFProductID" text,
  "SKU" text,
  "FFSKU" text,
  "Name" text,
  "Price" numeric,
  "QuantityFulfillable" numeric,
  "QuantityWarehouse" numeric,
  "QuantityUnsellable" numeric,
  "QuantityReserved" numeric,
  "QuantityInbound" numeric,
  "Quantity" numeric,
  "ProductID" text,
  "MappedSKU" text,
  "MappedName" text,
  "ImageID" text,
  "AdditionalField1" text,
  "AdditionalField2" text,
  "AdditionalField3" text,
  "AdditionalField4" text,
  "AdditionalField5" text,
  "AdditionalField6" text,
  "AdditionalField7" text,
  "AdditionalField8" text,
  "AdditionalField9" text,
  "AdditionalField10" text,
  "IsLinktoAnotherLocation" boolean,
  "IsEligibleForBlankBox" boolean,
  "QuantityBlankBox" text
);

create table "vFulfillmentInboundShipment" (
  "InboundShipmentID" text,
  "ConfigID" text,
  "Currency" text,
  "CarrierName" text,
  "ShippingMethod" text,
  "TrackingNumber" text,
  "ShipmentPacking" text,
  "PaperType" text,
  "PageType" text,
  "ShipmentDate" timestamptz,
  "FromBox" integer,
  "ToBox" integer,
  "GeneratePaperType" text,
  "TransferOrderID" text,
  "HasPrintedLabels" boolean,
  "TransferOrderNumber" text,
  "OrderDate" timestamptz,
  "ShipmentID" text,
  "ShipmentStatus" text,
  "LabelPrepType" text,
  "BoxContentsSource" text,
  "ShipmentName" text,
  "DestinationFulfillmentCenterId" text,
  "AreCasesRequired" boolean,
  "ConfirmedNeedByDate" timestamptz,
  "AddressName" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "AddressDistrictOrCounty" text,
  "AddressCity" text,
  "AddressStateOrProvinceCode" text,
  "AddressCountryCode" text,
  "AddressStateOrProvinceCode" text,
  "AddressPostalCode" text,
  "TotalUnits" integer,
  "AmountPerUnit" numeric,
  "TotalAmount" numeric,
  "ShippingMode" text,
  "IsPartnered" boolean,
  "FreightReadyDate" timestamptz,
  "DeclaredValue" numeric,
  "BoxCount" integer,
  "IsEstimateCalculated" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentBoxContent" (
  "ID" text,
  "InboundShipmentID" text,
  "BoxNumber" integer,
  "ProductID" text,
  "SKU" text,
  "ProductName" text,
  "ProductPrice" numeric,
  "ProductTotalPrice" numeric,
  "UnitsPerBox" integer,
  "QuantityInCase" integer,
  "NumberOfBoxes" integer,
  "BoxWidth" numeric,
  "BoxHeight" numeric,
  "BoxDepth" numeric,
  "BoxWeight" numeric,
  "ASIN" text,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "ShipmentDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentEstimate" (
  "CalculationID" text,
  "ConfigID" text,
  "InboundShipmentID" text,
  "Carrier" text,
  "NumberOfBoxes" integer,
  "ShipmentWeight" numeric,
  "ShipmentCosts" numeric,
  "FreightReadyDate" timestamptz,
  "FreightClass" text,
  "DeclaredValue" numeric,
  "NumberOfPallets" integer,
  "PickUpDate" timestamptz,
  "Status" text,
  "CalculationDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentItem" (
  "LineID" text,
  "InboundShipmentID" text,
  "ConfigID" text,
  "ASIN" text,
  "HasPrintedLabels" boolean,
  "LocationID" text,
  "LocationName" text,
  "ProductCode" text,
  "ProductName" text,
  "ProductPrice" numeric,
  "ProductTotalPrice" numeric,
  "ProductID" text,
  "QuantityInCase" integer,
  "QuantityReceived" integer,
  "QuantityShipped" integer,
  "SKU" text,
  "ShipmentDate" timestamptz,
  "ShipmentStatus" text,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "Condition" text,
  "ReleaseDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentList" (
  "InboundShipmentID" text,
  "ConfigID" text,
  "Currency" text,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "HasPrintedLabels" boolean,
  "HasBillOfLading" boolean,
  "HasPalletLabels" boolean,
  "HasMultipleShipments" boolean,
  "CarrierName" text,
  "ShippingMethod" text,
  "ShipmentID" text,
  "ShipmentStatus" text,
  "TotalUnits" integer,
  "AmountPerUnit" numeric,
  "TotalAmount" numeric,
  "ShipmentDate" timestamptz,
  "SellerCentralLink" text,
  "LocationName" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentPallet" (
  "ID" text,
  "ConfigID" text,
  "InboundShipmentID" text,
  "NumberOfPallets" integer,
  "PalletWeight" numeric,
  "PalletDepth" numeric,
  "PalletWidth" numeric,
  "PalletHeight" numeric,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "ShipmentDate" timestamptz,
  "IsStackable" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentWrapper" (
  "ID" text,
  "HasErrors" boolean
);

create table "vInboundShipmentBoxLabes" (
  "FromBox" integer,
  "ToBox" integer,
  "TotalOfBoxes" integer,
  "PaperType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInboundShipmentCharges" (
  "ShippingCarrier" text,
  "NumberOfBoxes" integer,
  "ShipmentWeight" numeric,
  "BillableWeight" numeric,
  "EstimatedShipmentCost" numeric,
  "FreightReadyDate" timestamptz,
  "FreightClass" text,
  "DeclaredValue" numeric,
  "ContactPerson" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInboundShipmentPrintLabes" (
  "NumberOfBoxes" integer,
  "PaperType" text,
  "PaperSize" text,
  "ShipmentDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLogRecord" (
  "ID" text,
  "LogDate" text,
  "FulfillmentOrderId" text,
  "FFOrderID" text,
  "ChangesText" text,
  "ChangedBy" text
);

create table "vShortLocation" (
  "LocationID" text,
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);
