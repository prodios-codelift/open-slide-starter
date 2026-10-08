import assert from 'node:assert/strict'
import { readFileSync } from 'node:fs'
import test from 'node:test'

const previews = readFileSync('.agents/skills/autopilot-previews/SKILL.md', 'utf8')
const agents = readFileSync('AGENTS.md', 'utf8')

test('previews read the theme index and check once', () => {
  assert.match(previews, /themes\/index\.json/)
  assert.doesNotMatch(previews, /Read only the frontmatter of every/)
  assert.match(previews, /scripts\/check-slides\.sh previews/)
  assert.match(previews, /Do not run the script a third time/)
  assert.match(
    previews,
    /custom palette, fonts, and signature element fill a slot only when no unused theme remains/,
  )
  assert.doesNotMatch(previews, /repeat until every page is clean/)
})

test('autopilot deck mode skips create-slide and uses the check script', () => {
  assert.match(agents, /Write slides\/deck\/index\.tsx/)
  assert.match(agents, /Do not open create-slide/)
  assert.match(agents, /scripts\/check-slides\.sh/)
  assert.match(agents, /Do not run the script a third time/)
  assert.doesNotMatch(agents, /A new deck → `create-slide`/)
})
