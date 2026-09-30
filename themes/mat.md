---
name: Mat
description: "Dark forest-green canvas warmed by a wood-brown corner glow, cream Bricolage type floating on the field, one burnt-orange accent; mid-century and tactile."
mode: dark
mood: [warm-modern, considered, tactile, mid-century]
tone: [warm, design-led, intentional, considered]
formality: medium
density: medium
scheme: mixed
best_for: "Design studio credentials, architecture, interior, craft and furniture brands, advisory decks, and tech or research talks that want a considered analog feel."
avoid_for: "Contexts that need fast tech energy or institutional restraint — the muted sage and burnt-orange palette is intentionally warm and slow."
source: bold:mat
---

# Mat

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#232E26` | dark forest green, the default surface of every page |
| text | `#F0E8D2` | cream ink: headlines and primary copy on green |
| accent | `#C07030` | burnt orange: kicker, rule, em-dash bullet, inline `<Em>`, quote glyph, one chart bar |
| muted | `rgba(240,232,210,0.58)` | cream 58% (≈ `#9A9A8A`): lead, body, footer labels |
| faint | `rgba(240,232,210,0.3)` | cream 30%: metadata, chart bars |
| bg-alt | `#2E3D30` | lighter green for a recessed region; use sparingly |
| paper | `#EDE6D0` | info-card fill and the light-page background |
| paper-alt | `#E4DAC4` | image placeholders on light pages |
| ink | `#1E2820` | text on paper; never pure black |
| ink-muted | `rgba(30,40,32,0.6)` | body on paper |
| wood-glow | `#7A4E24` | corner glow only, at 0.28 / 0.14 alpha; never a flat fill |
| hairline | `rgba(240,232,210,0.12)` | every 1px divider on green |
| hairline-paper | `rgba(30,40,32,0.14)` | every 1px divider on paper |

## Typography

- Display font: `"Bricolage Grotesque", "DM Sans", system-ui, sans-serif` at 800 (display, h1, stats), 700 (h2), 600 (h3, quote). Always mixed case, always negative tracking.
- Body font: `"DM Sans", system-ui, -apple-system, sans-serif` at 400. No italics anywhere.
- Label font: `"DM Mono", ui-monospace, monospace` at 400, uppercase, 0.12em tracking: kickers, chrome, footers, bullet dashes, chart labels.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,600..800&family=DM+Sans:wght@400&family=DM+Mono:wght@400&display=swap`
- Type scale (source `vw` at 1920 wide; body and labels raised into slide-authoring's range):
  - Display (cover only): 230px, 800, lh 0.88, -0.03em. Deliberately oversized, 1–2 words per line.
  - H1 (chapter, closer): 134px, 800, lh 0.92, -0.025em (`Title` default)
  - H2 (page headline): 77px, 700, lh 1, -0.02em · H3: 46px, 600, lh 1.1, -0.01em
  - Stat 106px, 800, -0.025em · quote text 65px, 600, lh 1.2 · quote mark 154px, 800, orange
  - Lead 36px, lh 1.55 · body 32px, lh 1.65 · caption 24px
  - Label 22px DM Mono, uppercase, 0.12em
- CJK: append `"Noto Serif SC"` to every stack; no uppercase or negative tracking on Hanzi, labels 0.05em.

## Layout

- Content padding: 106px horizontal. Chrome and foot bands sit 59px from the top and bottom edges; body content stays between y≈160 and y≈920. Covers center vertically with 120px top and bottom.
- Gaps: 49px between sections, 30px between related elements, 15px inside a label pair.
- Medium-sparse: one headline moment plus one supporting block. Stats (3-up) and compare (2-up, split by a 1px `hairline` column) are the only multi-column pages.
- Layering: `WoodGlow` first on every green page, content above it in `position: 'relative'`.
- Light page (once per deck, as a tonal break): `paper` background, `ink` headlines, `ink-muted` body, `hairline-paper` rules, no glow; kicker stays orange.
- Radius 0 on everything. No shadows.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 134 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Bricolage Grotesque", "DM Sans", system-ui, sans-serif', fontSize: size, fontWeight: 800, lineHeight: size > 180 ? 0.88 : 0.92, letterSpacing: size > 180 ? '-0.03em' : '-0.025em', margin: 0, color: '#F0E8D2' }}>
    {children}
  </h1>
);
```

### Footer

Foot band: label pair under a 1px hairline. Pass real deck chrome (company, section) as `label`.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ label }: { label?: string }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 106, right: 106, bottom: 59, display: 'flex', justifyContent: 'space-between', paddingTop: 15, borderTop: '1px solid rgba(240,232,210,0.12)', fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, letterSpacing: '0.12em', textTransform: 'uppercase', color: 'rgba(240,232,210,0.58)' }}>
      <span>{label}</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Kicker: always orange, whatever the surface.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, letterSpacing: '0.12em', textTransform: 'uppercase', color: '#C07030' }}>{children}</div>
);

// 32×1 orange rule between kicker and headline.
const Rule = () => <div style={{ width: 32, height: 1, background: '#C07030' }} />;

// Orange inline emphasis, upright: stat suffixes, key digits, attributions. Never in a headline.
const Em = ({ children }: { children: React.ReactNode }) => <em style={{ fontStyle: 'normal', color: '#C07030' }}>{children}</em>;
```

## Motion

- Philosophy: static. Pages cut instantly; the corner glow is the only atmosphere and it never moves.

## Aesthetic

A workbench in afternoon light: industrial-design portfolio meets boutique product launch, never tech demo. A deep forest-green surface is warmed from the bottom-right corner by a low wood-brown glow, and cream Bricolage Grotesque floats straight on the field with no card, panel or frame. The type voice is three-part and fixed: heavy mixed-case display, light DM Sans body, small uppercase DM Mono labels. Burnt orange is punctuation, never surface. Where the green needs breaking, a single cream info-card lies on it like warm paper. Flat and matte: 1px hairlines are the only dividers; no shadows, no rounded corners, no serif, no italics.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#232E26', color: '#F0E8D2', position: 'relative', display: 'flex', flexDirection: 'column', justifyContent: 'center', padding: '120px 106px' }}>
    <WoodGlow />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 30 }}>
      <Eyebrow>Studio Credentials · 2026</Eyebrow>
      <Rule />
      <Title size={230}>Made to last</Title>
      <p style={{ fontFamily: '"DM Sans", system-ui, sans-serif', fontSize: 36, lineHeight: 1.55, color: 'rgba(240,232,210,0.58)', maxWidth: 1100, margin: '19px 0 0' }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <Footer label="Northfield Studio" />
  </div>
);
```

## Signature elements

```tsx
// Wood-brown glow anchored bottom-right. Non-optional on every green page.
const WoodGlow = () => (
  <div aria-hidden style={{ position: 'absolute', right: 0, bottom: 0, width: '55%', height: '70%', pointerEvents: 'none', backgroundImage: 'radial-gradient(ellipse at 70% 80%, rgba(122,78,36,0.28) 0%, rgba(80,50,20,0.14) 40%, transparent 70%)' }} />
);

// Info-card: warm paper inset on the green. No border, shadow or radius; the tonal jump is the edge.
const InfoCard = ({ title, children }: { title: string; children: React.ReactNode }) => (
  <div style={{ background: '#EDE6D0', color: '#1E2820', padding: '36px 72px', maxWidth: 680 }}>
    <h3 style={{ fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 40, fontWeight: 600, lineHeight: 1.1, letterSpacing: '-0.01em', margin: '0 0 16px' }}>{title}</h3>
    <p style={{ fontFamily: '"DM Sans", system-ui, sans-serif', fontSize: 28, lineHeight: 1.6, color: 'rgba(30,40,32,0.6)', margin: 0 }}>{children}</p>
  </div>
);

// Chrome band: label pair over a hairline, top of content pages (not cover, quote or end).
const ChromeBand = ({ left, right }: { left: string; right: string }) => (
  <div style={{ position: 'absolute', top: 59, left: 106, right: 106, display: 'flex', justifyContent: 'space-between', paddingBottom: 15, borderBottom: '1px solid rgba(240,232,210,0.12)', fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, letterSpacing: '0.12em', textTransform: 'uppercase', color: 'rgba(240,232,210,0.58)' }}>
    <span>{left}</span>
    <span>{right}</span>
  </div>
);

// Em-dash bullet in DM Mono orange. Never a dot, check or numeral.
const Bullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ display: 'grid', gridTemplateColumns: '1.4em 1fr', listStyle: 'none', fontFamily: '"DM Sans", system-ui, sans-serif', fontSize: 36, lineHeight: 1.55 }}>
    <span style={{ fontFamily: '"DM Mono", ui-monospace, monospace', color: '#C07030' }}>—</span>
    <span>{children}</span>
  </li>
);

// Stat cell, 3-up in a flex row with gap 64. Suffix in <Em>: 4.7<Em>k</Em>. Last cell: last.
const Stat = ({ value, label, last }: { value: React.ReactNode; label: string; last?: boolean }) => (
  <div style={{ flex: 1, padding: '30px 64px 30px 0', borderRight: last ? 'none' : '1px solid rgba(240,232,210,0.12)' }}>
    <div style={{ fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 106, fontWeight: 800, lineHeight: 1, letterSpacing: '-0.025em' }}>{value}</div>
    <div style={{ marginTop: 15, fontFamily: '"DM Sans", system-ui, sans-serif', fontSize: 28, color: 'rgba(240,232,210,0.58)' }}>{label}</div>
  </div>
);

// Oversized orange opening quote above 65px Bricolage 600 quote text. Quote pages only.
const QuoteMark = () => (
  <div aria-hidden style={{ fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 154, fontWeight: 800, lineHeight: 0.6, color: '#C07030' }}>“</div>
);

// Chart bar: faint cream; orange only on the one highlighted bar. Baseline is a hairline.
const Bar = ({ pct, accent }: { pct: number; accent?: boolean }) => (
  <div style={{ flex: 1, height: `${pct}%`, background: accent ? '#C07030' : 'rgba(240,232,210,0.3)' }} />
);
```

## Do / Don't

- Do put every page on forest green with `WoodGlow`; cream pages are a once-per-deck tonal break.
- Do float cream type directly on the green; only the `InfoCard` breaks the field.
- Do pair mixed-case Bricolage display with uppercase DM Mono labels; the case contrast is the rhythm.
- Do keep orange to kicker, rule, em-dash, `<Em>`, quote mark and one bar. Two adjacent orange marks means one is wrong.
- Don't uppercase Bricolage, use weights below 600 for display, or drop the negative tracking.
- Don't colour headlines orange or use orange as a fill.
- Don't add shadows, rounded corners, borders over 1px, serifs or italics.
- Don't crowd: no three columns of bullets, no five stacked regions.
