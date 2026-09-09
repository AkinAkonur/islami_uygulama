"use strict";
const assert = require("node:assert/strict");
const sources = require("../data/source_catalog.json");
assert.ok(Array.isArray(sources));
assert.ok(sources.length >= 10);
const ids = new Set();
for (const source of sources) {
  assert.equal(typeof source.id, "string");
  assert.ok(!ids.has(source.id), `duplicate ${source.id}`);
  ids.add(source.id);
  assert.match(source.reference, /Quran \d+:/);
  assert.ok(source.summary.length >= 30);
  assert.ok(Array.isArray(source.keywords) && source.keywords.length >= 3);
}
assert.ok(sources.some((s) => s.reference === "Quran 2:255"));
assert.ok(sources.some((s) => s.reference === "Quran 5:6"));
assert.ok(sources.some((s) => s.reference === "Quran 9:60"));
console.log(`source catalog OK: ${sources.length}`);
