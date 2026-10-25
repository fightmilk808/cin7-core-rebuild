"""Turn Cin7's API Blueprint into structure: fields, parameters and body shapes.

Usage: python3 tools/apib_shapes.py <dearinventory.apib> data/public-api-shapes.json

Keeps names, types, lengths, required flags and allowed-value lists; turns example bodies into type outlines.
Drops prose and example values.
"""

import json
import re
import sys

GUID = re.compile(r"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
DATE = re.compile(r"^\d{4}-\d{2}-\d{2}([T ][\d:.]+Z?)?$")


def loads_lenient(text):
    text = re.sub(r"//[^\n\"]*$", "", text, flags=re.M)
    text = re.sub(r",(\s*[}\]])", r"\1", text)
    try:
        return json.loads(text)
    except ValueError:
        return None


def shape(v):
    if isinstance(v, dict):
        return {k: shape(x) for k, x in v.items()}
    if isinstance(v, list):
        if not v:
            return []
        merged = {}
        if all(isinstance(x, dict) for x in v):
            for x in v:
                for k, s in shape(x).items():
                    merged.setdefault(k, s)
            return [merged]
        return [shape(v[0])]
    if isinstance(v, bool):
        return "boolean"
    if isinstance(v, (int, float)):
        return "number"
    if v is None:
        return "null"
    if GUID.match(v):
        return "guid"
    if DATE.match(v):
        return "date"
    return "string"


def strip_tags(s):
    return re.sub(r"<[^>]+>", "", s).replace("`", "").strip()


def table_row(line):
    cells = [c.strip() for c in line.strip().strip("|").split("|")]
    return cells


def values_from_notes(notes):
    m = re.search(r"(?:Available|Possible|Allowed) values (?:are|is)[:\s]*(.+)", notes, re.I)
    if not m:
        return []
    vals = re.findall(r"`([^`]+)`", m.group(1))
    return vals[:60]


def collect_body(lines, i):
    """Collect an indented JSON body starting at line i; return (text, next index)."""
    body = []
    while i < len(lines) and not lines[i].strip():
        i += 1
    if i >= len(lines):
        return "", i
    while i < len(lines):
        ln = lines[i]
        s = ln.strip()
        if s.startswith(("+ Request", "+ Response", "+ Body", "+ Headers", "### ", "## ", "# ")) and body:
            break
        if s.startswith(("### ", "## ", "# ")) or (ln.startswith("+") and body):
            break
        body.append(ln)
        i += 1
    return "\n".join(body), i


def parse(path):
    lines = open(path, encoding="utf-8", errors="replace").read().split("\n")
    groups, models, webhooks = {}, {}, {}
    group = None
    op = None
    i = 0
    pending_model = None
    while i < len(lines):
        ln = lines[i]
        s = ln.strip()
        m = re.match(r"^# Group\s+(.+)$", s)
        if m:
            group = m.group(1).strip()
            groups.setdefault(group, {"tables": [], "operations": []})
            op = None
            i += 1
            continue
        if group is None:
            i += 1
            continue
        a = re.match(r'^<a name="([^"]+)"', s)
        if a:
            pending_model = a.group(1)
        m = re.match(r"^#{2,4}\s+Available [Ff]ields for\s+(.+)$", s) or (
            re.match(r"^#{2,4}\s+(.+?)\s*$", s) if pending_model and s.startswith("#") and "[" not in s else None)
        if m and i + 1 < len(lines) and lines[i + 1].strip().startswith("|"):
            name = strip_tags(m.group(1))
            rows = []
            j = i + 3
            header = [c.lower() for c in table_row(lines[i + 1])]
            while j < len(lines) and lines[j].strip().startswith("|"):
                c = table_row(lines[j])
                if len(c) >= 2:
                    rec = {"name": strip_tags(c[0]), "type": strip_tags(c[1])}
                    if len(c) > 2 and "length" in header[2:3]:
                        rec["length"] = c[2]
                    req = next((c[k] for k, h in enumerate(header) if h.startswith("required") and k < len(c)), "")
                    if req:
                        rec["required"] = req
                    notes = c[-1] if len(c) > 3 else ""
                    vals = values_from_notes(notes)
                    if vals:
                        rec["values"] = vals
                    if "read-only" in notes.lower():
                        rec["read_only"] = True
                    rows.append(rec)
                j += 1
            table = {"model": name, "anchor": pending_model, "fields": rows,
                     "kind": "fields" if len(header) > 1 and header[1].startswith("type") else "values"}
            if group == "Other Models" or pending_model:
                models[pending_model or name] = table
            if group != "Other Models":
                groups[group]["tables"].append(table)
            pending_model = None
            i = j
            continue
        m = re.match(r"^###\s+(.+?)\s*\[(GET|POST|PUT|DELETE|PATCH)\s*([^\]]*)\]", s)
        if m:
            op = {"title": m.group(1).strip(), "method": m.group(2), "path": m.group(3).strip(), "params": []}
            groups[group]["operations"].append(op)
            i += 1
            continue
        m = re.match(r"^##\s+(.+?)\s*\[([^\]]+)\]", s)
        if m:
            groups[group].setdefault("resources", []).append({"name": m.group(1), "path": m.group(2)})
            i += 1
            continue
        if op and re.match(r"^\+\s+(\w+)\s+\((optional|required)", s):
            p = re.match(r"^\+\s+(\w+)\s+\((optional|required)(?:,\s*([^)]+))?\)", s)
            op["params"].append({"name": p.group(1), "required": p.group(2) == "required", "type": (p.group(3) or "").strip()})
            i += 1
            continue
        wm = re.match(r"^\+\s+(\w+/\w+)\s+Response\s+200", s)
        if wm and group.strip() == "Webhooks":
            text, i = collect_body(lines, i + 1)
            data = loads_lenient(text)
            webhooks[wm.group(1)] = shape(data) if data is not None else sorted(set(re.findall(r'"(\w+)"\s*:', text)))
            continue
        if s.startswith("+ Body") and op is not None:
            text, i = collect_body(lines, i + 1)
            data = loads_lenient(text)
            kind = op.get("_next", "response")
            sh = shape(data) if data is not None else ({"_keys": sorted(set(re.findall(r'"(\w+)"\s*:', text)))} if text.strip() else None)
            if sh is not None:
                op.setdefault(kind, sh)
            continue
        if s.startswith("+ Request") and op is not None:
            op["_next"] = "request"
        elif s.startswith("+ Response") and op is not None:
            op["_next"] = "response"
            code = re.match(r"^\+ Response\s+(\d+)", s)
            if code and code.group(1) != "200":
                op["_next"] = "response_" + code.group(1)
        i += 1
    for g in groups.values():
        for o in g["operations"]:
            o.pop("_next", None)
    return {"groups": groups, "models": models, "webhooks": webhooks}


if __name__ == "__main__":
    src, out = sys.argv[1:3]
    data = parse(src)
    json.dump(data, open(out, "w"), indent=1)
    ops = sum(len(g["operations"]) for g in data["groups"].values())
    print(f"{len(data['groups'])} groups, {ops} operations, {len(data['models'])} models, {len(data['webhooks'])} webhook payloads")
