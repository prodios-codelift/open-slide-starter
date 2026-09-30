---
name: People's Platform
description: "Activist poster energy: cobalt blue and amber slab caps with stacked red shadows on screen-printed paper, plus a Caveat Brush interrupt."
mode: dark
mood: [activist, loud, graphic, honest]
tone: [punchy, direct, expressive, warm-bold]
formality: low
density: high
scheme: light
best_for: "Manifestos, civic and community decks, campaign pitches, design talks and founder-vision moments that want protest-poster energy instead of corporate polish."
avoid_for: "Contexts where institutional restraint is the actual goal; the saturated political-poster palette commits hard to expressive energy."
source: bold:peoples-platform
---

# People's Platform

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#2C2CDC` | cobalt: cover, closer, stat pages; headlines on paper |
| text | `#F4E9D6` | cream: type, frame, pills on blue; alt page ground |
| accent | `#F2A03A` | amber: hero titles, numerals, stats, ribbon, dots |
| muted | `#0E0E14` | ink: all rules and borders, body and labels on paper. No greys |
| paper | `#F5F2EA` | default content-page ground |
| red | `#E83A2A` | shadow layer 1 and diamond bullets only |
| red-deep | `#B7281C` | shadow layer 2, orange type 140px+ |
| blue-deep | `#1B1BB0` | outer shadow layer only |
| orange-deep | `#E89321` | deepest shadow on orange only |

## Typography

- Display: `"Alfa Slab One", Rockwell, "Roboto Slab", Georgia, serif`, weight 400 (its only weight, intrinsically black). Always uppercase, 0.005em tracking, line-height 0.82–0.88 (1.04 for multi-line manifestos).
- Script: `"Caveat Brush", "Segoe Print", cursive`, 64–96px, lowercase, rotated -2 to -5deg. Once per slide, beside a slab headline.
- Body: `"Archivo Narrow", "Arial Narrow", system-ui, sans-serif`, 500 (400 captions). Never display sizes.
- Label: `"DM Mono", ui-monospace, monospace`, 400, uppercase, 24px, 0.18–0.22em.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Caveat+Brush&family=Archivo+Narrow:wght@400;500&family=DM+Mono:wght@400;500&display=swap`
- Type scale (source px at 1920; the poster display is deliberately oversized):
  - Hero 240px / lh 0.86 for two short lines, 200px for three; orange on blue
  - Headline 140px / lh 0.88, 120px secondary, manifesto 108px / lh 1.04; blue on paper
  - Stat 540px / lh 0.82 (one per page) · KPI 88px · quote 78px / lh 1.08 under a 300px quote mark
  - Subtitle 72px · card title 54px · item 38px · stamp 28px / 0.04em · script 96 / 64px
  - Body 32px / lh 1.4 (source 28–30, raised to the floor) · caption 24px 400
  - Label 24px: 0.18em pills and topbars, 0.22em footline and ribbon; emphasis 32px / 500
- CJK: Noto Serif SC 900 display (keep the shadow), Noto Sans SC body and labels; no caps or tracking; drop the script.

## Layout

- Chrome (pills, topbar, footline) at 90px from the edges; text content at 120px.
- Blue pages: InsetFrame, pill row at top 90, centered display type. Paper pages: header block (headline left, lede right behind a 4px ink left rule), a 6px ink rule, then content.
- Columns split by 6px ink borders with alternating fills (paper · blue · paper). Gaps 90px between blocks, 30px within.
- Rhythm: blue cover → paper / cream content → blue stat or closer. Density is medium-high: fill the canvas with blocks.

## Fixed components

### Title

```tsx
// Slab caps with the stacked letterpress shadow, scaled to size. Orange casts red + red-deep
// from 140px up; blue (on paper) and cream cast a single red layer.
const Title = ({ children, size = 200, color = '#F2A03A' }: { children: React.ReactNode; size?: number; color?: string }) => {
  const o = size >= 260 ? 12 : size > 140 ? 10 : size >= 72 ? 6 : 3;
  const shadow = color === '#F2A03A' && size >= 140 ? `${o}px ${o}px 0 #E83A2A, ${2 * o}px ${2 * o}px 0 #B7281C` : `${o}px ${o}px 0 #E83A2A`;
  return (
    <h1 style={{ fontFamily: '"Alfa Slab One", Rockwell, Georgia, serif', fontSize: size, fontWeight: 400, lineHeight: 0.86, letterSpacing: '0.005em', textTransform: 'uppercase', margin: 0, color, textShadow: shadow }}>
      {children}
    </h1>
  );
};
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Centered footline with orange-dot separators. color: cream on blue, ink on paper.
const Footer = ({ color = '#F4E9D6' }: { color?: string }) => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  const dot = <span style={{ width: 10, height: 10, borderRadius: '50%', background: '#F2A03A' }} />;
  return (
    <div style={{ position: 'absolute', left: 90, right: 90, bottom: 110, display: 'flex', justifyContent: 'center', alignItems: 'center', gap: 32, fontFamily: '"DM Mono", monospace', fontSize: 24, lineHeight: 1, letterSpacing: '0.22em', textTransform: 'uppercase', color }}>
      <span>Deck title</span>{dot}<span>Month 2026</span>{dot}<span>{pad(current)} / {pad(total)}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Meta pill: cover corners and kickers. Cream on blue, ink on paper.
const Eyebrow = ({ children, color = '#F4E9D6' }: { children: React.ReactNode; color?: string }) => (
  <div style={{ display: 'inline-block', padding: '8px 20px', border: `3px solid ${color}`, borderRadius: 999, fontFamily: '"DM Mono", monospace', fontSize: 24, lineHeight: 1, letterSpacing: '0.18em', textTransform: 'uppercase', color }}>
    {children}
  </div>
);

// Handwritten interrupt: lowercase, tilted, never alone.
const Script = ({ children, size = 96, color = '#F4E9D6', tilt = -5 }: { children: React.ReactNode; size?: number; color?: string; tilt?: number }) => (
  <span style={{ display: 'inline-block', fontFamily: '"Caveat Brush", cursive', fontSize: size, lineHeight: 1, textTransform: 'lowercase', color, transform: `rotate(${tilt}deg)` }}>{children}</span>
);
```

## Motion

- Philosophy: static. A printed poster doesn't move; pages cut, and depth comes from the offset shadows.

## Aesthetic

A WPA poster crossed with a campaign placard: the graphic register of public address. Alfa Slab caps shout at extreme sizes and cast a hard red, then red-deep, offset shadow, so headlines look letterpressed with physical thickness; DM Mono keeps the record in wide-tracked caps; one Caveat Brush word per slide is the human voice. Cobalt, amber and cream are the only surfaces, red exists only as shadow, and grain makes the deck feel screen-printed. Structure is square and heavy: 6px ink rules, framed blue pages, stamps, ribbons. Loud, honest, populist; no gradients, soft shadows, rounded cards or corporate polish.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#2C2CDC', color: '#F4E9D6', padding: '170px 150px', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
    <InsetFrame />
    <div style={{ position: 'absolute', top: 90, left: 90, right: 90, display: 'flex', justifyContent: 'space-between' }}>
      <Eyebrow>Q3 · 2026</Eyebrow>
      <Eyebrow>Vol. 01</Eyebrow>
    </div>
    <Title>The Big Idea</Title>
    <div style={{ display: 'flex', alignItems: 'center', gap: 34, marginTop: 46 }}>
      <Script>a</Script>
      <div style={{ fontFamily: '"Alfa Slab One", Rockwell, serif', fontSize: 72, lineHeight: 1, letterSpacing: '0.01em', textTransform: 'uppercase' }}>Plan for everyone</div>
    </div>
    <Footer />
    <Grain />
  </div>
);
```

## Signature elements

```tsx
// Screen-print grain: last child of EVERY page.
const Grain = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', backgroundImage: 'radial-gradient(rgba(0,0,0,.06) 1px, transparent 1px), radial-gradient(rgba(255,255,255,.05) 1px, transparent 1px)', backgroundSize: '3px 3px, 5px 5px', backgroundPosition: '0 0, 1px 2px', mixBlendMode: 'multiply', opacity: 0.5 }} />
);

// Poster-within-a-poster: every blue page.
const InsetFrame = () => <div aria-hidden style={{ position: 'absolute', inset: 48, border: '6px solid #F4E9D6', pointerEvents: 'none' }} />;

// Borders: 6px section rules and column splits, 5px cards, 3px fine rules.
const RULE = '6px solid #0E0E14';
// Topbar on dense blue pages: absolute top strip, 90px tall, pill-row type, cream bottom rule.
const TOPBAR = { position: 'absolute', top: 0, left: 0, right: 0, height: 90, padding: '0 90px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', background: '#2C2CDC', borderBottom: '6px solid #F4E9D6' } as const;
// Redaction-bar full stop under a manifesto headline.
const Bar = () => <div style={{ width: '30%', height: 14, background: '#0E0E14', marginTop: 60 }} />;

// List marker 48px left of the text: red on paper, orange on blue.
const Diamond = ({ color = '#E83A2A' }: { color?: string }) => <span aria-hidden style={{ display: 'inline-block', flexShrink: 0, width: 24, height: 24, borderRadius: 4, background: color, transform: 'rotate(45deg)' }} />;

// Column ordinal: 180px orange numeral over a ruled "— TAG —" label.
const Ordinal = ({ n, tag, ink = '#0E0E14' }: { n: string; tag: string; ink?: string }) => (
  <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-start' }}>
    <div style={{ fontFamily: '"Alfa Slab One", Rockwell, serif', fontSize: 180, lineHeight: 0.88, color: '#F2A03A', textShadow: '5px 5px 0 #E83A2A' }}>{n}</div>
    <div style={{ marginTop: 14, paddingTop: 18, borderTop: `3px solid ${ink}`, fontFamily: '"DM Mono", monospace', fontSize: 24, letterSpacing: '0.18em', textTransform: 'uppercase', color: ink }}>— {tag} —</div>
  </div>
);

// KPI card, square: paper, or blue when alt.
const Kpi = ({ label, value, alt = false }: { label: string; value: string; alt?: boolean }) => (
  <div style={{ padding: '28px 30px', border: '5px solid #0E0E14', background: alt ? '#2C2CDC' : '#F5F2EA', color: alt ? '#F4E9D6' : '#0E0E14' }}>
    <div style={{ fontFamily: '"DM Mono", monospace', fontSize: 24, letterSpacing: '0.22em', textTransform: 'uppercase' }}>— {label} —</div>
    <div style={{ marginTop: 14, fontFamily: '"Alfa Slab One", Rockwell, serif', fontSize: 88, lineHeight: 0.9, color: '#F2A03A', textShadow: '4px 4px 0 #E83A2A' }}>{value}</div>
  </div>
);

// Seal for closers. Label variant: square, -3deg, blue fill, orange text, 5px cream border, 6px shadow.
const Stamp = ({ children }: { children: React.ReactNode }) => (
  <div style={{ width: 200, height: 200, borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center', textAlign: 'center', background: '#F4E9D6', color: '#2C2CDC', border: '6px solid #F2A03A', boxShadow: '8px 8px 0 #E83A2A', transform: 'rotate(-9deg)', fontFamily: '"Alfa Slab One", Rockwell, serif', fontSize: 28, lineHeight: 1.05, letterSpacing: '0.04em', textTransform: 'uppercase' }}>{children}</div>
);

// Orange marquee strip on data pages; repeat the text by hand to span the width.
const Ribbon = ({ children }: { children: React.ReactNode }) => (
  <div style={{ position: 'absolute', left: 0, right: 0, bottom: 0, height: 60, padding: '0 90px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', background: '#F2A03A', color: '#2C2CDC', borderTop: RULE, fontFamily: '"DM Mono", monospace', fontSize: 24, fontWeight: 500, letterSpacing: '0.22em', textTransform: 'uppercase', whiteSpace: 'nowrap' }}>{children}</div>
);

const MILESTONE = { width: 60, height: 60, borderRadius: '50%', background: '#F2A03A', border: '6px solid #0E0E14', boxShadow: '6px 6px 0 #E83A2A' } as const;
```

## Do / Don't

- Do put `Grain` on every page and `InsetFrame` on every blue page.
- Do give every display line its red offset shadow, scaled with size.
- Do set Alfa Slab One in caps only; Archivo Narrow is body only.
- Do keep DM Mono labels at 24px, 0.16em+ tracking (32px the one exception).
- Do use Caveat Brush once per slide, 64px+, lowercase, tilted, beside a slab headline.
- Don't fill or colour text with red, red-deep or blue-deep: shadow materials only.
- Don't use borders under 3px or round containers; only pills, circles and diamonds are soft.
- Don't add gradients, blurred shadows or a fourth surface colour.
