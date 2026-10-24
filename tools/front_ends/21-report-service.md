# Report service

A separate ASP.NET app at `reporting.dearsystems.com` that renders every report as a DevExpress pivot grid. The main app's
`/Report/<Name>` page is only a frame around it. Report names, scripts and columns are in
[`11-reports`](../11-reports/README.md).

## How it works

1. **Hand-over.** The main app renders `/Report/<Name>` with a frame whose `src` is
   `https://reporting.dearsystems.com/Report/<Name>?requestID=report<guid>&layoutName=<layout>`. The `requestID` is a one-time
   token minted by the main app; the report service has no login of its own.
2. **Page.** The report page loads its own copy of the shell (`Main2019_rep`), one report script
   (`/js/<Script>_lang_en-us`), DevExpress (`DXR.axd`), `ReportService` and AngularJS.
3. **Data.** Comes back through DevExpress callbacks posted to the same `/Report/<Name>` URL, not a JSON API:
   - Load or refresh: `pivotGrid.PerformCallback({RequestID, FromDate, ToDate, Search, LayoutName, OperationName, Currency, …})`.
     `OperationName` is `ChangeLayout` (first load or layout switch), `ResetLayout` or `CustomCallback`. Each report adds its
     own filters through `window.reportAdditionalFilters`. The client refuses a period over one year and overlapping callbacks.
   - Drill-down: a GridView callback with `RowIndex`, `ColumnIndex`, `ColumnFieldName` and the pivot state, shown in a pop-up.
   - Export: hidden form `rptExport` submitted with `ExportTo=<format>` (and `GDriveDirId` for Google Drive); a file download.
   - Errors: `Report_CallbackError` turns a server message into a `postMessage` the parent shows as an alert.
4. **Layouts and currencies** come from `/api/Report_vReportLayout` and `/api/Report_vReportCurrency`; layouts are saved and
   deleted per user (`/Report/DeleteLayout`).
5. **Frame ↔ parent** talk by `postMessage`: `resize`, `backtoreports`, `notification`, `dlgExportToGDrive`, `layout_changed`.
   The parent keeps the chosen layout in `localStorage` as `report_layout_<tenant>_<user>_<report>`.
6. **Stored reports.** Some reports (inventory velocity, sales demand forecast) keep computed results and have a
   `…Recalculate` POST.

## How to rebuild it

Run a reporting service beside the app that accepts a short-lived signed token from the main app, loads the report
definition (source query, columns, default layout), and serves a pivot grid with server-side paging, filtering, drill-down
and export. Any pivot component can replace DevExpress; keep the token hand-over, the per-user saved layouts and the
`postMessage` contract with the parent page.
