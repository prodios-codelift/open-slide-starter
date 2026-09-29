# open-slide — Agent Guide

You are authoring **slides** in this repo. Every slide is arbitrary React code that you write.

## Hard rules

- Put your slide under `slides/<kebab-case-id>/`.
- The entry is `slides/<id>/index.tsx`.
- Put slide-specific images/videos/fonts under `slides/<id>/assets/`. For assets reused across decks or themes (logos, avatars), use the global `assets/` folder and import via `@assets/...`.
- Do **not** touch `package.json`, `open-slide.config.ts`, or other slides.
- Do not add dependencies. Use only `react` and standard web APIs.

## Which skill to use

- **Drafting a new deck** — use the `create-slide` skill. It walks through scoping questions, structure, and hand-off.
- **Applying inspector comments** (`@slide-comment` markers in a page) — use the `apply-comments` skill.
- **Creating or extracting a theme** — use the `create-theme` skill. Themes live as markdown under `themes/<id>.md` and are read by `create-slide` before authoring.
- **Resolving "this page" / "this element"** — when the user references the current slide or selection without naming it, consult the `current-slide` skill. It reads the dev server's `node_modules/.open-slide/current.json` to find which slide, page, and inspector-picked element they mean.
- **Writing a speech script / speaker notes** — use the framework's built-in feature: the `notes` export in the slide's `index.tsx`, index-aligned with the page array and shown in the presenter view. See the **Speaker notes** section of the `slide-authoring` skill. Never deliver a script as a markdown or text file.
- **Any other slide edit** — read the `slide-authoring` skill before writing. It is the technical reference for everything inside `slides/<id>/`: file contract, the 1920×1080 canvas, type scale, palette, layout, assets, self-review checklist, and anti-patterns. `create-slide` and `apply-comments` both defer to it for the *how*.

Keep this file short: hard rules only. All deeper guidance lives in the skills above.

## Prodios Autopilot

When this workspace runs inside Prodios Autopilot, a builder agent works here while the user watches the deck in a panel. These rules add to the hard rules above.

- **The user isn't in this session.** Use the answers in your prompt. If something important is still unclear, ask with the `ask_questions` tool — only what the prompt doesn't answer, all questions in one call, then stop; the answers arrive as your next message. Wherever a skill says `AskUserQuestion`, use `ask_questions` the same way. After answers arrive, re-read any file before editing it: the user may have edited the deck meanwhile.
- **Fixed ids.** The deck is `slides/deck/index.tsx` — never another id. Style previews are `slides/previews/index.tsx`: one slide, three pages, A = page 1, B = page 2, C = page 3.
- **Which skill:**
  - Style previews → `autopilot-previews`.
  - A new deck → `create-slide`. Its questions are answered in your prompt (theme, density, motion; the outline sets the page count), so don't ask them again. The slide id is `deck`. Skip its hand-off step and end with a short summary instead.
  - Changes to the deck → `slide-authoring`. Comments left with the inspector → `apply-comments` on `slides/deck`.
- **Themes** live in `themes/*.md` (one theme per file, nothing else in that folder).
- **Before you finish:**
  - `npm run typecheck` passes.
  - For every page: `agent-browser open "http://localhost:3000/s/<id>?p=<n>"`, then `agent-browser eval "$(cat scripts/verify-slides.js)"` returns no issues. Take a screenshot and look at it (see `.agents/skills/agent-browser/SKILL.md`).
  - If a page reports `build-error`, read the dev-server log (the path is in your prompt) and fix the cause.
- The dev server is already running on port 3000. Never start, stop or restart it, and never run `npm install`, `sync:skills` or package updates.
