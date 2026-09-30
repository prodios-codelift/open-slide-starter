---
name: Retro Zine
description: "Beige paper with green accent and Bebas Neue + Caveat: a riso-printed zine in HTML form."
mode: light
mood: [crafted, lo-fi, underground, warm-retro]
tone: [scrappy, warm, intentional, DIY]
formality: low
density: medium
scheme: light
best_for: "Indie zines, music/arts brands, creator portfolios, small-batch craft launches, and community decks that want riso-print warmth over digital polish."
avoid_for: "Contexts that demand digital-native polish or fast modern-tech energy — the layered zine aesthetic intentionally feels handmade."
source: bold:retro-zine
---

# Retro Zine

## Palette

| Role       | Value     | Notes                                                        |
| ---------- | --------- | ------------------------------------------------------------- |
| bg         | `#C8B99A` | warm khaki paper canvas — default surface on every slide      |
| bg-dark    | `#B8A98A` | darker khaki sibling for layered/split surfaces                |
| text       | `#1A1A1A` | ink-black — all body text, all structural borders              |
| accent     | `#008F4D` | forest green — headlines, drop caps, ribbons, stamps, numerals |
| accent-2   | `#00A85D` | brighter green sibling, hover/secondary use only               |
| white      | `#F4EFE6` | soft cream (not pure white) — card fills, text on black/green  |
| muted      | `rgba(26,26,26,0.22)` | hairline ledger/table dividers on khaki            |

## Typography

- Display font: `'Bebas Neue', sans-serif` — condensed all-caps industrial sans, weight 400 only. Always uppercase, always tracked 0.02–0.04em. This is the entire display identity; do not substitute.
- Body font: `'Space Grotesk', sans-serif` — weight 300–500, kept deliberately small (the zine's magazine column density).
- Hand-script font: `'Caveat', cursive` — weight 400–700, for attributions, side notes, and form "writing." No italic exists in this system; Caveat *is* the emphasis face.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Space+Grotesk:wght@300;400;500&family=Caveat:wght@400;600;700&display=swap`
- Type scale (source `clamp()` saturates at its max well before 1920px, so values below are the effective sizes):
  - Cover / hero headline: 140px, Bebas 400, line-height 0.88, letter-spacing 0.04em, uppercase, green
  - Section headline: 90px, Bebas 400, line-height 0.95, letter-spacing 0.03em, uppercase
  - Region/collage title: 42px, Bebas 400, uppercase
  - Hero stat numeral: 160px, Bebas 400, green
  - Drop cap: 80px, Bebas 400, line-height 0.8, green
  - Eyebrow label: 18px, Bebas 400, uppercase, letter-spacing 0.2em, green
  - Body: 16px, Space Grotesk 400, line-height 1.7 — deliberately small; never the sole element carrying a page
  - Lead body: 18px, Space Grotesk 400, line-height 1.6
  - Hand-script: 36px, Caveat 600, line-height 1.3

## Layout

- Content padding: 60px standard; 60px/80px (vert/horiz) for editorial column spreads. Deliberately tighter than a typical fixed-stage deck — part of the packed zine register.
- Grid: border-as-divider — a parent container carries a 3px solid black outer border; child cells carry 1.5px solid black sub-borders, meeting with no gap.
- Free/collage compositions position pieces absolutely with small rotation (-5° to 5°); borders sit on individual pieces, not the slide grid.
- Density is medium-high by intent: pair one dominant text moment with several subordinate moves (stamp, eyebrow, divider stub, hand-script byline). Reserve sparse single-headline pages for a manifesto/statement moment on a solid green field.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: "'Bebas Neue', sans-serif", fontSize: 140, fontWeight: 400, lineHeight: 0.88, letterSpacing: '0.04em', textTransform: 'uppercase', margin: 0, color: '#008F4D' }}>{children}</h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 60, right: 60, bottom: 40, display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '3px solid #1A1A1A', paddingTop: 16 }}>
      <span style={{ fontFamily: "'Bebas Neue', sans-serif", fontSize: 18, letterSpacing: '0.2em', textTransform: 'uppercase', color: '#1A1A1A' }}>RETRO ZINE</span>
      <span style={{ fontFamily: "'Bebas Neue', sans-serif", fontSize: 14, color: '#1A1A1A', background: '#F4EFE6', border: '2px solid #1A1A1A', padding: '4px 12px' }}>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: "'Bebas Neue', sans-serif", fontSize: 18, letterSpacing: '0.2em', textTransform: 'uppercase', color: '#008F4D' }}>{children}</div>
);
```

## Motion

- Philosophy: subtle. A soft paper-shuffle: 0.6s opacity + translateY(20px) ease on entry. Nothing snaps, bounces, or glows.

```css
@keyframes paperShuffle {
  from { opacity: 0; transform: translateY(20px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

## Aesthetic

A risograph-zine editorial system: warm khaki paper, deep forest-green accent, ink-black structure, and a print-grain overlay that ties every surface to a printed-paper register. Bebas Neue carries every loud display moment (tracked, uppercase, condensed); Space Grotesk carries quiet small-size body; Caveat carries the human hand-script voice. Depth comes from paper-on-paper offset color blocks and small intentional rotations — never blurred shadows. No rounded corners anywhere. Borrows from independent press culture, mid-century activist posters, and DIY zine collage.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#C8B99A', color: '#1A1A1A', position: 'relative', display: 'flex', flexDirection: 'column', justifyContent: 'center', padding: '0 60px' }}>
    <GrainOverlay />
    <Eyebrow>Issue 01 · 2026</Eyebrow>
    <Title>The Big Idea</Title>
    <p style={{ fontFamily: "'Space Grotesk', sans-serif", fontSize: 18, lineHeight: 1.6, color: '#1A1A1A', maxWidth: 900, marginTop: 24 }}>
      A short subtitle that explains what this deck is about.
    </p>
    <Stamp>APPROVED</Stamp>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Print-grain SVG overlay — required on every slide, 0.07 opacity, above all content.
const GrainOverlay = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, opacity: 0.07, zIndex: 9999, pointerEvents: 'none', backgroundImage: "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='2' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E\")" }} />
);

// Rotated approval stamp: black bg, green text, green border, -8deg.
const Stamp = ({ children }: { children: React.ReactNode }) => (
  <div style={{ display: 'inline-block', position: 'absolute', bottom: 140, right: 100, background: '#1A1A1A', color: '#008F4D', border: '2px solid #008F4D', padding: '10px 24px', fontFamily: "'Bebas Neue', sans-serif", fontSize: 18, letterSpacing: '0.1em', transform: 'rotate(-8deg)' }}>{children}</div>
);

// Paper-on-paper offset card: green slab sits 12px behind a cream card via ::before-style layering.
const CardOffset = ({ children }: { children: React.ReactNode }) => (
  <div style={{ position: 'relative' }}>
    <div style={{ position: 'absolute', top: 12, left: 12, right: -12, bottom: -12, background: '#008F4D', zIndex: 0 }} />
    <div style={{ position: 'relative', zIndex: 1, background: '#F4EFE6', border: '3px solid #1A1A1A', padding: 32 }}>{children}</div>
  </div>
);

// Oversized green initial cap, floated left, opens an editorial paragraph.
const DropCap = ({ children }: { children: string }) => (
  <span style={{ float: 'left', fontFamily: "'Bebas Neue', sans-serif", fontSize: 80, lineHeight: 0.8, color: '#008F4D', marginRight: 12 }}>{children}</span>
);

// Solid green label strip with cream text — section labels, accent bars.
const RibbonBar = ({ children }: { children: React.ReactNode }) => (
  <div style={{ display: 'inline-block', background: '#008F4D', color: '#F4EFE6', padding: '6px 16px', fontFamily: "'Bebas Neue', sans-serif", fontSize: 18, letterSpacing: '0.1em', textTransform: 'uppercase' }}>{children}</div>
);

// Translucent masking-tape strip, layered at an angle over collage pieces.
const Tape = ({ rotate = -20, style }: { rotate?: number; style?: React.CSSProperties }) => (
  <div aria-hidden style={{ position: 'absolute', width: 80, height: 24, background: 'rgba(255,255,255,0.4)', border: '1px solid rgba(0,0,0,0.1)', transform: `rotate(${rotate}deg)`, ...style }} />
);
```

## Do / Don't

- Do keep the grain overlay on every slide at 0.07 opacity — removing it breaks the zine voice.
- Do set every Bebas Neue element uppercase with 0.02–0.04em+ tracking; never sentence-case Bebas.
- Do reach for green as the default headline color; black only for body-paired headlines in split layouts.
- Do use `CardOffset` for hero/RSVP-style callouts, never a blurred `box-shadow`.
- Do keep rotations intentional and under ±8° (stamps, tape, collage pieces).
- Do pair any statement/quote headline with a Caveat hand-script byline underneath.
- Don't round any corner — border-radius is 0 system-wide.
- Don't push body text past 18px; the small-body density is the zine's signature register.
- Don't add a third brand color beyond khaki + green + black + cream.
- Don't substitute another display or script face for Bebas Neue / Caveat.
