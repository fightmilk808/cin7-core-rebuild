---
name: cin7-import-files
description: Build a CSV file in the column layout Cin7 Core (DEAR Inventory) expects for an import or line upload - customers, suppliers, stock on hand, price markups, units of measure, images, stocktake counts, document lines - from a person's spreadsheet or description. Maps their columns onto Cin7's, flags missing and unknown ones, and writes the file. Use when someone asks to prepare, fix or check a Cin7 import file, asks "what columns does the X import take", or wants their spreadsheet converted for Cin7. Builds the file only; a person uploads it.
---

# Cin7 import files

This repo records the column layouts the import pages validate. You turn a spreadsheet into one of those layouts. You never upload it.

## Sources

| Need | Look in |
|---|---|
| Line uploads into a document (sale/purchase lines, stocktake, transfer, write-off) | the first table in [IMPORTS.md](../../docs/IMPORTS.md) |
| Master-data imports (customers, suppliers, stock on hand, markups, UoM, images) | the second table in [IMPORTS.md](../../docs/IMPORTS.md), or [imports.json](../../data/imports.json) |
| Which page and button runs it | the module `UI.md` for that area, e.g. [inventory](../../modules/04-inventory/UI.md), [sale](../../modules/06-sale/UI.md), [purchase](../../modules/05-purchase/UI.md) |

Look a layout up, don't recall it:

```bash
python3 -c "import json;d=json.load(open('data/imports.json'));print(json.dumps(d['/Product/ImportStockOnHandJson'],indent=1))"
python3 -c "import json;[print(k) for k in json.load(open('data/imports.json'))]"   # every import
```

## Steps

1. **Pick the import.** Match what the person wants to a row in IMPORTS.md. If it isn't there (see below), say so and stop guessing.
2. **Read their data.** List their headers and a few rows.
3. **Map columns.** Make a table: their header, Cin7 column, and what you changed. Cin7 column names are exact, including case and suffixes such as `ExpiryDate_YYYYMMDD`.
4. **Flag the gaps.** Report Cin7 columns with no source, their columns with no Cin7 home, and any value you had to reshape. Ask rather than invent.
5. **Write the CSV** with the Cin7 header row first, in the map's column order, one record per row. Use `WIDGET-01` style values only in examples, never in the real file.
6. **Hand it over** with the mapping table and the gap list, and tell the person which page to upload it on.

## What the map does and doesn't say

- It gives column names and, for `…_YYYYMMDD` columns, the date format (`YYYYMMDD`).
- It does **not** record which columns are required, allowed values (for example `Status`, `MarkupType`, `UseType`, `Action`), number formats, row limits, or how a product-master or BOM import is laid out. None of those are in the repo.
- For any of those, have the person download Cin7's own template from the import page (the document uploads have a download, edit, upload cycle) or check Cin7's help page. Copy values from that, not from memory.
- IMPORTS.md warns that matching a master-data layout to its endpoint is by position in the page code and should be confirmed. For example `/Product/ImportInventoryListJson` appears with the same columns as the customer import, which looks wrong for a product import. Treat that mapping as unconfirmed.

## Rules

1. **Build, never upload.** Imports write data. Don't call the `/…Import…Json` endpoints or `/Stocktake/Import`; the map marks them write. A person uploads the file in Cin7.
2. **Exact headers.** Don't rename, reorder away from the map, or add columns Cin7 doesn't list.
3. **Don't fill unknown values.** A blank you flagged beats a plausible guess in a file that changes stock or prices.
4. **Keep dates as `YYYYMMDD`** only where the column name says so; for other date columns, ask or use Cin7's template.
5. **Don't change the source spreadsheet.** Write the new file beside it.
6. **No real data in this repo.** Examples and test files use invented rows.

## When it fails

| Symptom | Likely cause |
|---|---|
| Cin7 rejects rows with a message per row | A value doesn't match a Cin7 record or format (each column has a matching `…Error` field on the page). Fix the value, not the header. |
| Columns come through empty | Header text or case differs from the map: check the first line. |
| The layout you need isn't in IMPORTS.md | The map doesn't cover it (product master, BOMs, price-tier lists by name). Get Cin7's template and say so. |
| Dates read wrong | A `…_YYYYMMDD` column got a different format. |
