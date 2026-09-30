---
name: Creative Mode
description: "Neo-brutalist cream paper with 4px ink borders, hard offset shadows, uppercase Archivo Black and flat green, pink, orange and yellow blocks."
mode: light
mood: [creative, confident, playful, design-led]
tone: [graphic, expressive, modern]
formality: medium
density: high
scheme: light
best_for: "Design-led decks that lead with taste: agency pitches, studio credentials, brand and art-direction reviews, or an unexpected tech talk or finance review."
avoid_for: "Contexts that demand institutional restraint and quiet authority; the saturated multi-accent palette reads as expressive, not formal."
source: bold:creative-mode
---

# Creative Mode

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#EFE9D9` | cream: every page but the closer; never white |
| text | `#0F0F0F` | ink: text, every border, rules, hard shadows, kickers |
| accent | `#1F8A4C` | green: dominant accent; cells, panels, closer background |
| muted | `#2A2A2A` | ink-2: subtitles, cell descriptors, footnotes |
| bg-alt | `#E4DCC4` | cream-2: table fill, fourth stacked block |
| pink | `#F06CA8` | poster, marker, stamp, cells, steps |
| pink-dark | `#D14E8B` | lever underside, shadow-side depth only |
| orange | `#E85A1F` | the 24px hard-shadow colour; cells, bars, table columns |
| yellow | `#F5C518` | rotated badge, circle motif, steps, bars |
| green-dark | `#136636` | depth on green decoration, never a surface |

Text on fills: cream on green and orange; ink on pink, yellow and cream.

## Typography

- Display: `"Archivo Black", "Arial Black", Impact, sans-serif`, weight 400 (intrinsically heavy), always uppercase, line-height 0.92, letter-spacing -0.01em.
- Body: `"Space Grotesk", system-ui, sans-serif`, weight 400, sentence case, left-aligned.
- Mono: `"JetBrains Mono", ui-monospace, monospace`, 400, 24px, uppercase; tracking 0.08em topbar, 0.06em footer, 0.14em kicker, 0.1em tags. Every label, chip and axis; never body or headlines.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Archivo+Black&family=Space+Grotesk:wght@400&family=JetBrains+Mono:wght@400&display=swap`
- Type scale (source is native 1920px; display is deliberately oversized):
  - Display: 220 closer · 160 cover (`Title` default) · 140 opener · 100 / 96 / 84 / 72 content headlines
  - Numerals: step 140 (lh 0.85) · stat 96 (lh 0.9) · stamp 64 · marker 46 · card title 34
  - Table head, badge: 28px Archivo Black
  - Body: 28px lede, lh 1.4 (floor for running copy) · 24px in-cell descriptors, lh 1.3
- CJK: add `"Noto Serif SC"` (900 display, 400 body) to the stacks; no uppercase or tracking on Hanzi.

## Layout

- Chrome gutter 64px (`Topbar` at top 48, `Footer` at bottom 40); content gutter 96px; content between y ≈ 150 and 940.
- Grid gap 28px; cell padding 28px 32px; table cells 18px 26px.
- Left-aligned and asymmetric: headline block left, graphic panel right (headline column ≤ ~1150px).
- Two or three of the four accents per page, never all four. Green as a page background only on the single closing slide, with cream type and chrome.
- Step and stat sequences alternate cream with accents and end on green.

## Fixed components

### Title

```tsx
// size: 220 closer · 160 cover · 140 opener · 100/96/84/72 content. color '#EFE9D9' on the green closer.
const Title = ({ children, size = 160, color = '#0F0F0F' }: { children: React.ReactNode; size?: number; color?: string }) => (
  <h1 style={{ fontFamily: '"Archivo Black", "Arial Black", sans-serif', fontSize: size, fontWeight: 400, lineHeight: 0.92, letterSpacing: '-0.01em', textTransform: 'uppercase', margin: 0, color }}>
    {children}
  </h1>
);
```

### Footer

Slide-meta bar: a real descriptor left, `01 • 08` right. `color="#EFE9D9"` on the closer.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ label, color = '#0F0F0F' }: { label: string; color?: string }) => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    <div style={{ position: 'absolute', left: 64, right: 64, bottom: 40, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"JetBrains Mono", monospace', fontSize: 24, lineHeight: 1, letterSpacing: '0.06em', textTransform: 'uppercase', color }}>
      <span>{label}</span>
      <span style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
        {pad(current)}
        <span style={{ width: 10, height: 10, borderRadius: '50%', background: 'currentColor' }} />
        {pad(total)}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Inverted kicker block: ink slab, cream mono.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ width: 'fit-content', background: '#0F0F0F', color: '#EFE9D9', padding: '8px 16px', fontFamily: '"JetBrains Mono", monospace', fontSize: 24, lineHeight: 1, letterSpacing: '0.14em', textTransform: 'uppercase' }}>
    {children}
  </div>
);

// Topbar, every page: section label left, pill right (the only rounded chrome).
const Topbar = ({ label, pill, color = '#0F0F0F' }: { label: string; pill: string; color?: string }) => (
  <div style={{ position: 'absolute', left: 64, right: 64, top: 48, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"JetBrains Mono", monospace', fontSize: 24, lineHeight: 1, letterSpacing: '0.08em', textTransform: 'uppercase', color }}>
    <span>{label}</span>
    <span style={{ border: '2px solid currentColor', borderRadius: 999, padding: '6px 14px' }}>{pill}</span>
  </div>
);
```

## Motion

- Philosophy: static. Pages snap; the collision of flat colour blocks is the energy, so nothing fades or bounces.

## Aesthetic

Neo-brutalist editorial: part Bauhaus grid, part punk zine, part Swiss specimen sheet, printed like a risograph. Restraint of technique, aggression of expression. Warm cream paper carries uppercase Archivo Black set so tight it overlaps its own cap height, JetBrains Mono labels like a typesetter's rule sheet, and Space Grotesk for prose. Four saturated accents fire as flat fills and collide rather than blend. Every structural edge is a 4px ink line; depth is a solid offset copy of the shape, never a blur. No gradients, rounded cards, glow, white or photos; illustrations are CSS geometry.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#EFE9D9', color: '#0F0F0F', fontFamily: '"Space Grotesk", system-ui, sans-serif', padding: '0 96px', display: 'grid', gridTemplateColumns: '1fr 480px', columnGap: 96, alignItems: 'center' }}>
    <Topbar label="Brand Review" pill="2026" />
    <div style={{ display: 'flex', flexDirection: 'column', gap: 40 }}>
      <Eyebrow>Studio Credentials · 2026</Eyebrow>
      <Title>Loud By Design</Title>
      <p style={{ fontSize: 28, lineHeight: 1.4, color: '#2A2A2A', maxWidth: 760, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <div style={{ position: 'relative' }}>
      <SwitchPoster />
      <Badge style={{ position: 'absolute', top: -28, left: -44 }}>New work</Badge>
    </div>
    <Footer label="Studio Name · Pitch" />
  </div>
);
```

## Signature elements

```tsx
// Hard offset shadows, two sizes only: LG on one featured block per page, MD on stacked blocks.
const SHADOW_LG = '24px 24px 0 #E85A1F, 24px 24px 0 4px #0F0F0F';
const SHADOW_MD = '18px 18px 0 #0F0F0F';

// Cover poster: pink plate, rocker switch; the lever's pink-dark underside is its own hard shadow.
const SwitchPoster = () => (
  <div aria-hidden style={{ width: 480, height: 480, background: '#F06CA8', border: '4px solid #0F0F0F', boxShadow: SHADOW_LG, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
    <div style={{ width: 210, height: 300, background: '#EFE9D9', border: '4px solid #0F0F0F', display: 'flex', justifyContent: 'center', paddingTop: 44 }}>
      <div style={{ width: 120, height: 104, background: '#F06CA8', border: '4px solid #0F0F0F', transform: 'skewY(-10deg)', boxShadow: '0 28px 0 #D14E8B, 0 28px 0 4px #0F0F0F' }} />
    </div>
  </div>
);

// Rotated badge: yellow, always -4deg.
const Badge = ({ children, style }: { children: React.ReactNode; style?: React.CSSProperties }) => (
  <div style={{ width: 'fit-content', background: '#F5C518', border: '4px solid #0F0F0F', padding: '12px 22px', fontFamily: '"Archivo Black", sans-serif', fontSize: 28, lineHeight: 1, textTransform: 'uppercase', transform: 'rotate(-4deg)', ...style }}>
    {children}
  </div>
);

// Featured marker: pink 46px callout with SHADOW_LG.
const Marker = ({ children }: { children: React.ReactNode }) => (
  <div style={{ width: 'fit-content', background: '#F06CA8', border: '4px solid #0F0F0F', boxShadow: SHADOW_LG, padding: '24px 36px', fontFamily: '"Archivo Black", sans-serif', fontSize: 46, lineHeight: 1, textTransform: 'uppercase' }}>
    {children}
  </div>
);

// Flat stat cell, no shadow. bg/fg: green or orange with '#EFE9D9'; pink or cream with ink.
const StatCell = ({ value, label, bg = '#EFE9D9', fg = '#0F0F0F' }: { value: string; label: string; bg?: string; fg?: string }) => (
  <div style={{ background: bg, color: fg, border: '4px solid #0F0F0F', padding: '28px 32px', display: 'flex', flexDirection: 'column', gap: 16 }}>
    <div style={{ fontFamily: '"Archivo Black", sans-serif', fontSize: 96, lineHeight: 0.9 }}>{value}</div>
    <div style={{ fontSize: 24, lineHeight: 1.3 }}>{label}</div>
  </div>
);

// Stacked blocks: overlap 3–4 (pink, yellow, orange, '#E4DCC4') absolutely inside a sized relative box.
const StackedBlock = ({ bg, style }: { bg: string; style: React.CSSProperties }) => (
  <div aria-hidden style={{ position: 'absolute', background: bg, border: '4px solid #0F0F0F', boxShadow: SHADOW_MD, ...style }} />
);

// Closer stamp on green: pink square at -6deg, cream circular inner border, 64px numeral.
const Stamp = ({ children }: { children: React.ReactNode }) => (
  <div style={{ width: 340, height: 340, background: '#F06CA8', border: '4px solid #EFE9D9', transform: 'rotate(-6deg)', display: 'grid', placeItems: 'center' }}>
    <div style={{ width: 256, height: 256, borderRadius: '50%', border: '4px solid #EFE9D9', display: 'grid', placeItems: 'center', fontFamily: '"Archivo Black", sans-serif', fontSize: 64 }}>{children}</div>
  </div>
);
```

More vocabulary, all flat with ink edges: a yellow circle (`borderRadius: '50%'`, 4px ink) centred in a green square; a 3px dashed ink rule under the topbar on process pages; an ink step arrow (`borderTop`/`borderBottom: '18px solid transparent'`, `borderLeft: '24px solid #0F0F0F'`). Tables: 4px ink outer border on `#E4DCC4`, 3px ink row and column lines, ink header row in cream Archivo Black 28px, one column tinted pink, green or orange. Bar charts: 3px-ink-bordered bars in orange, yellow or green; `borderRight`/`borderBottom: '3px solid #0F0F0F'` axes; mono 24px labels at 0.08em.

## Do / Don't

- Do put a 4px ink border on every structural element; 3px only inside tables and charts.
- Do keep all Archivo Black uppercase at line-height 0.92; set every label, chip and axis in JetBrains Mono.
- Do give one featured block per page `SHADOW_LG`; grid cells get none.
- Do use two or three accents per page and save the green page for the closer.
- Don't round corners (topbar pill and circle motifs are the only curves) or add gradients, blur or glow.
- Don't use white, a fifth accent or a fourth typeface.
- Don't track Archivo Black or Space Grotesk, or centre body copy.
- Don't change the badge (-4deg) or stamp (-6deg) angles or add new ones.
