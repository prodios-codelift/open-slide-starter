---
name: Studio
description: "Black canvas with acid-yellow Barlow type at weight 900 uppercase — type-as-graphic-mass, high-voltage design-studio manifesto energy."
mode: dark
mood: [electric, bold, graphic, design-led, high-contrast]
tone: [graphic, loud, modern, intentional]
formality: medium
density: medium
scheme: dark
best_for: "Anything that should feel electric and design-led — studio credentials, creative agency pitches, brand showcases, art-direction reviews, fashion/sneaker brand work — and any tech or business deck that wants to read as a brand statement."
avoid_for: "Contexts that should feel quiet or institutional — the black-and-electric-yellow palette is the loudest in the library."
source: bold:studio
---

# Studio

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#1C1C1C` | near-black — the primary dark surface |
| bg-alt | `#242422` | near-black-alt — image placeholders, secondary dark panels |
| bg-light | `#F5D200` | acid-yellow — the alternating light surface, fills the whole slide |
| bg-light-alt | `#F0CC00` | acid-yellow-alt — secondary light surface |
| text | `#F5D200` | acid-yellow — primary text/headline on the dark surface |
| text-light | `#1C1C1C` | near-black — primary text/headline on the yellow surface |
| accent | `#F5D200` | acid-yellow — the only accent; there is no third color |
| muted | `rgba(245,210,0,0.58)` | yellow at 58% — secondary text on dark |
| muted-3 | `rgba(245,210,0,0.32)` | yellow at 32% — tertiary text on dark |
| muted-light | `rgba(28,28,28,0.62)` | near-black at 62% — secondary text on yellow |
| border | `#2E2E2C` | hairline on the dark surface |
| border-light | `rgba(28,28,28,0.18)` | hairline on the yellow surface |

Binary system: yellow-on-dark or dark-on-yellow. Muting is always opacity on the same color, never a separate grey.

## Typography

- Display font: `"Barlow", system-ui, sans-serif` — weight 900, strict uppercase, for every headline at every scale (display through h3). This is the whole identity; type stops reading as type and starts reading as a graphic shape.
- Body font: same `"Barlow"` stack — weight 500 for lead, weight 400 for body/caption.
- Label/mono font: `"IBM Plex Mono", monospace` — weight 500, uppercase, 0.06em tracking. Metadata only: chrome bars, counters, the cover-meta lockup, stat notes. Never content.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Barlow:wght@400;500;700;900&family=IBM+Plex+Mono:wght@400;500&display=swap`
- Type scale (converted from the source's `vw` system at 1920px wide; 1vw = 19.2px):
  - Display (cover hero): 230px, weight 900, line-height 0.9, letter-spacing -0.02em, uppercase
  - H1 (chapter/statement): 144px, weight 900, line-height 0.92, letter-spacing -0.02em, uppercase
  - H2 (primary headline): 92px, weight 900, line-height 0.95, letter-spacing -0.01em, uppercase
  - Stat value: 106px, weight 900, line-height 0.9, letter-spacing -0.03em, uppercase, always in accent
  - Quote text: 73px, weight 900, line-height 1.05, letter-spacing -0.02em, uppercase
  - H3: 54px, weight 700, line-height 1.1, uppercase
  - Lead: 31px, weight 500, line-height 1.45
  - Body: 22px, weight 400, line-height 1.6
  - Caption: 16px, weight 400, line-height 1.5
  - Label: 14px, mono weight 500, uppercase, 0.06em tracking

Weight ladder is fixed at 900 / 700 / 500 / 400 — no intermediate weights. No italic, no underline; emphasis is weight contrast only.

## Layout

- Content padding: 96px horizontal, 54px vertical at 1920×1080 — tighter than most themes because the type itself is the spatial fill.
- Alignment: left-aligned, one dominant headline per slide. Never fill more than ~60% of the canvas; empty surface is structural.
- Chrome: standard pages carry a top chrome bar (mono label left, mono counter right, 1px hairline beneath) and a mirrored bottom foot bar. Cover, chapter, statement, and quote pages drop chrome entirely.
- Surfaces alternate: near-black and acid-yellow are both first-class. Alternate freely for rhythm — 2–3 dark slides before a yellow punctuation slide.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Barlow", system-ui, sans-serif', fontSize: 144, fontWeight: 900, lineHeight: 0.92, letterSpacing: '-0.02em', textTransform: 'uppercase', margin: 0, color: '#F5D200' }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 96, right: 96, bottom: 54, display: 'flex', justifyContent: 'space-between', alignItems: 'center', paddingTop: 11, borderTop: '1px solid #2E2E2C', fontFamily: '"IBM Plex Mono", monospace', fontSize: 14, fontWeight: 500, letterSpacing: '0.06em', textTransform: 'uppercase', color: '#F5D200' }}>
      <span>STUDIO</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"IBM Plex Mono", monospace', fontSize: 14, fontWeight: 500, letterSpacing: '0.06em', textTransform: 'uppercase', color: '#F5D200' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Sharp, short entrances (~0.5s ease-out) — "agency urgency, not editorial grace." Nothing bounces or lingers.

```css
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(16px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

## Aesthetic

Type-as-graphic-mass — the visual register of contemporary design-studio decks (Pentagram, Anti, Order). A single typeface, Barlow, at a single weight, 900, in strict uppercase, run so large it stops behaving like type and starts behaving like a shape; the headline IS the design. The palette is binary plus opacity: near-black field with acid-yellow type, or acid-yellow field with near-black type — never a third color. IBM Plex Mono is the system's spec-sheet voice, reserved for chrome and the three-column cover lockup. Everything is flat and severe: no drop shadows, no rounded corners, no gradients; hairline 1px rules separate chrome, heavier 2px rules anchor stat tops and baselines. Sparse by design — one massive statement against empty surface is the correct register, not a crowded page.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#1C1C1C', position: 'relative' }}>
    <ImgPlaceholder />
    <div style={{ position: 'absolute', top: 96, left: 96, right: 96 }}>
      <Eyebrow>Finance · Q3 2026</Eyebrow>
      <Title>Quarterly Business Review</Title>
    </div>
    <CoverMeta left={<>BORING STUDIOS × CLIENT<br />2026</>} center="QUARTERLY BUSINESS REVIEW" right="BORING STUDIOS" />
  </div>
);
```

## Signature elements

```tsx
// Three-column mono cover footer — the system's signature lockup. Column 1 left, 2 center, 3 right.
const CoverMeta = ({ left, center, right }: { left: React.ReactNode; center: React.ReactNode; right: React.ReactNode }) => (
  <div style={{ position: 'absolute', left: 0, right: 0, bottom: 0, display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', borderTop: '1px solid rgba(245,210,0,0.25)', padding: '22px 96px', fontFamily: '"IBM Plex Mono", monospace', fontSize: 14, fontWeight: 500, letterSpacing: '0.06em', textTransform: 'uppercase', color: '#F5D200' }}>
    <span style={{ textAlign: 'left' }}>{left}</span>
    <span style={{ textAlign: 'center' }}>{center}</span>
    <span style={{ textAlign: 'right' }}>{right}</span>
  </div>
);

// Em-dash bullet — never a dot. Color follows the surface accent.
const Bullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ display: 'flex', gap: '0.5em', listStyle: 'none', fontSize: 22, color: '#F5D200' }}>
    <span style={{ fontFamily: '"Barlow", sans-serif' }}>—</span>
    <span>{children}</span>
  </li>
);

// Stat tile: 2px top rule, weight-900 numeral, mono label.
const StatCard = ({ value, label }: { value: string; label: string }) => (
  <div style={{ borderTop: '2px solid #F5D200', paddingTop: 22 }}>
    <div style={{ fontFamily: '"Barlow", sans-serif', fontSize: 106, fontWeight: 900, lineHeight: 0.9, letterSpacing: '-0.03em', textTransform: 'uppercase', color: '#F5D200' }}>{value}</div>
    <div style={{ fontFamily: '"Barlow", sans-serif', fontSize: 22, fontWeight: 500, color: '#F5D200' }}>{label}</div>
  </div>
);

// Flat image placeholder — near-black-alt fill, mono label, no border on dark.
const ImgPlaceholder = ({ label = 'IMAGE PLACEHOLDER' }: { label?: string }) => (
  <div style={{ position: 'absolute', inset: 0, background: '#242422', display: 'flex', alignItems: 'center', justifyContent: 'center', fontFamily: '"IBM Plex Mono", monospace', fontSize: 14, letterSpacing: '0.06em', color: 'rgba(245,210,0,0.32)' }}>
    {label}
  </div>
);
```

## Do / Don't

- Do run every headline in Barlow 900 uppercase with negative letter-spacing; lowercase or weight 700–800 at display scale breaks the graphic-mass effect.
- Do alternate near-black and acid-yellow surfaces freely — both are first-class.
- Do color every headline in the surface accent (yellow on dark, near-black on yellow), never a muted opacity.
- Do reserve IBM Plex Mono for metadata only — chrome, counters, cover-meta, stat notes.
- Do render the cover-meta footer as a three-column mono lockup; it is the system's signature pattern.
- Do keep padding tight (96px / 54px) so type runs near the edge.
- Don't add a third color. The palette is binary plus opacity — no exceptions.
- Don't round corners, add drop shadows, or use gradients. The system is severely flat.
- Don't use Barlow for chrome or Mono for headlines/body — the face split is structural.
- Don't fill more than ~60% of a slide with content; empty surface is load-bearing.
