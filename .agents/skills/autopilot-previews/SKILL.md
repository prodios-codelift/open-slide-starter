---
name: autopilot-previews
description: Style previews for Prodios Autopilot. Use when the prompt says to make style previews — writes slides/previews with three cover pages (A, B, C) in three different themes chosen for the brief, and returns a table of them.
---

# Style previews (Autopilot)

Three cover pages in three looks, so the user can pick the deck's style before the deck is built. For everything about writing pages (canvas, type scale, fonts, assets), follow the `slide-authoring` skill.

## Input (from the prompt)

- Brief: title, audience, occasion, outline.
- Density: minimal | light | standard | dense.
- Motion: static | subtle | rich.
- Exclude styles: theme ids already shown (may be empty).

## 1. Shortlist themes

Read only the frontmatter of every `themes/*.md`. A theme fits when its `mood`, `tone`, `formality` and `density` suit the brief, `best_for` is a reasonable match, and nothing in `avoid_for` applies. Leave out every id listed in **Exclude styles**.

## 2. Pick three directions

- **A — Expected:** the safest strong fit for this audience and occasion.
- **B — Elevated:** a more distinctive fit that still suits the occasion.
- **C — Memorable:** the boldest option that still serves the brief. Use a theme when one fits; otherwise design a custom look (palette, display and body fonts, one signature element).

Fit first. Then check difference: any two picks must differ in at least two of palette family, light vs dark (`mode`), and display typeface character (serif, geometric sans, grotesk, mono). If two collide, swap the weaker fit for the next-best candidate. When the brief clearly calls for a dark or formal deck, all three may be dark or formal as long as palettes and type differ.

## 3. Write `slides/previews/index.tsx`

Read the full file of each picked theme. Write one slide with three pages, in order A, B, C:

- Each page is the deck's real cover: the brief's title, a subtitle from the occasion or audience, and an eyebrow such as the date or team. Only real deck content.
- Each page uses its theme's palette and fonts (load webfonts per `references/webfonts.md` in `slide-authoring`) and its `Title`, `Eyebrow` and `Footer` components, renamed per page (`TitleA`, `TitleB`, `TitleC`, …) so all three fit in one file. Apply the theme's signature elements.
- Don't declare a `design` const — three looks can't share one. Use plain consts per page.
- `meta`: `{ title: 'Style previews', createdAt: '<now>' }` (createdAt rules in `slide-authoring`). No `meta.theme`.
- Motion: static → none; subtle → one entrance fade on the title; rich → a short staggered entrance.
- Never put theme names, directions, "Option A", "preview" or similar on the canvas.

## 4. Check

Run `npm run typecheck`. For `?p=1`, `?p=2` and `?p=3`: open `http://localhost:3000/s/previews?p=<n>`, run `scripts/verify-slides.js`, take a screenshot and look at it. Fix and repeat until every page is clean.

## 5. Summary

End with this table:

| letter | direction | theme | why it fits |
|---|---|---|---|
| a | Expected | `<theme id>` | one line |
| b | Elevated | `<theme id>` | one line |
| c | Memorable | `<theme id>` or `custom: <palette, fonts, signature element>` | one line |
