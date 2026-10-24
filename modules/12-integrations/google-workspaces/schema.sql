-- Google Workspaces: one table per Cin7 Core data model, generated from data/models.json

create table "ContactInfo" (
  "ContactID" text,
  "ContactTypeName" text,
  "ContactType" text,
  "ContactName" text,
  "IsActive" boolean
);

create table "vGSuiteConfig" (
  "ConfigID" text,
  "HasSyncContacts" boolean,
  "HasExportData" boolean,
  "GD_DefaultDirID_Printing" text,
  "GD_DefaultDirPath_Printing" text,
  "GD_DefaultDirID_Reporting" text,
  "GD_DefaultDirPath_Reporting" text,
  "NeedsToReconnect" boolean,
  "ConnectedGoogleEmail" text,
  "RequiresFolderReselection" boolean
);

create table "vGSuiteLog" (
  "LogID" text,
  "Action" text,
  "Message" text,
  "LogDate" timestamptz
);
