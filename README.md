# open-slide starter

The presentation workspace for Prodios Autopilot. Autopilot runs it in a sandbox; a builder agent writes the deck while the user edits, comments and exports it in open-slide's own UI.

- Deck: `slides/deck/index.tsx`. Style previews: `slides/previews/index.tsx` (pages A, B, C).
- Themes: `themes/*.md`, read by `create-slide` and `autopilot-previews`.
- Agent rules: `AGENTS.md` (the Prodios Autopilot section) and `.agents/skills/`.

## Scripts

- `npm run dev` — open-slide on `0.0.0.0:3000`.
- `npm run typecheck`
- `npm run build` — static build (not used by Autopilot).

## Core version and patch

`@open-slide/core` is pinned to `2.0.1`. `patches/@open-slide+core+2.0.1.patch` (applied on `npm install`) makes dev honour `build.showSlideBrowser`, hides restart and the agent badge, and lets `/s/<id>?overview` open the page grid. When bumping core: update the pin, re-apply the three changes, run `npx patch-package @open-slide/core`, and re-check. Never edit the built-in skills; they belong to core.

## Checks

`agent-browser eval "$(cat scripts/verify-slides.js)"` on `/s/<id>?p=<n>` reports build errors, missing slides, clipped text, content past the canvas and overlapping panels.
