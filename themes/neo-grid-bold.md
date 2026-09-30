---
name: Neo-Grid Bold
description: "Editorial neo-brutalism on a strict 12 × 8 panel grid: putty paper, ink blocks and one electric lemon accent."
mode: light
mood: [confident, punchy, editorial, modern]
tone: [bold, minimal, design-led, graphic]
formality: medium
density: high
scheme: light
best_for: "Design-led pitches, brand work, founder talks and keynotes, especially stat-heavy, comparison and process slides that should read design-led rather than corporate."
avoid_for: "Contexts that need to feel quiet, traditional or warm; the neon-yellow accent and uppercase display commit to a loud editorial voice."
source: bold:neo-grid-bold
---

# Neo-Grid Bold

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#ECECE8` | putty: the 40px passe-partout and 12px panel gaps |
| text | `#0A0A0A` | ink: text on paper/lemon, inverted panels, every rule |
| accent | `#E6FF3D` | electric lemon: signal panels, `<Mark>`, series B, yes pill; never text on light |
| muted | `#8A8A85` | graphite, rare; mute labels with opacity 0.7–0.85 instead |
| paper | `#F5F4EF` | warm ecru: default panel fill, text on ink |
| photo | `#111111` | image panel, B&W grain until a real photo |

Three panel fills (paper, ink, lemon) plus photo. No fourth colour, ever.

## Typography

- Display: `"Space Grotesk", "Helvetica Neue", Helvetica, Arial, sans-serif`, weight 700, always uppercase, negative tracking.
- Body: Space Grotesk 400, mixed case, never uppercase, never bold.
- Label: `"JetBrains Mono", ui-monospace, monospace`, 400, always uppercase, 0.08–0.12em tracking (page number 0.04em).
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;700&family=JetBrains+Mono:wght@400&display=swap`
- Type scale (source is px at 1920; kept exact, deliberately dense):
  - Section ordinal 320px / lh 0.85 / -0.05em · stat 240 (featured panel), 156 (default), 96 (small card) / lh 0.85–0.9 / -0.03 to -0.04em
  - Display 132px / 0.92 / -0.02em (cover, section) · title 88px / 0.95 / -0.015em (content headline)
  - Subtitle 56px / 1 / -0.01em · card headline 44px · card h3 30px / 1.05 / -0.005em
  - Body 28px / 1.35 · dense-card body 22px / 1.45 (below slide-authoring's default; cards only)
  - Label 24px · label-sm 16px (metadata) · label-xs 14px (axes, table heads, 0.12em)
- CJK: Noto Sans SC 900 for display (400 body), tracking 0, no uppercase; keep `<Mark>`.

## Layout

- Page background putty; everything sits in `Frame`: `inset: 40`, 12 columns × 8 rows, 12px gap (18px for breathing room). A cell is ~142 × 114px.
- Compose only by spanning panels (`gridColumn: '4 / span 5'`). Flex is for alignment inside one panel. The 100–160px padding rule does not apply: panels are the padding.
- Dense: 4–8 panels per page, grid filled corner to corner. Empty cells read as broken.
- Panel padding: 24×28 compact stat, 28×32 standard, 36×32 large, 40×44 hero.
- Only the page number, corner mark and a 16px mono copyright line (left/bottom 22) sit off-grid.

## Fixed components

### Title

```tsx
// size: 132 display (cover/section), 88 title (default), 56 subtitle, 44 card headline.
// Colour comes from the Panel it sits in.
const Title = ({ children, size = 88 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Space Grotesk", "Helvetica Neue", Helvetica, Arial, sans-serif', fontSize: size, fontWeight: 700, lineHeight: size > 88 ? 0.92 : size > 56 ? 0.95 : 1, letterSpacing: size > 88 ? '-0.02em' : size > 56 ? '-0.015em' : '-0.01em', textTransform: 'uppercase', margin: 0 }}>
    {children}
  </h1>
);

// Highlighter swatch around one to three words: the headline emphasis. Paper or ink panels only.
const Mark = ({ children }: { children: React.ReactNode }) => (
  <mark style={{ background: '#E6FF3D', color: '#0A0A0A', padding: '0 0.06em' }}>{children}</mark>
);

// Upright lemon colour switch: on ink panels only.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'normal', color: '#E6FF3D' }}>{children}</em>
);
```

### Footer

The page-number tag, flush to the canvas's bottom-left corner. Pick the tone that contrasts with the lower-left panel.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ tone = 'paper' }: { tone?: 'paper' | 'ink' | 'lemon' }) => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  const bg = { paper: '#F5F4EF', ink: '#0A0A0A', lemon: '#E6FF3D' }[tone];
  return (
    <div style={{ position: 'absolute', left: 0, bottom: 0, padding: '14px 22px', background: bg, color: tone === 'ink' ? '#F5F4EF' : '#0A0A0A', fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 24, lineHeight: 1.2, letterSpacing: '0.04em' }}>
      {pad(current)} / {pad(total)}
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Mono kicker; inherits the panel's text colour, muted by opacity.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 24, lineHeight: 1.2, letterSpacing: '0.08em', textTransform: 'uppercase', opacity: 0.75 }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. A poster does not move; pages cut, and the weight comes from panel colour, not animation.

## Aesthetic

A heavy editorial poster: brutalist annual reports, magazine spreads, design-week posters. Every page is a rigid 12 × 8 grid of square, borderless panels in paper, ink and electric lemon, framed by putty that shows through the gaps. Depth is colour adjacency alone: more lemon, louder page. Tight Space Grotesk 700 uppercase shouts, mono uppercase labels read as metadata, body stays calm. Numerals may swallow a whole panel. No shadows, rounded corners, gradients (bar photo grain), italics or second accent.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#ECECE8', color: '#0A0A0A', fontFamily: '"Space Grotesk", "Helvetica Neue", Helvetica, Arial, sans-serif' }}>
    <Frame>
      <Panel col="1 / span 3" row="1 / span 8" fill="photo" />
      <Panel col="4 / span 6" row="1 / span 3" fill="lemon">
        <QrTile />
      </Panel>
      <Panel col="10 / span 3" row="1 / span 3" fill="ink" style={{ display: 'flex', alignItems: 'flex-end' }}>
        <Stamp size={96} color="#E6FF3D" />
      </Panel>
      <Panel col="4 / span 9" row="4 / span 5" pad="40px 44px" style={{ display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
        <CornerMark />
        <Eyebrow>Launch · 2026</Eyebrow>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 28 }}>
          <Title size={132}>The Big <Mark>Idea</Mark></Title>
          <p style={{ fontSize: 28, lineHeight: 1.35, margin: 0, maxWidth: 900 }}>A short subtitle that explains what this deck is about.</p>
        </div>
      </Panel>
    </Frame>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// The universal frame. minmax(0, 1fr) keeps tracks rigid when a panel's content is tall.
const Frame = ({ children, gap = 12 }: { children: React.ReactNode; gap?: number }) => (
  <div style={{ position: 'absolute', inset: 40, display: 'grid', gridTemplateColumns: 'repeat(12, minmax(0, 1fr))', gridTemplateRows: 'repeat(8, minmax(0, 1fr))', gap }}>{children}</div>
);

// Panel fills. photo = B&W grain stand-in; replace with a full-bleed <img> when a real photo exists.
const FILLS = {
  paper: { background: '#F5F4EF', color: '#0A0A0A' },
  ink: { background: '#0A0A0A', color: '#F5F4EF' },
  lemon: { background: '#E6FF3D', color: '#0A0A0A' },
  photo: { background: 'repeating-linear-gradient(135deg, rgba(255,255,255,0.04) 0 2px, transparent 2px 8px), radial-gradient(120% 80% at 30% 30%, #2A2A2A, #0A0A0A 70%)', color: '#FFFFFF' },
} as const;

// A grid span with one fill: square, borderless, shadowless.
const Panel = ({ col, row, fill = 'paper', pad = '28px 32px', style, children }: { col: string; row: string; fill?: keyof typeof FILLS; pad?: string; style?: React.CSSProperties; children?: React.ReactNode }) => (
  <div style={{ gridColumn: col, gridRow: row, position: 'relative', padding: pad, ...FILLS[fill], ...style }}>{children}</div>
);

// 2×2 block stamp in currentColor. Default = blockmark (diagonal, 56–96px, ink or lemon).
const Stamp = ({ size = 56, cells = [1, 0, 0, 1], color = 'currentColor', style }: { size?: number; cells?: number[]; color?: string; style?: React.CSSProperties }) => (
  <div aria-hidden style={{ width: size, height: size, flexShrink: 0, display: 'grid', gridTemplateColumns: '1fr 1fr', gridTemplateRows: '1fr 1fr', gap: 4, ...style }}>
    {cells.map((on, i) => <span key={i} style={{ background: on ? color : 'transparent' }} />)}
  </div>
);

// 36px identity tag, three of four filled, pinned top-right of a panel.
const CornerMark = () => <Stamp size={36} cells={[1, 0, 1, 1]} style={{ position: 'absolute', top: 22, right: 22 }} />;

// Decorative 5 × 5 ink/lemon checker "QR" tile: a cover flourish, not a real code.
const QrTile = ({ size = 90 }: { size?: number }) => (
  <div aria-hidden style={{ width: size, height: size, flexShrink: 0, backgroundImage: 'conic-gradient(#E6FF3D 25%, #0A0A0A 0 50%, #E6FF3D 0 75%, #0A0A0A 0)', backgroundSize: `${size * 0.4}px ${size * 0.4}px` }} />
);

// Flow arrow between process steps, or out-pointer at a stat panel's bottom-right (64px; 24px inline).
const Arrow = ({ size = 64, color = 'currentColor' }: { size?: number; color?: string }) => (
  <svg aria-hidden viewBox="0 0 64 64" width={size} height={size} fill="none" stroke={color} strokeWidth={4}><path d="M8 32 H56 M40 16 L56 32 L40 48" /></svg>
);

// Stat numeral: 156 default, 240 when it owns a featured panel, 96 in a small card. Section ordinal: 320, -0.05em.
const Stat = ({ children, size = 156 }: { children: React.ReactNode; size?: number }) => (
  <div style={{ fontFamily: '"Space Grotesk", "Helvetica Neue", Arial, sans-serif', fontSize: size, fontWeight: 700, lineHeight: size > 156 ? 0.85 : 0.9, letterSpacing: size > 156 ? '-0.04em' : '-0.03em' }}>{children}</div>
);

// Comparison pills: square despite the name. yes = lemon, part = outlined paper, no = ink.
const PILLS = { yes: { background: '#E6FF3D', color: '#0A0A0A' }, part: { background: '#F5F4EF', color: '#0A0A0A', border: '1.5px solid #0A0A0A' }, no: { background: '#0A0A0A', color: '#F5F4EF' } } as const;
const Pill = ({ kind, children }: { kind: keyof typeof PILLS; children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', padding: '6px 14px', fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 16, letterSpacing: '0.08em', textTransform: 'uppercase', ...PILLS[kind] }}>{children}</span>
);

// Tables: ink head row (14px mono, 0.12em); cells 18px 22px, 24px text, 1.5px ink rules bottom + right.
// Bar pairs: series A ink, B lemon with 1.5px ink border; axes 2px ink; grid 1px dashed rgba(0,0,0,0.18).
```

## Do / Don't

- Do build every page from `Frame` + `Panel` spans; fill the grid corner to corner with 4–8 panels.
- Do default to paper, use ink for contrast, and lemon for one to three signal panels per page.
- Do set headlines and numerals in Space Grotesk 700 uppercase, tighter as they grow.
- Do emphasise with `<Mark>` (or `<Em>` on ink), and let stats scale to 156–320px in a featured panel.
- Do put the page-number tag on every page, toned against the lower-left panel.
- Don't add shadows, rounded corners, borders on cards, gradients or italics.
- Don't use lemon as text on paper or lemon, or introduce any second accent colour.
- Don't uppercase or bold body copy; isolate the point in its own panel.
- Don't position content off-grid; only the page number, corner mark and copyright may.
