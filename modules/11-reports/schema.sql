-- Reports: one table per Cin7 Core data model, generated from data/models.json

create table "Layout" (
  "Layout" text
);

create table "MailingList" (
  "ID" text,
  "Name" text
);

create table "NameValue" (
  "Name" text,
  "Value" text
);

create table "ScheduledReport" (
  "ReportName" text,
  "Title" text,
  "GroupName" text
);

create table "ScheduledReportWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "TenantLocation" (
  "ID" text,
  "Name" text
);

create table "VATReturn" (
  "Id" text,
  "Status" text,
  "PublishDate" timestamptz,
  "Name" text
);

create table "vMailingSettingsWrapper" (
  "FakeID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vReorderSuggestionGroup" (
  "ID" text,
  "LocationID" text,
  "LocationName" text,
  "MailingListID" text,
  "LocationName" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vReport" (
  "id" text,
  "name" text,
  "status" text,
  "createDate" timestamptz,
  "createdByUserName" text,
  "reportTypeId" text,
  "reportDate" text,
  "publishDate" timestamptz
);

create table "vReportCurrency" (
  "Currency" text,
  "DisplayCurrency" text
);

create table "vReportGenerationLog" (
  "ReportGenerationLogID" text,
  "ReportID" text,
  "ReportName" text,
  "ReportTitle" text,
  "StartExecutionDate" timestamptz,
  "EndExecutionDate" timestamptz,
  "FileID" text,
  "FileFormat" text,
  "FileName" text,
  "GenerationStatus" text,
  "GenerationMessage" text,
  "IsEmailSended" text,
  "EmailSendingResult" text,
  "ExternalDownloadLink" text
);

create table "vReportLayout" (
  "Fakeid" text,
  "ReportName" text,
  "LayoutName" text,
  "Layout" text
);

create table "vReportSalesDemandTemplate" (
  "TemplateName" text,
  "TemplateID" text
);

create table "vScheduledReportSettings" (
  "ReportID" text,
  "IsActive" boolean,
  "ReportScheduleName" text,
  "ReportName" text,
  "LayoutName" text,
  "Currency" text,
  "DatePeriod" text,
  "DatePeriodValue" text,
  "Frequency" text,
  "FrequencyValue" text,
  "ReportFormat" text,
  "StartExecutionDate" timestamptz,
  "LastExecutionDate" timestamptz,
  "LastExecutionStatus" text,
  "MailingListIDs" text,
  "MailingList" text,
  "GenerationStatus" text,
  "GenerationMessage" text,
  "IsActiveAdmin" boolean,
  "ReportTitle" text,
  "InventoryIntervalDays" integer,
  "ValidationText" text,
  "ValidationState" text,
  "UniqueParameter1" text,
  "UniqueParameter2" text,
  "UniqueParameter3" text,
  "SaveToGDrive" boolean,
  "GD_DirID" text,
  "GD_DirPath" text,
  "GDriveNeedsFolderUpdate" boolean,
  "ReportMode" text
);

create table "vTenantSystemLog" (
  "ID" text,
  "Date" timestamptz,
  "TaskID" text,
  "Category" text,
  "Message" text,
  "Reference" text,
  "UserName" text
);
