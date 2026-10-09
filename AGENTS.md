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

When this workspace runs inside Prodios Autopilot, a builder agent works here while the user watches the deck in a panel. The hard rules above still apply. The "Which skill to use" list does not: it sends this session into `create-slide`, `slide-authoring`, and `current-slide`. Follow only the list below.

- **The user isn't in this session.** Use the answers in your prompt. If something important is still unclear, ask with the `ask_questions` tool — only what the prompt doesn't answer, all questions in one call, then stop; the answers arrive as your next message. Wherever a skill says `AskUserQuestion`, use `ask_questions` the same way. After answers arrive, re-read any file before editing it: the user may have edited the deck meanwhile.
- **Fixed ids.** The deck is `slides/deck/index.tsx` — never another id. Style previews are `slides/previews/index.tsx`: one slide, three pages, A = page 1, B = page 2, C = page 3.
- **Which skill:**
  - Style previews → `autopilot-previews`.
  - A new deck → Write slides/deck/index.tsx from the theme file named in the prompt. Do not open create-slide or slide-authoring. Its questions are already answered. The slide id is `deck`. `export const design` must be `{ palette: { bg, text, accent }, fonts: { display, body }, typeScale: { hero, body }, radius }`. A flat design object crashes the canvas and the deck is blank. Load the theme's webfont stylesheet once at module top level, never inside a page component: create or update one `<link rel="stylesheet" id="osd-webfont-deck">` in `document.head` (`typeof document !== 'undefined'` guard) and set its `href`. A `<link>` or `@import` rendered inside a page registers the fonts again for every page. Every edit includes `path`. A rejected edit did not change the file.
  - Changes to the deck → `slide-authoring`. Comments left with the inspector → `apply-comments` on `slides/deck`.
- **Themes** live in `themes/*.md` (one theme per file, nothing else in that folder). `themes/index.json` is the picker catalog. Regenerate it with `npm run check-themes` when a theme file changes.
- **Before you finish:**
  - Run `scripts/check-slides.sh <id>` (`previews` or `deck`). Review that run's screenshots in one message.
  - When the summary has issues, or a screenshot shows a problem, fix every one of them in one edit, run the script once more, and review the new screenshots in one message. A clean first run does not run the script again. Do not run the script a third time. Do not run it again until `slides/<id>/index.tsx` has changed.
  - `no-deck` with `typecheck: pass` means the script already retried and still found no slide canvas. Check that `slides/<id>/index.tsx` has `export default` pages and `export const meta`, and fix what is missing. Run the script once more after a fix. If it still reports `no-deck`, stop and say so. Do not read `node_modules`, `open-slide.config.ts`, framework source or the dev-server log.
  - Do not run `agent-browser` yourself, write probe scripts, or edit the slide to experiment. A finding you cannot trace to the slide file is not yours to chase: name it in your summary and finish.
  - A harness error `File exists` means the directory is already there and the write did not save. Write the file again. It is not a slide bug.
  - Style previews write only `slides/previews/index.tsx`. Do not create `slides/deck` in that mode.
  - Name any issues that remain. If a page reports `build-error`, read the dev-server log (the path is in your prompt) and fix it in that same edit.
- The dev server is already running on port 3000. Never start, stop or restart it, and never run `npm install`, `sync:skills` or package updates.
