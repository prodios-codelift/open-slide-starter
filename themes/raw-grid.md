---
name: Raw Grid
description: "Neobrutalist grid where 3px black borders ARE the layout, weight-900 uppercase type, and hard offset shadows meet blush-pink and sage-green fills."
mode: light
mood: [raw, punchy, energetic, confident]
tone: [direct, modern, no-nonsense, graphic]
formality: low
density: high
scheme: light
best_for: "Founder pitches, accelerator demos, brand decks, and indie launches that want to feel direct and graphic-confident — strong for stat slides, comparisons, and process flows."
avoid_for: "Contexts that need to feel soft, warm, or intentionally quiet — the brutalist borders and offset shadows commit to a graphic voice."
source: bold:raw-grid
---

# Raw Grid

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#FFFFFF` | canvas, default card fill |
| text | `#0A0A0A` | headlines, body copy, and every border — the same black does both jobs |
| accent | `#F2D4CF` | blush pink: warm region fill, bar/stat fill — never text |
| accent-2 | `#E5EDD6` | sage green: cool region fill, hover highlight — never text |
| muted | `#F5F5F5` | off-white: table zebra rows, tertiary card fill |
| muted-2 | `#333333` | reserved dark grey for de-emphasized text; used sparingly |

## Typography

- Display font: `"Segoe UI", system-ui, -apple-system, Helvetica, Arial, sans-serif` — weight 900, uppercase, negative tracking. No webfont: the system loads zero external fonts by design, so type renders as the visitor's real OS font.
- Body font: same stack, weight 500, sentence case — never uppercase.
- No webfont stylesheet — system stack only. This is a deliberate case for `references/webfonts.md`'s "default is a system stack; prefer it."
- Type scale (source `clamp()` values converted at 1920px, where every clamp resolves to its max):
  - Hero / cover display: 96px, weight 900, uppercase, line-height 1.05, letter-spacing -0.02em
  - Section headline: 64px, weight 900, uppercase, line-height 1.1, letter-spacing -0.01em
  - Region title: 36px, weight 800, uppercase, line-height 1.2, letter-spacing 0.01em
  - Subtitle: 22px, weight 700, uppercase, line-height 1.3, letter-spacing 0.04em
  - Body: 20px, weight 500, sentence case, line-height 1.6
  - Caption / label: 13px, weight 700, uppercase, letter-spacing 0.08em
  - Hero numeral: 120px, weight 900, letter-spacing -0.04em
  - Stat numeral: 56px, weight 900, letter-spacing -0.02em
  - Featured numeral: 80px, weight 900, letter-spacing -0.02em
  - Label-pill text: 11px, weight 800, uppercase, letter-spacing 0.08em

Weight ladder is fixed at 500 / 700 / 800 / 900 — no 400 or 600, ever.

## Layout

- Canvas: 1920×1080, white, framed by a 3px solid black border touching all four edges (see `Frame`-style border on the cover below).
- Content padding inside the frame: 64px (`pad-lg`). Secondary regions use 40px (`pad-md`); compact cells use 20px (`pad-sm`).
- Gaps: 48px large, 32px medium, 16px small — but only *within* a region. Regions themselves never have a gap between them.
- Border-as-layout: adjacent regions are divided by a 3px solid black line, not a gap or margin. Cells abut the border directly.
- No rounded corners anywhere except a circle (donut charts). Square corners are the rule.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Segoe UI", system-ui, -apple-system, Helvetica, Arial, sans-serif', fontSize: 96, fontWeight: 900, lineHeight: 1.05, letterSpacing: '-0.02em', textTransform: 'uppercase', margin: 0, color: '#0A0A0A' }}>
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
    <div style={{ position: 'absolute', left: 0, right: 0, bottom: 0, height: 64, borderTop: '3px solid #0A0A0A', display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '0 64px', fontFamily: '"Segoe UI", system-ui, sans-serif', fontSize: 13, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase', color: '#0A0A0A' }}>
      <span>Raw Grid</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// The black label pill — the system's universal section tag.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', background: '#0A0A0A', color: '#FFFFFF', padding: '6px 14px', fontSize: 11, fontWeight: 800, letterSpacing: '0.08em', textTransform: 'uppercase' }}>
    {children}
  </span>
);
```

## Motion

- Philosophy: static. The system's only interactivity (list/row hover → sage green) is a web hover state with no cover-page analog; pages cut instantly, no fade, no slide. Impact comes from the grid and shadows, not motion.

## Aesthetic

A neobrutalist system built on one premise: 3px solid black borders ARE the layout — no margins, no gaps, no rounded corners, no gradients. Display type runs in the visitor's real system sans-serif at weight 900, strict uppercase, negative tracking; body drops to weight 500 sentence case, and that contrast is the entire typographic voice. Depth is exactly two hard offset shadows in solid black, never blurred. Two muted pastels — blush pink and sage green — warm the high contrast as region fills, always paired as warm/cool opposites, never used as text. It reads as Notion-meets-protest-poster: sharp, digital-native, unmistakably software rather than print.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#FFFFFF', color: '#0A0A0A', position: 'relative', border: '3px solid #0A0A0A', boxSizing: 'border-box', padding: 64, display: 'flex', flexDirection: 'column', justifyContent: 'center', overflow: 'hidden' }}>
    <WallpaperNumeral>01</WallpaperNumeral>
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 32, maxWidth: 1400 }}>
      <Eyebrow>Chapter 01</Eyebrow>
      <Title>The Big Idea</Title>
      <p style={{ fontSize: 20, fontWeight: 500, lineHeight: 1.6, color: '#0A0A0A', maxWidth: 1100, margin: 0 }}>
        A short subtitle that explains what this slide is about.
      </p>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Oversized numeral at low opacity, wallpaper behind content — the "decorative numeral" pattern.
const WallpaperNumeral = ({ children }: { children: React.ReactNode }) => (
  <div aria-hidden data-bleed style={{ position: 'absolute', top: -20, right: 48, fontSize: 320, fontWeight: 900, lineHeight: 1, letterSpacing: '-0.04em', color: '#0A0A0A', opacity: 0.08 }}>{children}</div>
);

// Hard offset shadow — solid black, zero blur, the system's only two depth values.
const shadow = '6px 6px 0 #0A0A0A';
const shadowSmall = '4px 4px 0 #0A0A0A';

// Stat tile: bordered card in a pastel fill with a hard shadow, pink/green paired as warm/cool.
const StatTile = ({ value, label, fill }: { value: string; label: string; fill: string }) => (
  <div style={{ border: '3px solid #0A0A0A', background: fill, boxShadow: shadowSmall, padding: 28, display: 'inline-flex', flexDirection: 'column', gap: 8 }}>
    <span style={{ fontSize: 56, fontWeight: 900, letterSpacing: '-0.02em', lineHeight: 1 }}>{value}</span>
    <span style={{ fontSize: 13, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase' }}>{label}</span>
  </div>
);

// 60×4px rule stub — an inline section-break mark next to a label.
const RuleStub = () => <div style={{ width: 60, height: 4, background: '#0A0A0A' }} />;

// Arrow prefix on CTAs and interactive rows — the system's interactivity signal.
const ArrowText = ({ children }: { children: React.ReactNode }) => <span>{'→ '}{children}</span>;
```

## Do / Don't

- Do let regions meet at a 3px black border with zero gap or margin between them.
- Do keep display type weight 900 uppercase with negative tracking; body weight 500 sentence case — never swap the two.
- Do pair pink and green as warm/cool opposites when two accent fills appear together; never two of the same.
- Do use the black `Eyebrow` pill as the universal section tag, generously.
- Do render shadows as exactly `6px 6px 0 #0A0A0A` or `4px 4px 0 #0A0A0A` — pick one, never blur.
- Don't load a webfont. The system-font stack is the point.
- Don't round a corner (circles for donut charts only) or use a third accent colour.
- Don't use an intermediate weight (400, 600) or italic/underline for emphasis.
