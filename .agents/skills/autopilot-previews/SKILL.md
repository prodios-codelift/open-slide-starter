---
name: autopilot-previews
description: Style previews for Prodios Autopilot. Use when the prompt says to make style previews — writes slides/previews with three cover pages (A, B, C) in three different themes chosen for the brief, and returns a table of them.
---

# Style previews (Autopilot)

Three cover pages in three looks, so the user can pick the deck's style before the deck is built. Copy palette, the webfont stylesheet URL, and the Title, Eyebrow, and Footer components from the three theme files. Do not open `slide-authoring` or `node_modules`. End with the summary table. Do not build the deck.

## Input (from the prompt)

- Brief: title, audience, occasion, outline.
- Density: minimal | light | standard | dense.
- Motion: static | subtle | rich.
- Exclude styles: theme ids already shown (may be empty).

## 1. Shortlist themes

Read `themes/index.json`. Do not open `themes/*.md` while shortlisting. A theme fits when its `mood`, `tone`, `formality` and `density` suit the brief, `best_for` is a reasonable match, and nothing in `avoid_for` applies. Leave out every id listed in **Exclude styles**.

## 2. Pick three directions

Unused themes fill slots in order A, then B, then C.

- **A — Expected:** the safest strong fit for this audience and occasion.
- **B — Elevated:** a more distinctive fit that still suits the occasion.
- **C — Memorable:** the boldest remaining fit.

A custom palette, fonts, and signature element fill a slot only when no unused theme remains for that slot. Fit first. When the brief clearly calls for a dark or formal deck, all three may be dark or formal as long as palettes and type differ.

## 3. Write `slides/previews/index.tsx`

Read `themes/<id>.md` for each picked id, in one turn. The id is the filename. Any two picks must differ in at least two of palette family, light vs dark (`mode`), and display typeface character (serif, geometric sans, grotesk, mono). If two collide, swap the weaker fit for the next index candidate and read that one file. Write only `slides/previews/index.tsx`. Do not write `slides/deck`. One slide, three pages, in order A, B, C:

- Each page is the deck's real cover: the brief's title, a subtitle from the occasion or audience, and an eyebrow such as the date or team. Only real deck content.
- Each page uses its theme's palette, webfont stylesheet URL, and its `Title`, `Eyebrow` and `Footer` components, renamed per page (`TitleA`, `TitleB`, `TitleC`, …) so all three fit in one file. Apply the theme's signature elements.
- Don't declare a `design` const — three looks can't share one. Use plain consts per page.
- `meta`: `{ title: 'Style previews', createdAt: '<ISO timestamp>' }`. No `meta.theme`. Set `createdAt` with `node -e "console.log(new Date().toISOString())"`.
- Motion: static → none; subtle → one entrance fade on the title; rich → a short staggered entrance.
- Never put theme names, directions, "Option A", "preview" or similar on the canvas.

## 4. Check

Run `scripts/check-slides.sh previews` once. Review that run's screenshots in one message. When the summary has issues, or a screenshot shows a problem, fix every one of them in one edit of `slides/previews/index.tsx`, run the script once more, and review the new screenshots in one message. A clean first run does not run the script again. Do not run the script a third time. Do not run it again until that file has changed. Name any issues that remain.

`no-deck` with `typecheck: pass` usually means the check's browser did not see the canvas, not that the file is broken. There are no screenshots. Confirm `slides/previews/index.tsx` has `export default` pages and `export const meta`. If it does, do not edit the file, do not run the script again, do not curl the page, do not grep `@open-slide`, and do not read `node_modules` or the dev-server log. Finish with the summary table and say the pages were not visually checked. A harness error `File exists` means the directory is already there and the write did not save. Write the file again. It is not a slide bug.

## 5. Summary

End with this table:

| letter | direction | theme | why it fits |
|---|---|---|---|
| a | Expected | `<theme id>` | one line |
| b | Elevated | `<theme id>` | one line |
| c | Memorable | `<theme id>` or `custom: <palette, fonts, signature element>` | one line |
