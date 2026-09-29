// Checks every themes/*.md: single-line frontmatter with our selection keys,
// create-theme's sections plus ours, and a size limit. Exits 1 on any problem.
//
//   npm run check-themes
import { readdir, readFile } from 'node:fs/promises';
import path from 'node:path';

const THEMES_DIR = path.resolve('themes');
const MAX_BYTES = 12 * 1024;
const REQUIRED_KEYS = [
  'name', 'description', 'mode', 'mood', 'tone', 'formality',
  'density', 'scheme', 'best_for', 'avoid_for', 'source',
];
const ENUMS = {
  mode: ['dark', 'light'],
  formality: ['low', 'medium', 'high'],
  density: ['low', 'medium', 'high'],
  scheme: ['dark', 'light', 'mixed'],
};
const REQUIRED_HEADINGS = [
  '## Palette', '## Typography', '## Layout', '## Fixed components', '### Title',
  '### Footer', '## Motion', '## Aesthetic', '## Example usage',
  '## Signature elements', "## Do / Don't",
];

// Same line-based parse as open-slide's themes plugin: one `key: value` per line.
function parseFrontmatter(raw) {
  const match = raw.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n?([\s\S]*)$/);
  if (!match) return null;
  const data = {};
  for (const line of match[1].split(/\r?\n/)) {
    const m = line.match(/^([A-Za-z0-9_-]+)\s*:\s*(.*)$/);
    if (m) data[m[1]] = m[2].trim().replace(/^"(.*)"$/, '$1');
  }
  return { data, body: match[2] };
}

function problemsFor(file, raw) {
  const problems = [];
  if (Buffer.byteLength(raw) > MAX_BYTES) problems.push(`larger than ${MAX_BYTES} bytes`);
  const parsed = parseFrontmatter(raw);
  if (!parsed) return [...problems, 'no frontmatter'];
  const { data, body } = parsed;
  for (const key of REQUIRED_KEYS) {
    if (!data[key]) problems.push(`missing frontmatter key ${key}`);
  }
  for (const [key, allowed] of Object.entries(ENUMS)) {
    if (data[key] && !allowed.includes(data[key])) problems.push(`${key} must be one of ${allowed.join(', ')}`);
  }
  for (const key of ['mood', 'tone']) {
    if (data[key] && !/^\[.+\]$/.test(data[key])) problems.push(`${key} must be an inline list [a, b]`);
  }
  if (data.source && !/^(preset|bold:[a-z0-9-]+)$/.test(data.source)) problems.push('source must be preset or bold:<slug>');
  if (data.source === 'preset' && data.derived !== 'true') problems.push('presets need derived: true');
  let last = -1;
  for (const heading of REQUIRED_HEADINGS) {
    const at = body.indexOf(`\n${heading}\n`);
    if (at === -1) problems.push(`missing section ${heading}`);
    else if (at < last) problems.push(`section ${heading} is out of order`);
    else last = at;
  }
  if (!body.includes('useSlidePageNumber')) problems.push('Footer must use useSlidePageNumber');
  return problems;
}

const files = (await readdir(THEMES_DIR)).filter((name) => name.endsWith('.md'));
let failed = 0;
for (const name of files) {
  const problems = problemsFor(name, await readFile(path.join(THEMES_DIR, name), 'utf8'));
  if (problems.length) {
    failed++;
    console.log(`✗ ${name}\n  - ${problems.join('\n  - ')}`);
  }
}
console.log(`${files.length - failed}/${files.length} themes valid`);
process.exit(failed ? 1 : 0);
