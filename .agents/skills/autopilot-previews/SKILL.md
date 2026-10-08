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

Read `themes/index.json`. Do not open `themes/*.md` while shortlisting. A theme fits when its `mood`, `tone`, `formality` and `density` suit the brief, `best_for` is a reasonable match, and nothing in `avoid_for` applies. Leave out every id listed in **Exclude styles**.

## 2. Pick three directions

Unused themes fill slots in order A, then B, then C.

- **A — Expected:** the safest strong fit for this audience and occasion.
- **B — Elevated:** a more distinctive fit that still suits the occasion.
- **C — Memorable:** the boldest remaining fit.

A custom palette, fonts, and signature element fill a slot only when no unused theme remains for that slot. Fit first. When the brief clearly calls for a dark or formal deck, all three may be dark or formal as long as palettes and type differ.

## 3. Write `slides/previews/index.tsx`

Read the full file of each picked theme in one turn. Any two picks must differ in at least two of palette family, light vs dark (`mode`), and display typeface character (serif, geometric sans, grotesk, mono). If two collide, swap the weaker fit for the next index candidate and read that one file. Write one slide with three pages, in order A, B, C:

- Each page is the deck's real cover: the brief's title, a subtitle from the occasion or audience, and an eyebrow such as the date or team. Only real deck content.
- Each page uses its theme's palette and fonts (load webfonts per `references/webfonts.md` in `slide-authoring`) and its `Title`, `Eyebrow` and `Footer` components, renamed per page (`TitleA`, `TitleB`, `TitleC`, …) so all three fit in one file. Apply the theme's signature elements.
- Don't declare a `design` const — three looks can't share one. Use plain consts per page.
- `meta`: `{ title: 'Style previews', createdAt: '<now>' }` (createdAt rules in `slide-authoring`). No `meta.theme`.
- Motion: static → none; subtle → one entrance fade on the title; rich → a short staggered entrance.
- Never put theme names, directions, "Option A", "preview" or similar on the canvas.

## 4. Check

Run `scripts/check-slides.sh previews`. Review that run's screenshots in one message. When the summary has issues, or a screenshot shows a problem, fix every one of them in one edit, run the script once more, and review the new screenshots in one message. A clean first run does not run the script again. Do not run the script a third time. Name any issues that remain.

## 5. Summary

End with this table:

| letter | direction | theme | why it fits |
|---|---|---|---|
| a | Expected | `<theme id>` | one line |
| b | Elevated | `<theme id>` | one line |
| c | Memorable | `<theme id>` or `custom: <palette, fonts, signature element>` | one line |
