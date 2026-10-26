---
name: cin7-reports
description: Pick the right built-in Cin7 Core (DEAR Inventory) report for a question, say which filters and columns it has, and say how to get the numbers - run it in the web app, understand the internal report-service calls the map records, or fall back to the nearest public API v2 list endpoint. Use when someone asks "which Cin7 report shows stock value by location", "sales by customer last quarter", "what columns does the X report have", "can I pull a report through the API", or is rebuilding Cin7's reports. Read-only.
---

# Cin7 reports

The map records 86 reports as pages and 69 with their columns. It records **structure only**: names, filters, columns. It does not record how any figure is calculated, what a "value" or "available" includes, or what the date-period choices are.

## Pick the report

Columns live in `data/report-columns.txt`, one report per line: `Name ~ Script ~ Title ~ col|col|col`.

```bash
# which reports have a "Location" and a "Value" column?
awk -F' ~ ' '$4 ~ /(^|\|)Location(\||$)/ && $4 ~ /(^|\|)Value(\||$)/ {print $1" - "$3}' data/report-columns.txt
# one report's columns, one per line
grep '^StockValueInventoryAging ~' data/report-columns.txt | awk -F' ~ ' '{print $4}' | tr '|' '\n'
```

Then read its row in [`modules/11-reports/README.md`](../../modules/11-reports/README.md#reports-their-filters-and-columns) (title, script, filters, columns).

| Question | Report (name from the map) | Filters the map records |
|---|---|---|
| Stock value by location | `StockValueInventoryAging` (columns include Location, Quantity, Value, Range) | `Interval` |
| Stock on hand, allocated, on order | `InventoryStockLevel` | `OnlyNonZero` |
| Sales by customer | `SalesByCustomer` (Customer, Month, No. of sales, Sales total) | `ToDate` |
| Sales by product | `SalesByProductSummary` (and `SalesByProductDetails`) | `FromDate`, `ToDate`, `IncludeAllCOGS` (Summary) |

For anything else, search the columns file first, then confirm the match by title in the README table. If two reports fit, say so and let the person choose.

## Filters

`data/report-filters.json` is keyed by **script** name (e.g. `SalesByCustomerReport2019`), not report name. Every report sends `RequestID`, `Search`, `LayoutName`, `OperationName`; `params` lists the extras and the control each comes from.

```bash
jq '.SalesByCustomerReport2019.params | keys' data/report-filters.json
```

Reports whose script is the generic `Report2019` have no entry: no extra filters are recorded for them. The page's date controls (period picker, From, To) are in `data/report-ui.json` under the same script key. The values the period picker offers are **not** recorded: pick explicit From/To dates instead of guessing names like "last quarter".

## How to get the data

| Route | What the map says | Use it |
|---|---|---|
| **Web app** | `/Report/<Name>` is a frame around a pivot grid; export buttons are Excel (with or without totals), PDF, RTF. | Default. Tell the person which report, filters and layout to choose. |
| **Report service** | Data comes from DevExpress callbacks posted to `/Report/<Name>` with a one-time `requestID` minted by the signed-in app ([module 21](../../modules/21-report-service/README.md)). Not a JSON API. | **Internal: described, not callable.** The companion `cin7` CLI and MCP send public API calls only. Use it to explain how a report loads, not to fetch one. |
| **Public API v2** | No report endpoints (module 11 lists 0 public ops). | Closest list endpoint, below. |

Closest public lists (`data/public-api.csv`; parameters in [`docs/PUBLIC-API.md`](../../docs/PUBLIC-API.md)): `/ref/productavailability` (stock by product and location), `/saleList`, `/purchaseList`, `/product`, `/stockTransferList`, `/production/orderList`. List rows are summaries and lines need one detail call each. The result will not match a report to the cent, because the report's rules are not in the map.

```bash
python3 -c "import csv;[print(r['method'],r['path'],r['query']) for r in csv.DictReader(open('data/public-api.csv')) if 'availability' in r['path'].lower()]"
```

## Rules

1. **Name the report from the map.** Never invent a report, filter or column. If it is not in the files, say it is not recorded.
2. **Read-only.** Do not call the recalculate or layout-delete endpoints in `data/report-service-endpoints.csv` (`…Recalculate` POSTs, `/Report/DeleteLayout`).
3. **Don't promise matching totals.** Say which report and which public list are comparable and that the calculations are not mapped.
4. **Use the CLI/MCP for API reads**: `search_operations` first, then `read` ([cin7-core skill](https://github.com/fightmilk808/cin7-core-cli)). 60 calls a minute applies.

## When it fails

| Symptom | Cause |
|---|---|
| Report not in `report-columns.txt` | The map has 69 of 86 with columns; the financial reports (Balance Sheet, P&L, GL) are their own pages, see the README table. |
| `jq` returns `null` | Used the report name; filters are keyed by script name. |
| API totals differ from the report | Different rules; ask the person which figure they trust. |
