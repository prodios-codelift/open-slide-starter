---
name: Coral
description: "Coral, ink and cream planes meeting at hard edges, set in oversized tracked Bebas Neue with a 45° hatch."
mode: light
mood: [bold, warm, modern, confident]
tone: [graphic, punchy, magazine]
formality: medium
density: medium
scheme: mixed
best_for: "Warm, graphic, editorial decks: fashion, beauty, fitness, F&B, lifestyle brands, agency credentials, creator portfolios, manifestos, or a tech deck wanting one bold accent over corporate cool."
avoid_for: "Quiet, institutional contexts; the coral accent and oversized Bebas Neue commit hard to a confident magazine voice."
source: bold:coral
---

# Coral

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F5F0E8` | cream: the paper, default surface and cover body |
| text | `#1A1A1A` | ink: headlines and body on cream and on coral |
| accent | `#E85D5D` | coral: borders, eyebrows, stats on cream, and a full-region surface |
| muted | `#6B6B6B` | gray: body on cream, meta labels, card copy |
| ink | `#1A1A1A` | third surface for quote and statement pages; text on it is cream |
| coral-dark | `#D44A4A` | start of the 135° feature gradient; chart comparison series |
| cream-dark | `#E8E0D4` | subtle region differentiation, sparingly |
| light-gray | `#B0B0B0` | tertiary text, sparingly |
| white | `#FFFFFF` | card and tile fills only |
| hatch | `rgba(0,0,0,0.06)` | 45° hatch stripes on coral |
| numeral | `rgba(0,0,0,0.12)` | wallpaper numerals inside coral |
| mark | `rgba(0,0,0,0.35)` | giant quote marks inside coral |
| rule | `rgba(26,26,26,0.15)` | 3px title rule under the cover title |

## Typography

- Display font: `"Bebas Neue", "Arial Narrow", Impact, sans-serif` at its only weight, 400. Every headline, stat, title, meta figure and numeral; always uppercase, always tracked (0.03em default, 12px on jumbo words).
- Body font: `"Inter", system-ui, -apple-system, sans-serif` at 300 (pull quotes only), 400 body, 600 meta labels, 700 eyebrows. Labels are uppercase with 0.05–0.3em tracking. No italics, no underline, no third face.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:wght@300;400;600;700&display=swap`
- Type scale (source `clamp()` at 1920 wide; body and labels raised from web sizes into slide-authoring's range):
  - Hero title: 160px, line-height 0.9 (the source caps at 120 for short laptops; the fixed stage fits three lines)
  - Giant mark 280px · jumbo word and background numeral 200px (deliberately oversized)
  - Display statement 100px · section headline 96px · column title 72px, line-height 1
  - Stat 120px (coral on cream) · card stat 64px · sidebar value and meta figure 56px · card title 44px
  - Pull quote 40px Inter 300, lh 1.5 · body 32px, lh 1.65 · card and item text 28px, lh 1.6
  - Eyebrow 22px Inter 700, 0.3em · meta label 20px Inter 600, 0.25em · counter 26px Bebas
- CJK: Bebas falls back to `"ZCOOL XiaoWei"`; drop tracking and uppercase on Hanzi runs.

## Layout

- Content padding: 100px horizontal, 80px vertical (1920×1080). Regions pad 60px inside, cards 40px, grid gap 32px.
- No chrome bar. Each page is one to three solid regions (coral, ink, cream) meeting at hard edges; the edge is the layout.
- Standard splits: cover rows `346px 1fr` (coral strip over cream body); feature `1fr auto` (region over a cream info bar: Bebas 56px title left, Inter label right); columns `1fr 1fr` (often coral beside ink); quote `768px 1fr` (coral mark panel beside an ink body); or one cream or ink surface.
- Density is medium and structured by region: each region holds one complete composition. A sparse coral region gets a wallpaper numeral or giant mark.
- Radius is 0 everywhere; circles only for timeline nodes.

## Fixed components

### Title

```tsx
// Hero at 160; size={96} for page headlines, 72 for column titles.
// Ink on cream and coral, cream '#F5F0E8' on ink, coral only for emphasis on cream.
const Title = ({ children, size = 160, color = '#1A1A1A' }: { children: React.ReactNode; size?: number; color?: string }) => (
  <h1
    style={{
      fontFamily: '"Bebas Neue", "Arial Narrow", Impact, sans-serif',
      fontSize: size,
      fontWeight: 400,
      lineHeight: size >= 120 ? 0.9 : 1,
      letterSpacing: '0.03em',
      textTransform: 'uppercase',
      margin: 0,
      color,
    }}
  >
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// A lone Bebas counter in the corner; the source has no other chrome. onDark on ink or coral.
const Footer = ({ onDark = false }: { onDark?: boolean }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div
      style={{
        position: 'absolute',
        right: 100,
        bottom: 36,
        fontFamily: '"Bebas Neue", "Arial Narrow", sans-serif',
        fontSize: 26,
        lineHeight: 1,
        letterSpacing: '0.1em',
        color: onDark ? 'rgba(245,240,232,0.6)' : 'rgba(26,26,26,0.5)',
      }}
    >
      {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Coral on cream and ink; color="#1A1A1A" on coral (never coral on coral).
const Eyebrow = ({ children, color = '#E85D5D' }: { children: React.ReactNode; color?: string }) => (
  <div style={{ fontFamily: '"Inter", system-ui, sans-serif', fontSize: 22, fontWeight: 700, lineHeight: 1, letterSpacing: '0.3em', textTransform: 'uppercase', color }}>
    {children}
  </div>
);

// 80×4 coral rule under a headline; width={60} above a quote attribution or on closers.
const AccentLine = ({ width = 80 }: { width?: number }) => <div style={{ width, height: 4, background: '#E85D5D' }} />;
```

## Motion

- Philosophy: static. Hard colour edges and oversized type do the work; pages cut or take a plain 240ms fade, with no entrance animation.

## Aesthetic

A mid-century travel poster crossed with a sports-magazine cover: Saul Bass titles, solid colour planes, condensed caps used as architecture. Three surfaces (coral fire, ink black, warm cream paper) meet at hard edges, and the meeting is the layout. Bebas Neue declares every headline, stat and figure in tracked uppercase; Inter explains in gray body copy and small tracked caps, dropping to weight 300 for the one personal voice, the pull quote. Coral is both the accent (4–5px borders, icon squares, eyebrows) and a whole environment, textured by a faint 45° hatch and filled out with wallpaper numerals. Flat by design: no shadows, no radius, no gradient except the one coral-dark to coral feature fill, and never a fourth surface colour.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', display: 'grid', gridTemplateRows: '346px 1fr', background: '#F5F0E8' }}>
    <div style={{ position: 'relative', background: '#E85D5D', padding: '48px 100px' }}>
      <Zigzag />
      <div style={{ position: 'relative' }}>
        <Eyebrow color="#1A1A1A">Northwind · Q3 2026</Eyebrow>
      </div>
    </div>
    <div style={{ display: 'flex', flexDirection: 'column', padding: '56px 100px 104px' }}>
      <Title>Quarterly Strategy Session</Title>
      <TitleRule />
      <div style={{ marginTop: 'auto', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
        <Meta label="Location" value="7th Floor" />
        <Meta label="May 15 / 09:00 start" value="2026" align="right" />
      </div>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// 45° hatch on every coral region. Variants: angle={-45} stride={30}; angle={90} stride={60} line={2} alpha={0.1}.
const Hatch = ({ angle = 45, stride = 20, line = stride, alpha = 0.06 }: { angle?: number; stride?: number; line?: number; alpha?: number }) => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', backgroundImage: `repeating-linear-gradient(${angle}deg, transparent 0 ${stride}px, rgba(0,0,0,${alpha}) ${stride}px ${stride + line}px)` }} />
);
const FEATURE_BG = 'linear-gradient(135deg, #D44A4A, #E85D5D)';

// Cover strip zigzag: overshoots the canvas edges, so data-bleed.
const Zigzag = () => (
  <svg aria-hidden data-bleed viewBox="0 0 1200 400" preserveAspectRatio="xMidYMid slice" style={{ position: 'absolute', inset: 0, width: '100%', height: '100%', pointerEvents: 'none' }}>
    <polyline points="-50,320 50,120 150,320 250,120 350,320 450,120 550,320 650,120 750,320 850,120 950,320 1050,120 1150,320 1250,120" fill="none" stroke="#1A1A1A" strokeWidth={18} opacity={0.22} />
    <polyline points="-50,380 50,180 150,380 250,180 350,380 450,180 550,380 650,180 750,380 850,180 950,380 1050,180 1150,380 1250,180" fill="none" stroke="#1A1A1A" strokeWidth={12} opacity={0.15} />
  </svg>
);

// Wallpaper numeral behind a coral title. Giant quote mark: size={280} alpha={0.35}, children '"'.
const BgNumeral = ({ children, size = 200, alpha = 0.12 }: { children: React.ReactNode; size?: number; alpha?: number }) => (
  <div aria-hidden style={{ position: 'absolute', top: 24, right: 48, fontFamily: '"Bebas Neue", sans-serif', fontSize: size, lineHeight: 1, color: `rgba(0,0,0,${alpha})`, pointerEvents: 'none' }}>
    {children}
  </div>
);

const TitleRule = () => <div style={{ width: '100%', height: 3, marginTop: 32, background: 'rgba(26,26,26,0.15)' }} />;
const Meta = ({ label, value, align = 'left' }: { label: string; value: string; align?: 'left' | 'right' }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 8, alignItems: align === 'right' ? 'flex-end' : 'flex-start' }}>
    <span style={{ fontFamily: '"Inter", system-ui, sans-serif', fontSize: 20, fontWeight: 600, letterSpacing: '0.25em', textTransform: 'uppercase', color: '#6B6B6B' }}>{label}</span>
    <span style={{ fontFamily: '"Bebas Neue", sans-serif', fontSize: 56, lineHeight: 1, letterSpacing: '0.04em', color: '#1A1A1A' }}>{value}</span>
  </div>
);

const Card = ({ glyph, title, children }: { glyph: string; title: string; children: React.ReactNode }) => (
  <div style={{ background: '#FFFFFF', borderTop: '5px solid #E85D5D', padding: 40, display: 'flex', flexDirection: 'column', gap: 24 }}>
    <div style={{ width: 64, height: 64, display: 'grid', placeItems: 'center', background: '#E85D5D', color: '#FFFFFF', fontFamily: '"Bebas Neue", sans-serif', fontSize: 36 }}>{glyph}</div>
    <div style={{ fontFamily: '"Bebas Neue", sans-serif', fontSize: 44, lineHeight: 1.1, letterSpacing: '0.03em', color: '#1A1A1A' }}>{title}</div>
    <p style={{ margin: 0, fontFamily: '"Inter", system-ui, sans-serif', fontSize: 28, lineHeight: 1.6, color: '#6B6B6B' }}>{children}</p>
  </div>
);

const Tile = ({ value, label }: { value: string; label: string }) => (
  <div style={{ background: '#FFFFFF', borderLeft: '4px solid #E85D5D', padding: '28px 32px' }}>
    <div style={{ fontFamily: '"Bebas Neue", sans-serif', fontSize: 56, lineHeight: 1, letterSpacing: '0.02em', color: '#1A1A1A' }}>{value}</div>
    <div style={{ marginTop: 10, fontFamily: '"Inter", system-ui, sans-serif', fontSize: 22, letterSpacing: '0.05em', color: '#6B6B6B' }}>{label}</div>
  </div>
);

const Rail = () => <div style={{ height: 4, backgroundImage: 'repeating-linear-gradient(90deg, #1A1A1A 0 20px, transparent 20px 30px)' }} />;
const Node = () => <span style={{ width: 28, height: 28, boxSizing: 'border-box', borderRadius: '50%', background: '#E85D5D', border: '4px solid #F5F0E8' }} />;
```

## Do / Don't

- Do build every page from one to three solid regions meeting at hard edges.
- Do set every Bebas element uppercase and tracked: ink on cream and coral, cream on ink, coral only for stats and emphasis on cream.
- Do put `<Hatch />` on every coral region, and a `<BgNumeral>` or giant mark when the region feels sparse.
- Do set eyebrows in coral on cream and ink, in ink on coral.
- Do give pull quotes Inter 300 on ink, beside a coral panel holding a giant mark.
- Do chart with coral as the primary series and coral-dark for comparison.
- Don't add a fourth surface colour or a second accent.
- Don't round rectangles, add shadows, or soften region edges with gradients.
- Don't set headlines in gray, or white on coral.
- Don't pair Bebas with another body face, or use italics and underlines.
