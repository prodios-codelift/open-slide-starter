---
name: Editorial Forest
description: "Forest green, dusty rose and oat-cream paper under Source Serif 4 at weight 500, with tracked JetBrains Mono chrome: a quiet literary quarterly."
mode: dark
mood: [editorial, quiet, considered, warm]
tone: [literary, thoughtful, warm, low-pressure]
formality: medium
density: medium
scheme: mixed
best_for: "Quarterly reviews, internal readouts, studio or agency updates, research recaps and retrospectives that should feel warm and unhurried rather than corporate."
avoid_for: "Contexts that need to feel urgent, punchy or sales-driven — the palette and rhythm are intentionally quiet."
source: bold:editorial-forest
---

# Editorial Forest

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#2E4A2A` | forest green: cover, statement, data, summary pages |
| text | `#EFE7D4` | oat cream: headlines and body on green |
| accent | `#E89CB1` | dusty rose: hero type, labels, rules, monogram, bars on green |
| muted | `#3A5A36` | green-lite: second green tile beside green, carries pink text |
| paper | `#EFE7D4` | cream as a surface: default content-page background |
| paper-2 | `#E6DCC4` | cream-2: tile fill on cream, always with a 2px green border |
| ink | `#1A1A17` | warm near-black body on cream; never `#000` |
| green-deep | `#243A21` | all text and rules on pink surfaces |
| pink-deep | `#D27E96` | border on pink tiles only |

Three families only: green, pink, cream. No fourth hue, no rgba surfaces.

## Typography

- Display + body font: `"Source Serif 4", "Source Serif Pro", Georgia, serif` — weight 500 for every headline, figure and card title; 400 for body paragraphs only; 600 only for a proper name in an attribution. Load the optical-size axis (opsz 8..60): small and 220px sizes get different letterforms. No italics, no underline.
- Chrome font: `"JetBrains Mono", ui-monospace, Menlo, monospace` — 500, always uppercase, 0.14–0.18em tracking (0.08em on axis ticks). Labels, captions, ordinals, footlines; never headline scale. No third face.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Source+Serif+4:opsz,wght@8..60,400;8..60,500;8..60,600&family=JetBrains+Mono:wght@500&display=swap`
- Type scale (source is px at 1920; deliberately oversized at the top):
  - Hero / stat figure: 220px, lh 0.92, -0.02em (figures -0.03em; unit suffix 110px)
  - Statement / pull-quote: 140px, lh 1.02, -0.02em
  - Headline: 96px on cream, 84px on green; lh 0.96–1.0, -0.02em (`Title` default 96)
  - Card titles: 84 / 68 / 56px, lh 0.96–0.98, -0.01em
  - Body: 32px lead, 30px body, 400, lh 1.32–1.38; 26px inside tiles (below the usual floor by design: keep it to two lines)
  - Labels: 26px (eyebrow 0.18em, captions 0.14em); 24px tile ordinals, KPI tags, meta terms
- CJK: fall back to `"LXGW WenKai TC"` (display) / `"Noto Serif SC"` (body); letter-spacing 0, +0.08 line-height, no uppercase.

## Layout

- Padding (1920×1080): 96px 120px content; 100px 140px cover and summary; 130px 160px statement.
- Every page opens with `TopBar`: Eyebrow left, Monogram (cover/summary only) or a mono counter right. Cover, data and summary pages add the `Footer` footline at bottom 72.
- Surfaces: green for cover, statement, data, summary; cream for content; pink for the odd section break. One dominant surface per page, two at most.
- Colour follows the region. Green: headline cream (hero pink), body cream, labels and rules pink. Cream: headline green, body ink, labels and rules green. Pink: everything green-deep.
- Grids: 24–28px gaps for tiles, 60px for KPI rows. Radii: 6px topic tile, 8px step tile, 3px bar tops, 2px legend swatch, 50% monogram only.
- One subject per page with deep negative space. Fewer, larger elements.

## Fixed components

### Title

```tsx
// Cream page: default. Green page: size={84} color="#EFE7D4". Cover/closing: size={220} color="#E89CB1".
const Title = ({ children, size = 96, color = '#2E4A2A' }: { children: React.ReactNode; size?: number; color?: string }) => (
  <h1 style={{ fontFamily: '"Source Serif 4", "Source Serif Pro", Georgia, serif', fontSize: size, fontWeight: 500, lineHeight: size >= 140 ? 0.92 : 0.98, letterSpacing: '-0.02em', margin: 0, color }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Footline. color: pink on green, '#2E4A2A' on cream, '#243A21' on pink. inset = the page's side padding.
const Footer = ({ label, color = '#E89CB1', inset = 120 }: { label: string; color?: string; inset?: number }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: inset, right: inset, bottom: 72, display: 'flex', justifyContent: 'space-between', fontFamily: '"JetBrains Mono", ui-monospace, Menlo, monospace', fontSize: 24, fontWeight: 500, lineHeight: 1, letterSpacing: '0.14em', textTransform: 'uppercase', color }}>
      <span>{label}</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Topbar label. color follows the region like Footer.
const Eyebrow = ({ children, color = '#E89CB1' }: { children: React.ReactNode; color?: string }) => (
  <div style={{ fontFamily: '"JetBrains Mono", ui-monospace, Menlo, monospace', fontSize: 26, fontWeight: 500, lineHeight: 1, letterSpacing: '0.18em', textTransform: 'uppercase', color }}>
    {children}
  </div>
);

// The system's spine: on every page, Eyebrow left, Monogram or counter right.
const TopBar = ({ children }: { children: React.ReactNode }) => (
  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>{children}</div>
);
```

## Motion

- Philosophy: static. A printed page: slides cut, nothing fades, slides or glows.

## Aesthetic

A literary quarterly or art-book monograph in slide form: a Penguin classic, an Apartamento spread, a quiet annual report. One confident serif, Source Serif 4 at weight 500 with tight tracking, carries everything from 220px cover lines to body copy, while uppercase tracked JetBrains Mono does the editorial chrome. Deep forest green, dusty rose and oat cream are used as solid ink on paper; elevation is only colour block, filled-versus-bordered tiles, and 2px hairlines. Spacious and committed: one subject per page. No shadows, gradients, glows, italics, sharp corners or fourth colour.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#2E4A2A', color: '#EFE7D4', position: 'relative', padding: '100px 140px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
    <TopBar>
      <Eyebrow>Studio Review · 2026</Eyebrow>
      <Monogram>SR</Monogram>
    </TopBar>
    <div style={{ display: 'flex', flexDirection: 'column', gap: 36, marginBottom: 72 }}>
      <Title size={220} color="#E89CB1">The Quiet Year</Title>
      <Rule />
      <p style={{ fontFamily: '"Source Serif 4", Georgia, serif', fontSize: 32, fontWeight: 400, lineHeight: 1.32, margin: 0, maxWidth: 1100 }}>A short subtitle that sets up the deck.</p>
    </div>
    <Footer label="Studio Review" inset={140} />
  </div>
);
```

## Signature elements

```tsx
const serif = '"Source Serif 4", "Source Serif Pro", Georgia, serif';
const cap = { fontFamily: '"JetBrains Mono", ui-monospace, Menlo, monospace', fontSize: 24, fontWeight: 500, lineHeight: 1, letterSpacing: '0.14em', textTransform: 'uppercase' } as const;

// Identity stamp, cover and summary only: 130px outlined circle, 2-3 mono letters.
const Monogram = ({ children }: { children: React.ReactNode }) => (
  <div style={{ ...cap, fontSize: 28, letterSpacing: '0.1em', paddingLeft: '0.1em', width: 130, height: 130, borderRadius: '50%', border: '2px solid #E89CB1', color: '#E89CB1', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>{children}</div>
);

// 2px hairline between stacked sections; region accent (pink / #2E4A2A / #243A21). Never 1px or 3px+.
const Rule = ({ color = '#E89CB1' }: { color?: string }) => <div style={{ height: 2, background: color }} />;

// Topic tile, radius 6. Rotate fills across a grid (use 3 of 4): green/#E89CB1, pink/#243A21 + border #D27E96,
// #3A5A36/#E89CB1, #E6DCC4/#2E4A2A + 2px green border. Step tile: radius 8, 2.5px border, 68px title, minHeight 470.
const Tile = ({ n, title, foot, bg = '#2E4A2A', fg = '#E89CB1', border = bg }: { n: string; title: string; foot: string; bg?: string; fg?: string; border?: string }) => (
  <div style={{ display: 'flex', flexDirection: 'column', justifyContent: 'space-between', gap: 40, padding: '40px 40px 36px', borderRadius: 6, background: bg, border: `2px solid ${border}`, color: fg }}>
    <span style={cap}>{n}</span>
    <div style={{ fontFamily: serif, fontSize: 56, fontWeight: 500, lineHeight: 0.98, letterSpacing: '-0.01em' }}>{title}</div>
    <span style={cap}>{foot}</span>
  </div>
);

// KPI on green: row sits under a <Rule />, 60px gaps. Figure is always 220px; restructure rather than shrink.
const Kpi = ({ tag, value, unit, children }: { tag: string; value: string; unit?: string; children: React.ReactNode }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 24 }}>
    <span style={{ ...cap, color: '#E89CB1' }}>{tag}</span>
    <div style={{ fontFamily: serif, fontSize: 220, fontWeight: 500, lineHeight: 0.92, letterSpacing: '-0.03em', color: '#E89CB1' }}>{value}<span style={{ fontSize: 110 }}>{unit}</span></div>
    <p style={{ fontFamily: serif, fontSize: 30, fontWeight: 400, lineHeight: 1.38, margin: 0, color: '#EFE7D4' }}>{children}</p>
  </div>
);

// Chart bar on green: 56px, pink/cream/green fills, value 38px above. Axes: 2px cream rules on left and bottom only.
// Legend: 26x26 swatch (radius 2) before a cap label.
const Bar = ({ h, value, fill = '#E89CB1' }: { h: number; value: string; fill?: string }) => (
  <div style={{ position: 'relative', width: 56, height: h, background: fill, borderRadius: '3px 3px 0 0' }}>
    <span style={{ ...cap, letterSpacing: '0.08em', position: 'absolute', top: -38, left: '50%', transform: 'translateX(-50%)', color: '#EFE7D4' }}>{value}</span>
  </div>
);

// Meta row on cream: <dl style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 36, borderTop: '2px solid #2E4A2A', paddingTop: 28, margin: 0 }}>
const Meta = ({ term, value }: { term: string; value: string }) => (
  <div>
    <dt style={{ ...cap, color: '#2E4A2A' }}>{term}</dt>
    <dd style={{ margin: '14px 0 0', fontFamily: serif, fontSize: 32, fontWeight: 500, color: '#1A1A17' }}>{value}</dd>
  </div>
);
```

## Do / Don't

- Do run every headline in Source Serif 4 500 with negative tracking and 0.92–1.0 line-height; body drops to 400.
- Do set every label, caption, ordinal and footline in uppercase tracked JetBrains Mono.
- Do open every page with `TopBar`; keep `Monogram` for cover and summary.
- Do scale up (140–220px) for cover, statement, stat and closing moments when there is room.
- Do rotate tile fills in a grid and separate stacked sections with 2px hairlines.
- Don't add shadows, gradients, glows, transparency or a fourth hue.
- Don't use italics, underline, sentence-case mono, or a third typeface.
- Don't put 26–30px text in pink-on-green or green-on-pink; small text is cream on green, ink on cream.
- Don't crowd: two competing blocks on one page means split it.
