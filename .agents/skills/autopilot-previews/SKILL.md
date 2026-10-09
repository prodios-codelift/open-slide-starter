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

Read `themes/<id>.md` for every picked id, in one turn, before you write anything. A theme you did not read cannot be used: its palette, fonts and components are only in its file. The id is the filename. Any two picks must differ in at least two of palette family, light vs dark (`mode`), and display typeface character (serif, geometric sans, grotesk, mono). If two collide, swap the weaker fit for the next index candidate and read that one file. Write only `slides/previews/index.tsx`. Do not write `slides/deck`. One slide, three pages, in order A, B, C:

The file has this shape. Pages are plain components; `Page` comes from `@open-slide/core`, and nothing else in the framework needs to be read:

```tsx
import type { Page } from '@open-slide/core'

function loadFont(id: string, href: string) {
  if (typeof document === 'undefined') return
  let link = document.getElementById(id) as HTMLLinkElement | null
  if (!link) {
    link = document.createElement('link')
    link.id = id
    link.rel = 'stylesheet'
    document.head.appendChild(link)
  }
  link.href = href
}

loadFont('osd-webfont-previews-a', '<theme A stylesheet URL>')
loadFont('osd-webfont-previews-b', '<theme B stylesheet URL>')
loadFont('osd-webfont-previews-c', '<theme C stylesheet URL>')

const CoverA: Page = () => <div style={{ width: '100%', height: '100%' }}>{/* page A */}</div>
const CoverB: Page = () => <div style={{ width: '100%', height: '100%' }}>{/* page B */}</div>
const CoverC: Page = () => <div style={{ width: '100%', height: '100%' }}>{/* page C */}</div>

export default [CoverA, CoverB, CoverC] satisfies Page[]
export const meta = { title: 'Style previews', createdAt: '<ISO timestamp>' }
```

- Each page is the deck's real cover: the brief's title, a subtitle from the occasion or audience, and an eyebrow such as the date or team. Only real deck content.
- Each page uses its theme's palette, webfont stylesheet URL, and its `Title`, `Eyebrow` and `Footer` components, renamed per page (`TitleA`, `TitleB`, `TitleC`, …) so all three fit in one file. Apply the theme's signature elements.
- Load each webfont stylesheet with the `loadFont` call from the file shape above, once, at module top level, never inside a page component: create or update one `<link rel="stylesheet">` in `document.head` (`typeof document !== 'undefined'` guard) with id `osd-webfont-previews-a`, `-b` and `-c`, and set its `href` to the theme's stylesheet URL. A `<link>` or `@import` rendered inside a page registers the fonts again for every page.
- Don't declare a `design` const — three looks can't share one. Use plain consts per page.
- `meta`: `{ title: 'Style previews', createdAt: '<ISO timestamp>' }`. No `meta.theme`. Set `createdAt` with `node -e "console.log(new Date().toISOString())"`.
- Motion: static → none; subtle → one entrance fade on the title; rich → a short staggered entrance.
- Never put theme names, directions, "Option A", "preview" or similar on the canvas.

## 4. Check

Run `scripts/check-slides.sh previews` once. If you can view images, `read` the screenshot paths the script printed, all in one message, and review them. If `read` returns no image, skip the screenshot review and say so in your summary. When the summary has issues, or a screenshot shows a problem, fix every one of them in one edit of `slides/previews/index.tsx`, run the script once more, and review the new screenshots in one message if you can view images. A clean first run does not run the script again. Do not run the script a third time. Do not run it again until that file has changed. Name any issues that remain.

`no-deck` with `typecheck: pass` means the script already retried and still found no slide canvas. There are no screenshots. Check that `slides/previews/index.tsx` has `export default` pages and `export const meta`, and fix what is missing. Run the script once more after a fix. If it still reports `no-deck`, stop and say so. Do not curl the page, do not grep `@open-slide`, and do not read `node_modules` or the dev-server log. Do not run `agent-browser` yourself, write probe scripts, or edit the slide to experiment. A finding you cannot trace to the slide file is not yours to chase: name it in your summary and finish. A harness error `File exists` means the directory is already there and the write did not save. Write the file again. It is not a slide bug.

## 5. Summary

End with this table:

| letter | direction | theme | why it fits |
|---|---|---|---|
| a | Expected | `<theme id>` | one line |
| b | Elevated | `<theme id>` | one line |
| c | Memorable | `<theme id>` or `custom: <palette, fonts, signature element>` | one line |
