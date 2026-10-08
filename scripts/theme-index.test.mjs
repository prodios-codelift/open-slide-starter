import assert from 'node:assert/strict'
import { execFileSync } from 'node:child_process'
import { readdirSync, readFileSync } from 'node:fs'
import test from 'node:test'

const KEYS = [
  'id',
  'name',
  'description',
  'mode',
  'mood',
  'tone',
  'formality',
  'density',
  'scheme',
  'best_for',
  'avoid_for',
]

test('check-themes writes a sorted theme index from frontmatter', () => {
  execFileSync('node', ['scripts/check-themes.mjs'], { stdio: 'inherit' })
  const index = JSON.parse(readFileSync('themes/index.json', 'utf8'))
  const markdown = readdirSync('themes').filter((name) => name.endsWith('.md'))
  assert.equal(index.length, markdown.length)
  const ids = index.map((theme) => theme.id)
  assert.deepEqual(ids, [...ids].sort())
  for (const theme of index) {
    assert.deepEqual(Object.keys(theme), KEYS)
    assert.ok(Array.isArray(theme.mood))
    assert.ok(Array.isArray(theme.tone))
  }
  const orbit = index.find((theme) => theme.id === '8-bit-orbit')
  assert.equal(orbit.mode, 'dark')
  assert.ok(orbit.mood.includes('retro-tech'))
})
