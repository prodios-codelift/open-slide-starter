---
name: Vellum
description: "Deep periwinkle navy field with italic Cormorant Garamond in warm chartreuse-yellow, and a dusty-teal pin-note in the corner. Scholarly, still, monochromatic."
mode: dark
mood: [scholarly, literary, considered, quiet]
tone: [literary, considered, patient, intelligent]
formality: high
density: low
scheme: dark
best_for: "Research synthesis, white papers, academic and policy briefs, advisory deliverables, and founder reflections that want a scholarly, quietly intelligent, calm atmosphere instead of energetic visuals."
avoid_for: "Contexts that need visual heat or pop — the navy + warm-yellow Cormorant aesthetic is intentionally low-tempo."
source: bold:vellum
---

# Vellum

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#2A3870` | deep periwinkle navy — the single surface, every slide, no alternate |
| bg-alt | `#343F80` | slightly lifted navy for adjacent-surface differentiation, rarely used |
| bg-deep | `#1F2858` | darker compare-panel shade (left panel only) |
| bg-mid | `#34407A` | lighter compare-panel shade (right panel only) |
| text | `#E8D85C` | warm chartreuse-yellow — primary type, every headline and body copy |
| text-2 | `rgba(232,216,92,0.62)` | yellow at 62% — secondary text, lead paragraphs |
| muted | `rgba(232,216,92,0.32)` | yellow at 32% — tertiary text, captions, default chart bar fill |
| accent | `#3A7878` | dusty teal — second accent: quote-mark glyph, pin-note, kickers, the rule, list counters |
| emphasis | `#F5E168` | brighter yellow — `<em>` inside headlines only |
| border | `rgba(232,216,92,0.20)` | hairline border, yellow at 20% opacity |

## Typography

- Display font: `"Cormorant Garamond", "Noto Serif SC", Georgia, serif` — weight 400 italic for every headline, numeral, and quote. Italic is the default presentation, not an emphasis variant (h3 steps to weight 500, still italic).
- Body font: `"DM Sans", "Noto Sans SC", system-ui, sans-serif` — weight 400, recedes behind the serif.
- Mono/label font: `"Courier Prime", "Courier New", monospace` — weight 400–500. Carries chrome labels, the pin-note signature, list counter markers, and bar values — never body or headlines.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;1,400;1,500&family=DM+Sans:wght@400;500&family=Courier+Prime:wght@400;500&display=swap`
- Type scale (converted from the source's `vw` system at 1920px wide):
  - Display (cover hero): 211px, italic 400, line-height 0.92, letter-spacing -0.01em
  - H1 (chapter/statement): 134px, italic 400, line-height 0.95, letter-spacing -0.01em
  - Quote-mark glyph: 134px, italic 400, line-height 0.6, always teal
  - Stat value: 106px, italic 400, line-height 1, letter-spacing -0.02em, always yellow
  - H2 (primary headline): 77px, italic 400, line-height 1.05
  - Quote text: 61px, italic 400, line-height 1.25
  - H3 (sub-headline): 46px, italic 500, line-height 1.15
  - Lead: 29px, DM Sans 400, line-height 1.6
  - Pin-note: 22px, Courier Prime 500, line-height 1.5, teal, letter-spacing 0.01em
  - Body: 20px, DM Sans 400, line-height 1.65
  - Caption: 16px, DM Sans 400, line-height 1.5
  - Label: 14px, Courier Prime 400, letter-spacing 0.06em

## Layout

- Content padding: 115px horizontal, 65px vertical at 1920×1080. Quote slides step up to 1.4×/1.2× (161px/78px) for extra breathing room. Compare layouts drop slide padding to 0 — each panel carries its own.
- Alignment: centered on every layout — text-align center, items centered on flex columns. Left-aligned headlines break the pinned-essay register.
- Content rarely exceeds 70% of canvas width or 60% of canvas height; the empty navy field around it is structural, not negative space.
- Gaps: 54px between major sections, 32px between related elements, 16px between tightly coupled elements.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Cormorant Garamond", "Noto Serif SC", Georgia, serif', fontSize: 211, fontWeight: 400, fontStyle: 'italic', lineHeight: 0.92, letterSpacing: '-0.01em', margin: 0, color: '#E8D85C', textAlign: 'center' }}>
    {children}
  </h1>
);

// The system's <em> mechanism: upright roman at weight 600 in emphasis-yellow.
// The italic-to-roman inversion is non-negotiable — never substitute a color-only swap.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'normal', fontWeight: 600, color: '#F5E168' }}>{children}</em>
);
```

### Footer

The pin-annotation is Vellum's persistent chrome — present in the bottom-left corner of every slide, chromed or not.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 115, bottom: 58, maxWidth: 422, display: 'flex', flexDirection: 'column', gap: 6, fontFamily: '"Courier Prime", "Courier New", monospace', fontSize: 22, fontWeight: 500, lineHeight: 1.5, letterSpacing: '0.01em', color: '#3A7878' }}>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
      <span>VELLUM · 2026</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Courier Prime", "Courier New", monospace', fontSize: 14, fontWeight: 400, letterSpacing: '0.06em', color: '#3A7878', textAlign: 'center' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. Slide and entrance animation durations are 0 — the system is meant to be read like pages in a folio, one at a time, with no transition.

## Aesthetic

A monochromatic essay pinned to a gallery wall. One periwinkle-navy field forever — no alternate surface, no light mode, no second background color. Italic Cormorant Garamond at every headline scale is the personality; DM Sans recedes as quiet supporting substance; Courier Prime carries the typed, archival voice of chrome and the pin-note signature in the corner. Content is sparse and centered — the empty navy field around it is structural, not negative space. Flat, still, and warm-cool at once: chartreuse-yellow type against periwinkle, with a single desaturated teal accent reserved for the quote glyph, kickers, the 28px rule, and list counters. No shadows, no rounded corners, no gradients, no motion.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#2A3870', color: '#E8D85C', position: 'relative', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center', padding: '0 115px', gap: 32 }}>
    <Eyebrow>Chapter One</Eyebrow>
    <Rule />
    <Title>
      The Quiet <Em>Return</Em>
    </Title>
    <p style={{ fontFamily: '"DM Sans", sans-serif', fontSize: 29, lineHeight: 1.6, color: 'rgba(232,216,92,0.62)', maxWidth: 1100, margin: 0 }}>
      A short lead sentence that explains what this deck is about.
    </p>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// 28px teal accent rule — kicker separator or chapter mark.
const Rule = () => <div style={{ width: 28, height: 1, background: '#3A7878' }} />;

// Large italic quote-mark glyph in teal, centered above a centered pull-quote —
// the only large-scale teal element in the system.
const QuoteMark = () => (
  <div style={{ fontFamily: '"Cormorant Garamond", Georgia, serif', fontSize: 134, fontStyle: 'italic', lineHeight: 0.6, color: '#3A7878' }}>
    &ldquo;
  </div>
);

// Numbered list item — Courier Prime mono counter in teal. Never a bullet dot or dash.
const NumberedItem = ({ n, children }: { n: number; children: React.ReactNode }) => (
  <li style={{ display: 'flex', gap: '0.5em', listStyle: 'none', textAlign: 'left' }}>
    <span style={{ fontFamily: '"Courier Prime", monospace', fontSize: 14, color: '#3A7878', flexShrink: 0, width: '2em' }}>
      {String(n).padStart(2, '0')}.
    </span>
    <span style={{ fontFamily: '"DM Sans", sans-serif', fontSize: 29, lineHeight: 1.6 }}>{children}</span>
  </li>
);
```

## Do / Don't

- Do fill every slide with `#2A3870` navy — one field, no alternate surface, no light mode.
- Do set every headline in italic Cormorant Garamond 400 in yellow; italic is the default, not decoration.
- Do place the pin-annotation (Footer) in the bottom-left corner of every slide, mono teal.
- Do use `<Em>` for headline emphasis — upright roman weight 600 in emphasis-yellow, never a color-only swap.
- Do number lists with Courier Prime mono counters in teal; no bullet dots, no dashes.
- Do center every layout and leave generous empty navy field around content.
- Don't introduce a second background color, even on compare layouts — use only `bg-deep`/`bg-mid`.
- Don't render headlines upright — roman appears only inside `<Em>`.
- Don't add drop shadows, rounded corners, or gradients.
- Don't motion the slide — transitions and entrances are 0 duration.
- Don't put teal on body text, or yellow on the quote-mark glyph or a kicker.
