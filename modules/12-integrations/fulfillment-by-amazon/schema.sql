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
  "ConfigID" text,  -- -> IntegrationConfig
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
  "TenantID" text,  -- -> Tenant
  "ShopName" text,
  "AccessToken" text,
  "RefreshToken" text,
  "PrimaryPriceTier" integer,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,  -- -> Customer
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
  "LocationID" text,  -- -> Location
  "EnableOrderRouting" boolean,
  "CreateAssembly" text,
  "IgnoreRestockForNotFulfilled" boolean,
  "IsConsolidateBySettlement" boolean,
  "GroupTransactionBy" text,
  "ConsolidationSubType" text
);

create table "vEcsOperationLog" (
  "ID" text,
  "ConfigID" text,  -- -> IntegrationConfig
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
  "CustomerID" text,  -- -> Customer
  "CustomerName" text,
  "OrderCount" integer,
  "ConfigID" text  -- -> IntegrationConfig
);

create table "vEcsOverviewOrdersList" (
  "Date" timestamptz,
  "SaleOrderNumber" text,
  "CustomerName" text,
  "Status" text,
  "FulfillmentOrderID" text,  -- -> FulfillmentOrder
  "SaleTaskID" text,  -- -> Sale
  "ConfigID" text  -- -> IntegrationConfig
);

create table "vFFProduct" (
  "ID" text,
  "ConfigID" text,  -- -> IntegrationConfig
  "FFProductID" text,  -- -> FFProduct
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
  "ProductID" text,  -- -> Product
  "MappedSKU" text,
  "MappedName" text,
  "ImageID" text,  -- -> Blob (stored file)
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
  "InboundShipmentID" text,  -- -> InboundShipment
  "ConfigID" text,  -- -> IntegrationConfig
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
  "TransferOrderID" text,  -- -> StockTransfer
  "HasPrintedLabels" boolean,
  "TransferOrderNumber" text,
  "OrderDate" timestamptz,
  "ShipmentID" text,  -- -> ment
  "ShipmentStatus" text,
  "LabelPrepType" text,
  "BoxContentsSource" text,
  "ShipmentName" text,
  "DestinationFulfillmentCenterId" text,  -- -> DestinationFulfillmentCenter
  "AreCasesRequired" boolean,
  "ConfirmedNeedByDate" timestamptz,
  "AddressName" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "AddressDistrictOrCounty" text,
  "AddressCity" text,
  "AddressStateOrProvinceCode" text,
  "AddressCountryCode" text,
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
  "InboundShipmentID" text,  -- -> InboundShipment
  "BoxNumber" integer,
  "ProductID" text,  -- -> Product
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
  "TransferOrderID" text,  -- -> StockTransfer
  "TransferOrderNumber" text,
  "ShipmentDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentEstimate" (
  "CalculationID" text,  -- -> Calculation
  "ConfigID" text,  -- -> IntegrationConfig
  "InboundShipmentID" text,  -- -> InboundShipment
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
  "LineID" text,  -- -> Line (parent document's line)
  "InboundShipmentID" text,  -- -> InboundShipment
  "ConfigID" text,  -- -> IntegrationConfig
  "ASIN" text,
  "HasPrintedLabels" boolean,
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "ProductCode" text,
  "ProductName" text,
  "ProductPrice" numeric,
  "ProductTotalPrice" numeric,
  "ProductID" text,  -- -> Product
  "QuantityInCase" integer,
  "QuantityReceived" integer,
  "QuantityShipped" integer,
  "SKU" text,
  "ShipmentDate" timestamptz,
  "ShipmentStatus" text,
  "TransferOrderID" text,  -- -> StockTransfer
  "TransferOrderNumber" text,
  "Condition" text,
  "ReleaseDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentList" (
  "InboundShipmentID" text,  -- -> InboundShipment
  "ConfigID" text,  -- -> IntegrationConfig
  "Currency" text,
  "TransferOrderID" text,  -- -> StockTransfer
  "TransferOrderNumber" text,
  "HasPrintedLabels" boolean,
  "HasBillOfLading" boolean,
  "HasPalletLabels" boolean,
  "HasMultipleShipments" boolean,
  "CarrierName" text,
  "ShippingMethod" text,
  "ShipmentID" text,  -- -> ment
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
  "ConfigID" text,  -- -> IntegrationConfig
  "InboundShipmentID" text,  -- -> InboundShipment
  "NumberOfPallets" integer,
  "PalletWeight" numeric,
  "PalletDepth" numeric,
  "PalletWidth" numeric,
  "PalletHeight" numeric,
  "TransferOrderID" text,  -- -> StockTransfer
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
  "FulfillmentOrderId" text,  -- -> FulfillmentOrder
  "FFOrderID" text,  -- -> FulfilmentOrder
  "ChangesText" text,
  "ChangedBy" text
);

create table "vShortLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);
