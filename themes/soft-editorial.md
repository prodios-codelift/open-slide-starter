---
name: Soft Editorial
description: "Cormorant Garamond serif on warm cream paper with pastel candy cards in pink, lemon, blush, sage, and lilac."
mode: light
mood: [literary, elegant, quiet, warm-classical]
tone: [literary, considered, warm, magazine]
formality: high
density: low
scheme: light
best_for: "Editorial features, longform brand stories, gallery or museum decks, and advisory or founder-essay decks that want literary, unhurried warmth."
avoid_for: "Decks that need visual heat or punch — the warm-paper palette and Cormorant serif are intentionally quiet."
source: bold:soft-editorial
---

# Soft Editorial

## Palette

| Role | Value | Notes |
|---|---|---|
| bg | `#F2EEDF` | paper — the constant cream field, every slide |
| bg-alt | `#ECE6D2` | paper-2, cooler cream for rare surface separation |
| text | `#2A241B` | ink — warm near-black, primary copy on every surface incl. pastel cards |
| muted | `#5C5345` | ink-soft — secondary copy, captions, footer, page markers |
| accent | `#E1A4C2` | pink — dusty rose, most-used card fill; full-bleed closer background |
| accent-2 | `#D6DD63` | lemon — chartreuse, brightest accent, hero numerals, "yes" pills |
| blush | `#E8C9B6` | soft peach, neutral pastel card fill |
| sage | `#B7C7A8` | muted green, cool-variety card fill |
| lilac | `#C9BEDC` | soft violet-grey, fifth-slot card fill |
| card | `rgba(255,255,255,0.55)` | translucent white, default card fill |
| rule | `rgba(42,36,27,0.18)` | dashed hairline inside cards |
| rule-2 | `rgba(42,36,27,0.35)` | heavier solid divider inside cards |

## Typography

- Display font: `"Cormorant Garamond", Garamond, serif`, weight 500 (headline default); an `<em>` phrase inside a headline drops to weight 400 italic — the system's core typographic signal.
- Body font: `"Work Sans", system-ui, sans-serif`, weight 400 body / 500 labels. Never carries a headline.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;1,400;1,500&family=Work+Sans:wght@400;500&display=swap`
- Type scale:
  - Hero title: 188px, Cormorant 500, line-height 0.95, letter-spacing -0.015em
  - Section heading: 96px, Cormorant 500, line-height 0.98
  - Page heading: 72px, Cormorant 500, line-height 1
  - Step numeral: 92px, Cormorant italic 500 — lowercase Roman numerals (i., ii., iii.) only, never Arabic
  - Kicker / eyebrow: 28px Work Sans 400 (eyebrow, upright) or 38px Cormorant italic 400 (kicker)
  - Body: 26px Work Sans 400, line-height 1.5
  - Footer / page marker: 26px Cormorant italic 400

## Layout

- Content padding: 80px horizontal, 60px top, 50px bottom (1920×1080).
- Alignment: left-aligned chrome; content cards float on the cream field with 28–36px gaps between them and generous cream showing through — never edge-to-edge.
- Cards: translucent white default, 24–36px border-radius, no square corners anywhere (minimum 14px), no drop shadows — depth comes from translucency and rounded form only.
- Pastel color cards (pink, lemon, blush, sage, lilac) are interchangeable fills for stat/step/insight moments; text stays ink, never inverted to white.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Cormorant Garamond", Garamond, serif', fontSize: 188, fontWeight: 500, lineHeight: 0.95, letterSpacing: '-0.015em', margin: 0, color: '#2A241B' }}>
    {children}
  </h1>
);

// Italic weight-drop emphasis: wrap one phrase per headline — the system's signature move.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'italic', fontWeight: 400 }}>{children}</em>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 80, right: 80, bottom: 50, display: 'flex', justifyContent: 'space-between', fontFamily: '"Cormorant Garamond", Garamond, serif', fontStyle: 'italic', fontSize: 26, color: '#5C5345' }}>
      <span>Soft Editorial Quarterly</span>
      <span>{current} / {total}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ position: 'absolute', top: 60, left: 80, fontFamily: '"Work Sans", sans-serif', fontSize: 28, fontWeight: 400, color: '#2A241B' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. The system's calm comes from typography and cream space, not movement; if a deck must animate, keep it to a slow 0.4s opacity fade and nothing more.

## Aesthetic

A warm magazine spread — the kind of layout a small-press literary quarterly would commission. Cormorant Garamond carries every headline, numeral, and ornamental moment in mixed roman and italic; Work Sans recedes into body copy. Every slide sits on the same warm cream paper field; pastel cards (pink, lemon, blush, sage, lilac) float above it in rounded, translucent, shadow-free registers. No corporate polish, no hard edges, no bold body text — literary calm with a sprinkle of riso-print color.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#F2EEDF', color: '#2A241B', position: 'relative', padding: '0 80px', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <SwatchRow />
    <Eyebrow>FINANCE · Q3 2026</Eyebrow>
    <Title>
      Quarterly Business <Em>Review</Em>
    </Title>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Row of pastel discs top-right on the cover — the system's identity mark.
const SwatchRow = () => (
  <div style={{ position: 'absolute', top: 60, right: 80, display: 'flex', gap: 12 }}>
    {['#E1A4C2', '#D6DD63', '#E8C9B6'].map((c) => (
      <span key={c} style={{ width: 56, height: 56, borderRadius: '50%', background: c }} />
    ))}
  </div>
);

// Translucent white default card. Pastel fills swap the background for accent moments.
const SoftCard = ({ children, fill = 'rgba(255,255,255,0.55)' }: { children: React.ReactNode; fill?: string }) => (
  <div style={{ background: fill, borderRadius: 28, padding: '48px 52px' }}>{children}</div>
);

// Italic Roman-numeral step ordinal — never Arabic.
const StepNumeral = ({ n }: { n: string }) => (
  <div style={{ fontFamily: '"Cormorant Garamond", Garamond, serif', fontStyle: 'italic', fontWeight: 500, fontSize: 92, color: '#2A241B' }}>{n}.</div>
);

// 132px drop cap opening a long-form paragraph — the deck's most editorial moment.
const DropCap = ({ children }: { children: React.ReactNode }) => (
  <span style={{ float: 'left', fontFamily: '"Cormorant Garamond", Garamond, serif', fontWeight: 500, fontSize: 132, lineHeight: 0.85, padding: '8px 14px 0 0' }}>{children}</span>
);
```

## Do / Don't

- Do keep every slide's background on cream paper; pastels are card fills only (the one exception: a full-bleed pink closer for a single "moment" slide).
- Do drop `<em>` phrases inside headlines to italic weight 400 against the surrounding weight 500 — the system's core signal.
- Do keep text ink-colored on every surface, including pastel cards. Never invert to white.
- Do use lowercase italic Roman numerals for step ordinals, never Arabic.
- Don't use square corners — 14px is the minimum radius anywhere.
- Don't add drop shadows or a third typeface.
