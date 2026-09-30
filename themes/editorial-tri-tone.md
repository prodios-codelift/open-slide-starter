---
name: Editorial Tri-Tone
description: "Blush pink, golden butter and deep burgundy only: heavy Bricolage Grotesque interrupted by Instrument Serif italics, pill tag clouds and mono labels."
mode: light
mood: [editorial, warm, intentional, moody]
tone: [literary, warm, considered, stylish]
formality: medium
density: medium
scheme: mixed
best_for: "Fashion-magazine-style decks (editorial pitches, fashion and lifestyle brands, art direction reviews) or any business or research deck wanting tri-tone discipline and serif/sans contrast over neutrals."
avoid_for: "Decks that need to read as soft or comforting; the burgundy, pink and butter tri-tone is intentionally high-contrast and styled."
source: bold:editorial-tri-tone
---

# Editorial Tri-Tone

## Palette

Three hex values, nothing else. The source's aliases (sky, cream, lime, terracotta, navy, forest, ink) all resolve to one of them.

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F2B6C6` | blush pink: cover, grid pages; stat figures on burgundy |
| text | `#7A1F35` | burgundy ink: all text on pink and butter |
| accent | `#F2D86A` | golden butter: cover `&`, pills, text on burgundy |
| muted | `rgba(122,31,53,0.6)` | burgundy at 55–75%; never a grey |
| bg-light | `#F2D86A` | butter surface: split left halves, timeline, chart card |
| bg-dark | `#7A1F35` | burgundy surface: stat, chart, closer, split right halves |
| rule-dark | `rgba(246,237,220,0.25)` | whispered divider on burgundy (0.30 endorsement rows) |
| track-dark | `rgba(246,237,220,0.15)` | empty bar track on burgundy |
| axis | `rgba(122,31,53,0.15)` | 4px timeline axis on butter |

## Typography

- Display + body: `"Bricolage Grotesque", system-ui, sans-serif`. Weight is the tonal dial: 800 cover wordmark only, 700 headlines, 600 card titles, 500 lede/pills, 400 body. Negative tracking at display only.
- Accent serif: `"Instrument Serif", Georgia, serif`, 400, italic via `<Em>`. Numerals, quote marks, years, signatures, stat units only; never body.
- Labels: `"JetBrains Mono", ui-monospace, monospace`, 400/500, uppercase, 0.10–0.18em.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,400;12..96,500;12..96,600;12..96,700;12..96,800&family=Instrument+Serif:ital@0;1&family=JetBrains+Mono:wght@400;500&display=swap`
- Type scale (source px; display deliberately oversized):
  - Cover wordmark: 200px (`Title` default), 300px for one short line; 800, lh 0.82, -0.04em
  - Closer 320px 700 -0.05em · Stat 540px 700 lh 0.78 -0.06em pink + 220px serif unit in butter
  - Chapter numeral 240px serif · quote mark 200px serif · signature 64px · years 56px
  - Section headline: 76–84px 700, lh 0.95, -0.02em (`<Title size={80}>`)
  - Lede 56px 500 lh 1.05 · panel head 56px 600 · card title 40px 600 · cover pill 44px 500
  - Body 28px lh 1.45; 24px in cards (below default range by design; keep it short)
  - Label 24px mono 0.15em (0.18em kickers on burgundy, 0.10em data) · footer 20px (source 16px) at 0.75

## Layout

- Padding: 96px top/bottom, 64px left/right (portrait-publication feel). Section gap 48px, grid gap 24px.
- Content pages: `§ NN — Title` Eyebrow, headline, body/grid; Footer at bottom 36px.
- Cover: three mono meta labels at top 64, pill cloud from top 120 (max-width 1500, gap 22), wordmark anchored bottom-left; the middle stays empty.
- Split pages: `gridTemplateColumns: '1fr 1fr'`, no root padding; butter half (96px 64px) | burgundy half (96px 80px). Never pink + butter.
- Grids: 4 × 340px value cards at 24px gap, alternating burgundy/butter.

## Fixed components

### Title

```tsx
// size ≥200: cover wordmark (800) / closer; 76–84: section headline (700).
const Title = ({ children, size = 200, color = '#7A1F35' }: { children: React.ReactNode; size?: number; color?: string }) => (
  <h1 style={{ fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: size, fontWeight: size >= 200 ? 800 : 700, lineHeight: size >= 200 ? 0.82 : 0.95, letterSpacing: size >= 200 ? '-0.04em' : '-0.02em', margin: 0, color }}>
    {children}
  </h1>
);

// The em rule: inside any Bricolage headline, <Em> switches to Instrument Serif italic.
const Em = ({ children, color = 'inherit' }: { children: React.ReactNode; color?: string }) => (
  <em style={{ fontFamily: '"Instrument Serif", Georgia, serif', fontStyle: 'italic', fontWeight: 400, color }}>{children}</em>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Inherits the page's text colour; dot row = progress (30% inactive, 100% current).
const Footer = ({ label }: { label: string }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 64, right: 64, bottom: 36, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 20, lineHeight: 1, letterSpacing: '0.12em', textTransform: 'uppercase', opacity: 0.75 }}>
      <span>{label}</span>
      <span style={{ display: 'flex', gap: 8 }}>
        {Array.from({ length: total }, (_, i) => (
          <i key={i} style={{ width: 8, height: 8, borderRadius: 999, background: 'currentColor', opacity: i + 1 === current ? 1 : 0.3 }} />
        ))}
      </span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Section marker ("§ 03 — Principles"), cover meta, kickers. Butter + 0.18em on burgundy.
const Eyebrow = ({ children, color = 'inherit' }: { children: React.ReactNode; color?: string }) => (
  <div style={{ fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 24, fontWeight: 400, lineHeight: 1, letterSpacing: '0.15em', textTransform: 'uppercase', color }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. Pages cut like turned magazine spreads; the voice comes from type and surface changes, not movement.

## Aesthetic

An independent arts quarterly with a colophon and hand-numbered editions: literary magazine meets annual report. Three flat surfaces (blush, butter, wine) alternate and split pages down the middle, giving depth by edge contrast alone. Bricolage Grotesque shouts at extreme weights and tight tracking until an Instrument Serif italic aside interrupts it; JetBrains Mono whispers every label. Pills are the universal tag, cards softly rounded, dividers on dark faint etchings. No shadows, greys, white, or fourth colour.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#F2B6C6', color: '#7A1F35', fontFamily: '"Bricolage Grotesque", system-ui, sans-serif' }}>
    <div style={{ position: 'absolute', top: 64, left: 64, right: 64, display: 'flex', justifyContent: 'space-between' }}>
      <Eyebrow>Vol. 04 — Editorial Brief</Eyebrow>
      <Eyebrow>Spring / Summer Edition</Eyebrow>
      <Eyebrow>FW · 2026</Eyebrow>
    </div>
    <div style={{ position: 'absolute', top: 120, left: 64, maxWidth: 1500, display: 'flex', flexWrap: 'wrap', gap: 22 }}>
      <Pill>focus</Pill>
      <Pill bg="#F2D86A" fg="#7A1F35">craft</Pill>
      <Pill fg="#F2D86A">community</Pill>
      <Pill bg="#F2D86A" fg="#7A1F35">studio</Pill>
      <Pill>workshops</Pill>
    </div>
    <div style={{ position: 'absolute', left: 64, right: 64, bottom: 96 }}>
      <Title size={300}>Studio <Em color="#F2D86A">&amp;</Em> Salon</Title>
    </div>
    <Footer label="Editorial Brief · 2026" />
  </div>
);
```

## Signature elements

```tsx
// Universal tag. 44px cover cloud, 24px legends/utility, 22px corner tags.
// Pairs: burgundy/pink, burgundy/butter, butter/burgundy; on burgundy use butter or pink fills.
const Pill = ({ children, bg = '#7A1F35', fg = '#F2B6C6', size = 44 }: { children: React.ReactNode; bg?: string; fg?: string; size?: number }) => (
  <span style={{ display: 'inline-flex', alignItems: 'center', padding: '0.36em 0.86em', borderRadius: 999, background: bg, color: fg, fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: size, fontWeight: 500, lineHeight: 1, whiteSpace: 'nowrap' }}>{children}</span>
);

// Serif moment: chapter numeral 240, quote mark 200 (lh 0.6), signature 64, year 56.
const SerifMark = ({ children, size = 240, color = 'inherit' }: { children: React.ReactNode; size?: number; color?: string }) => (
  <div style={{ fontFamily: '"Instrument Serif", Georgia, serif', fontSize: size, lineHeight: size === 200 ? 0.6 : 0.9, color }}>{children}</div>
);

// Value card: 28px radius, alternate dark/light across a 4-column grid.
const ValueCard = ({ num, title, children, dark }: { num: string; title: string; children: React.ReactNode; dark?: boolean }) => (
  <div style={{ height: 340, borderRadius: 28, padding: '28px 28px 30px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between', background: dark ? '#7A1F35' : '#F2D86A', color: dark ? '#F2D86A' : '#7A1F35', fontFamily: '"Bricolage Grotesque", system-ui, sans-serif' }}>
    <div style={{ fontFamily: '"JetBrains Mono", monospace', fontSize: 24, letterSpacing: '0.15em', opacity: 0.7 }}>/ {num}</div>
    <h4 style={{ fontSize: 40, fontWeight: 600, lineHeight: 1, letterSpacing: '-0.02em', margin: 0 }}>{title}</h4>
    <p style={{ fontSize: 24, lineHeight: 1.4, margin: 0, opacity: 0.85 }}>{children}</p>
  </div>
);

// Oversized stat on burgundy: pink grotesk figure + butter serif unit.
const Stat = ({ value, unit }: { value: string; unit: string }) => (
  <div style={{ display: 'flex', alignItems: 'flex-start', fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 540, fontWeight: 700, lineHeight: 0.78, letterSpacing: '-0.06em', color: '#F2B6C6' }}>
    {value}<span style={{ fontFamily: '"Instrument Serif", Georgia, serif', fontWeight: 400, fontSize: 220, letterSpacing: 0, color: '#F2D86A', margin: '60px 0 0 20px' }}>{unit}</span>
  </div>
);

// Breakdown row on burgundy: whispered rgba rule, 10px pill bar.
const BreakdownRow = ({ label, value, fill }: { label: string; value: number; fill: string }) => (
  <div style={{ display: 'grid', gridTemplateColumns: '150px 1fr 90px', gap: 16, alignItems: 'center', padding: '14px 0', borderTop: '1px solid rgba(246,237,220,0.25)', fontFamily: '"JetBrains Mono", monospace', fontSize: 24 }}>
    <span style={{ letterSpacing: '0.1em', textTransform: 'uppercase', opacity: 0.7 }}>{label}</span>
    <div style={{ height: 10, borderRadius: 999, background: 'rgba(246,237,220,0.15)' }}><div style={{ width: `${value}%`, height: '100%', borderRadius: 999, background: fill }} /></div>
    <span style={{ textAlign: 'right' }}>{value}%</span>
  </div>
);
```

- Ribbon: a burgundy pill bar (`padding: '24px 44px'`, `borderRadius: 999`), mono 24px butter text, one serif 30px pink accent at the right.
- Chart card: butter on burgundy, `borderRadius: 32`, `padding: '48px 48px 56px'`, serif 40px title. SVG: pink area (0.85) with 3px burgundy stroke; burgundy bars `rx={4}`; butter `r={8}` dots on a 3px line; dotted `strokeDasharray="2 10"` at 0.6.
- Swatches: 36px circles in a 10px-gap row beside a kicker.

## Do / Don't

- Do keep every surface and mark pink, butter or burgundy; muted is burgundy or butter at lower opacity.
- Do put one `<Em>` in most display headlines; it is the system's voice.
- Do open content pages with `<Eyebrow>§ 02 — Title</Eyebrow>` and track every mono label 0.10–0.18em.
- Do split two-column pages butter | burgundy and alternate card surfaces.
- Don't italicise Bricolage, or set Instrument Serif below 40px or as body copy.
- Don't use weight 800 outside the cover wordmark, or positive tracking on Bricolage.
- Don't draw solid dividers on burgundy; use `rgba(246,237,220,0.25–0.30)`.
- Don't add shadows or round large panels; radii are 999 (pills, dots), 28–32 (cards) or 0.
- CJK: Noto Sans SC for grotesk roles, ZCOOL XiaoWei for `<Em>`, tracking 0, lh +0.05–0.08, no uppercase.
