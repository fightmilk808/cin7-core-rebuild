// Extract ExtJS UI component trees from Cin7 Core page bundles.
// Usage: node extract_ui.js <bundle_dir> <out.json>
const fs = require('fs');
const path = require('path');
const acorn = require('acorn');
const loose = require('acorn-loose');

const [, , dir, out] = process.argv;

const PROPS = ['xtype', 'text', 'title', 'fieldLabel', 'boxLabel', 'header', 'name', 'dataIndex', 'emptyText', 'tooltip',
  'iconCls', 'itemId', 'id', 'renderTo', 'region', 'format', 'displayField', 'valueField', 'queryMode', 'inputType',
  'allowBlank', 'readOnly', 'hidden', 'disabled', 'editable', 'multiSelect', 'width', 'height', 'flex', 'minWidth',
  'maxLength', 'align', 'sortable', 'html', 'cls', 'ui', 'scale', 'modal', 'closable', 'collapsible', 'resizable',
  'checked', 'labelWidth', 'labelAlign', 'menuDisabled', 'locked', 'summaryType', 'groupField', 'decimalPrecision',
  'minValue', 'maxValue', 'store', 'renderer', 'handler', 'layout', 'action', 'href', 'hrefTarget', 'plugins', 'selType',
  'selModel', 'features'];
const CHILD = ['items', 'columns', 'tbar', 'bbar', 'fbar', 'lbar', 'rbar', 'buttons', 'dockedItems', 'menu', 'tools',
  'editor', 'field'];
const UIKEYS = new Set(['xtype', 'fieldLabel', 'dataIndex', 'boxLabel', 'renderTo', 'columns', 'tbar', 'bbar',
  'buttons', 'dockedItems', 'handler', 'iconCls']);

function keyName(p) {
  if (p.type !== 'Property' || !p.key) return null;
  return p.key.type === 'Identifier' ? p.key.name : (p.key.type === 'Literal' ? String(p.key.value) : null);
}

function valueOf(v, src) {
  if (!v) return undefined;
  switch (v.type) {
    case 'Literal': return v.value;
    case 'TemplateLiteral': return v.quasis.map(q => q.value.cooked).join('${…}');
    case 'Identifier': return '@' + v.name;
    case 'MemberExpression': return '@' + src.slice(v.start, v.end).slice(0, 80);
    case 'FunctionExpression': case 'ArrowFunctionExpression':
      return v.id ? 'fn:' + v.id.name : 'fn';
    case 'UnaryExpression': return src.slice(v.start, v.end);
    case 'ObjectExpression': {
      const o = {};
      for (const p of v.properties) { const k = keyName(p); if (k === 'type' || k === 'ptype' || k === 'ftype' || k === 'mode' || k === 'align' || k === 'pack') o[k] = valueOf(p.value, src); }
      return Object.keys(o).length ? o : '{…}';
    }
    case 'ArrayExpression': {
      const xs = v.elements.filter(Boolean).map(e => valueOf(e, src));
      return xs.every(x => typeof x !== 'object' || x === null) ? xs : '[…]';
    }
    case 'ConditionalExpression': return [valueOf(v.consequent, src), valueOf(v.alternate, src)].filter(x => typeof x === 'string').join(' | ') || '?:';
    case 'CallExpression': return 'call:' + src.slice(v.callee.start, v.callee.end).slice(0, 60);
    case 'NewExpression': return 'new:' + src.slice(v.callee.start, v.callee.end).slice(0, 60);
    case 'BinaryExpression': return 'expr';
    default: return v.type;
  }
}

function isUi(obj) {
  return obj.properties.some(p => UIKEYS.has(keyName(p)) || (keyName(p) === 'text' && obj.properties.some(q => keyName(q) === 'handler' || keyName(q) === 'menu')));
}

function build(obj, src, cls) {
  const node = {};
  if (cls) node.class = cls;
  const kids = {};
  for (const p of obj.properties) {
    const k = keyName(p);
    if (!k) continue;
    if (CHILD.includes(k)) {
      const arr = p.value.type === 'ArrayExpression' ? p.value.elements : [p.value];
      const list = [];
      for (const e of arr) {
        if (!e) continue;
        if (e.type === 'ObjectExpression') list.push(build(e, src));
        else if (e.type === 'NewExpression' || (e.type === 'CallExpression' && /Ext\.create$/.test(src.slice(e.callee.start, e.callee.end)))) {
          const c = createOf(e, src); if (c) list.push(c);
        } else if (e.type === 'Literal' && typeof e.value === 'string') list.push({ ref: e.value });
        else if (e.type === 'Identifier') list.push({ ref: '@' + e.name });
      }
      if (list.length) kids[k] = list;
      else if (p.value.type === 'Identifier') kids[k] = [{ ref: '@' + p.value.name }];
    } else if (PROPS.includes(k)) {
      const v = valueOf(p.value, src);
      if (v !== undefined && v !== 'fn' && v !== '{…}' && v !== '[…]') node[k] = v;
      else if (k === 'handler' || k === 'renderer') node[k] = v;
    }
  }
  if (Object.keys(kids).length) node.children = kids;
  return node;
}

function createOf(call, src) {
  const a = call.arguments;
  if (!a.length || a[0].type !== 'Literal' || typeof a[0].value !== 'string') return null;
  const cls = a[0].value;
  if (/^Ext\.data\./.test(cls) || /Ext\.util\./.test(cls)) return null;
  if (a[1] && a[1].type === 'ObjectExpression') return build(a[1], src, cls);
  return { class: cls };
}

const result = {};
for (const f of fs.readdirSync(dir).filter(f => f.endsWith('.js')).sort()) {
  const src = fs.readFileSync(path.join(dir, f), 'utf8');
  let ast;
  try { ast = acorn.parse(src, { ecmaVersion: 'latest', sourceType: 'script', allowReturnOutsideFunction: true }); }
  catch (e) { ast = loose.parse(src, { ecmaVersion: 'latest' }); }
  const roots = [];
  const defines = [];
  const claimed = new Set();
  const visit = (n, parentClaimed) => {
    if (!n || typeof n.type !== 'string') return;
    let claimedHere = parentClaimed;
    if (n.type === 'CallExpression') {
      const callee = src.slice(n.callee.start, n.callee.end);
      if (/(^|\.)Ext\.create$/.test(callee) && !parentClaimed) {
        const c = createOf(n, src);
        if (c && (c.children || Object.keys(c).length > 1)) { roots.push(c); claimedHere = true; }
      } else if (/(^|\.)Ext\.define$/.test(callee) && n.arguments[0] && n.arguments[0].type === 'Literal' && n.arguments[1] && n.arguments[1].type === 'ObjectExpression') {
        const body = n.arguments[1];
        const ext = body.properties.find(p => keyName(p) === 'extend');
        const extend = ext ? valueOf(ext.value, src) : undefined;
        if (!/^Ext\.data\./.test(extend || '')) {
          const d = build(body, src, extend);
          d.define = n.arguments[0].value;
          const alias = body.properties.find(p => keyName(p) === 'alias');
          if (alias) d.alias = valueOf(alias.value, src);
          defines.push(d); claimedHere = true;
        }
      }
    } else if (n.type === 'ObjectExpression' && !parentClaimed && isUi(n)) {
      roots.push(build(n, src)); claimedHere = true;
    }
    for (const k in n) {
      if (k === 'type' || k === 'start' || k === 'end') continue;
      const v = n[k];
      if (Array.isArray(v)) v.forEach(x => x && typeof x.type === 'string' && visit(x, claimedHere));
      else if (v && typeof v.type === 'string') visit(v, claimedHere);
    }
  };
  visit(ast, false);
  result[f.replace(/\.js$/, '')] = { roots, defines };
  process.stderr.write(`${f}: ${roots.length} roots, ${defines.length} classes\n`);
}
fs.writeFileSync(out, JSON.stringify(result));
