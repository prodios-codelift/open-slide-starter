---
name: Capsule
description: "Ink-outlined candy pills on cream under Bodoni: Memphis-meets-editorial, modular and a little Y2K."
mode: light
mood: [playful, modern, warm, fresh]
tone: [upbeat, graphic, approachable, cool]
formality: low
density: medium
scheme: light
best_for: "Lifestyle, beauty and DTC launches, creator portfolios, agency credentials, and playful tech or research decks wanting pop-art clarity over gravitas."
avoid_for: "Institutional contexts — the pill shapes and pastel pops soften authority."
source: bold:capsule
---

# Capsule

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F5F5F0` | cream canvas; bar-track interiors |
| text | `#1A1A1A` | ink: every headline, body, pill text |
| accent | `#E85D4E` | coral: accent line, first icon/numeral |
| muted | `#676765` | ink 65%: body, subtitles, footer |
| outline | `#1E1E1E` | universal stroke on every pill/card/icon |
| surface | `#FFFFFF` | cards, stat tiles, nodes, counter pill |
| lime | `#C4D94E` | orbit centers, highlights, numerals |
| lavender | `#C5B5E0` | section tag pills, calm fills |
| sky | `#8BB4F7` | default third accent |
| violet | `#A06CE8` | second purple, lavender's alt |
| yellow | `#F2D160` | title/closing pills: "featured" |
| peach | `#F5B895` | softest; floating pills and dots |
| mint | `#A8E6CF` | visual-frame gradients, low-emphasis |
| shadow | `rgba(26,26,26,0.08)` | only shadow: solid, bottom-right, unblurred |

Accents carry no meaning. Order: coral → lime → sky → violet → yellow → lavender → peach → mint. Pair warm with cool; never two same-family side by side.

## Typography

- Display font: `"Bodoni Moda", "Bodoni 72", Didot, Georgia, serif` — 700–800, always ink, sentence case, negative tracking. Every headline, stat, card title and quote.
- Body font: `"Space Grotesk", system-ui, sans-serif` — 400 body; 500–600 labels/pill text, uppercase, 0.08em+ tracking.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bodoni+Moda:ital,opsz,wght@0,6..96,700;0,6..96,800;1,6..96,600&family=Space+Grotesk:wght@400;500;600&display=swap`
- Type scale (source `rem`/`vw` scaled to canvas ranges):
  - Hero (cover/closing): 144px Bodoni 800, lh 0.92, -0.02em (`Title` default)
  - Headline (split pages): 80px 700, lh 1.05 · section headline: 72px 700, lh 1.05
  - Quote: 64px 600, lh 1.35; `<em>` switches to Bodoni italic
  - Stat numeral: 96px 800, -0.03em, candy colour · card title: 44px 700, lh 1.1
  - Body: 32px Space Grotesk 400, lh 1.6, muted; 28px inside cards
  - Subtitle 28px uppercase 0.15em; pill text 24px 600 0.12em; label 22px 500 0.1em
- Strokes/shadows scale up: source's 2px outline → 3px; 4/6/8/12px offsets → 6/8/12/16px.

## Layout

- Content padding: 108px top/bottom, 144px left/right (source's 3rem/4rem ratio).
- Covers/closings/quotes centre on one axis. Content pages are left-aligned: headline, then one or two blocks (3–4 card grid at 48px gap, 2-column split at 96px gutter, stat row).
- Radii: 9999px pills/bars/lines; 40px cards/tiles; 50% icons/nodes. No square text containers.
- Layer order: `CAPSULE_BG`, floating pills, content (`position: 'relative'`), `Footer`, `Grain` on top.
- Declarative pages get 5–8 floating pills so no corner is bare. Dense data pages get none, just glows.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 144 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Bodoni Moda", "Bodoni 72", Didot, Georgia, serif', fontSize: size, fontWeight: size >= 120 ? 800 : 700, lineHeight: size >= 120 ? 0.92 : 1.05, letterSpacing: '-0.02em', margin: 0, color: '#1A1A1A' }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ label }: { label: string }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 144, right: 144, bottom: 52, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 22, fontWeight: 500, lineHeight: 1, letterSpacing: '0.1em', textTransform: 'uppercase', color: '#676765' }}>
      <span>{label}</span>
      <span style={{ display: 'flex', alignItems: 'center', gap: 14, padding: '12px 26px', borderRadius: 9999, border: '3px solid #1E1E1E', background: '#FFFFFF', boxShadow: '6px 6px 0 rgba(26,26,26,0.08)', fontWeight: 600, fontVariantNumeric: 'tabular-nums', color: '#1A1A1A' }}>
        <span style={{ width: 12, height: 12, borderRadius: '50%', background: '#E85D4E' }} />
        {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children, fill = '#F2D160' }: { children: React.ReactNode; fill?: string }) => (
  <div style={{ padding: '18px 48px', borderRadius: 9999, border: '3px solid #1E1E1E', background: fill, boxShadow: '6px 6px 0 rgba(26,26,26,0.08)', fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 24, fontWeight: 600, lineHeight: 1, letterSpacing: '0.12em', textTransform: 'uppercase', whiteSpace: 'nowrap', color: '#1A1A1A' }}>
    {children}
  </div>
);

const AccentLine = ({ width = 90, color = '#E85D4E' }: { width?: number; color?: string }) => (
  <div style={{ width, height: 6, borderRadius: 9999, background: color }} />
);
```

## Motion

- Philosophy: subtle. Pages fade in over 0.6s `cubic-bezier(0.4, 0, 0.2, 1)`; pills never bounce, spin, or float.

```css
@keyframes capsuleFade {
  from { opacity: 0; }
  to   { opacity: 1; }
}
```

## Aesthetic

A literary magazine on holiday at a 1970s ice-cream parlour: Memphis-meets-editorial. Every text container is an inflated pill with a crisp ink outline and a soft offset lift, on cream warmed by candy glows and film grain. High-contrast Bodoni carries every statement in ink; uppercase Space Grotesk carries every label. Colour lives in fills, numerals and tilted confetti that orbit like wallpaper. Friendly and modular, never corporate. No sharp corners, blurred shadows, or coloured headlines.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: CAPSULE_BG, color: '#1A1A1A', padding: '108px 144px', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center' }}>
    <FloatPill word="Vision" fill="#C5B5E0" rotate={-12} style={{ left: 150, top: 132 }} />
    <FloatPill size={72} fill="#F5B895" rotate={0} style={{ left: 390, top: 92 }} />
    <FloatPill word="Next" fill="#8BB4F7" rotate={14} style={{ right: 176, top: 150 }} />
    <FloatPill size={112} fill="#C4D94E" rotate={0} style={{ right: 104, top: 470 }} />
    <FloatPill word="Growth" fill="#E85D4E" rotate={8} style={{ left: 176, bottom: 196 }} />
    <FloatPill word="Focus" fill="#A8E6CF" rotate={-18} style={{ right: 250, bottom: 206 }} />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 48, maxWidth: 1400 }}>
      <Eyebrow>Spring Launch · 2026</Eyebrow>
      <Title>The Big Idea</Title>
      <AccentLine />
      <p style={{ fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 28, lineHeight: 1.4, letterSpacing: '0.15em', textTransform: 'uppercase', color: '#676765', maxWidth: 1100, margin: 0 }}>
        A short subtitle that explains what this deck is about
      </p>
    </div>
    <Footer label="Company · 2026" />
    <Grain />
  </div>
);
```

## Signature elements

```tsx
const CAPSULE_BG =
  'radial-gradient(ellipse 50% 60% at 6% 8%, rgba(232,93,78,0.12), transparent 70%), radial-gradient(ellipse 50% 60% at 96% 94%, rgba(139,180,247,0.15), transparent 70%), #F5F5F0';

const Grain = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', opacity: 0.04, mixBlendMode: 'multiply', backgroundImage: "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E\")" }} />
);

const FloatPill = ({ word, fill, rotate, size, style }: { word?: string; fill: string; rotate: number; size?: number; style: React.CSSProperties }) => (
  <div aria-hidden style={{ position: 'absolute', width: size, height: size, padding: size ? 0 : '16px 36px', borderRadius: 9999, border: '3px solid #1E1E1E', background: fill, transform: `rotate(${rotate}deg)`, fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 20, fontWeight: 600, lineHeight: 1, letterSpacing: '0.1em', textTransform: 'uppercase', whiteSpace: 'nowrap', color: '#1A1A1A', ...style }}>
    {word}
  </div>
);

const PillCard = ({ mark, fill, title, children }: { mark: string; fill: string; title: string; children: React.ReactNode }) => (
  <div style={{ background: '#FFFFFF', border: '3px solid #1E1E1E', borderRadius: 40, padding: '56px 48px', boxShadow: '12px 12px 0 rgba(26,26,26,0.08)', display: 'flex', flexDirection: 'column', gap: 28 }}>
    <div style={{ width: 88, height: 88, borderRadius: '50%', border: '3px solid #1E1E1E', background: fill, display: 'flex', alignItems: 'center', justifyContent: 'center', fontFamily: '"Bodoni Moda", Georgia, serif', fontSize: 36, fontWeight: 700 }}>{mark}</div>
    <h3 style={{ fontFamily: '"Bodoni Moda", Georgia, serif', fontSize: 44, fontWeight: 700, lineHeight: 1.1, margin: 0 }}>{title}</h3>
    <p style={{ fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 28, lineHeight: 1.55, color: '#676765', margin: 0 }}>{children}</p>
  </div>
);

const StatPill = ({ value, label, color }: { value: string; label: string; color: string }) => (
  <div style={{ background: '#FFFFFF', border: '3px solid #1E1E1E', borderRadius: 40, padding: '44px 36px', boxShadow: '8px 8px 0 rgba(26,26,26,0.08)', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 16 }}>
    <div style={{ fontFamily: '"Bodoni Moda", Georgia, serif', fontSize: 96, fontWeight: 800, lineHeight: 1, letterSpacing: '-0.03em', color }}>{value}</div>
    <div style={{ fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 22, fontWeight: 500, letterSpacing: '0.1em', textTransform: 'uppercase', color: '#676765' }}>{label}</div>
    <div style={{ width: 60, height: 6, borderRadius: 9999, background: color }} />
  </div>
);

const Bar = ({ value, fill }: { value: number; fill: string }) => (
  <div style={{ height: 52, background: '#F5F5F0', border: '3px solid #1E1E1E', borderRadius: 9999, overflow: 'hidden' }}>
    <div style={{ width: `${value}%`, height: '100%', boxSizing: 'border-box', background: fill, borderRadius: 9999, borderRight: '3px solid #1E1E1E', display: 'flex', alignItems: 'center', justifyContent: 'flex-end', paddingRight: 20, fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 22, fontWeight: 600 }}>{value}%</div>
  </div>
);

const Highlight = ({ children, fill = '#C4D94E' }: { children: React.ReactNode; fill?: string }) => (
  <span style={{ display: 'inline-block', padding: '0.14em 0.5em', borderRadius: 9999, border: '3px solid #1E1E1E', background: fill, fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: '0.5em', fontWeight: 600, lineHeight: 1, letterSpacing: '0.1em', textTransform: 'uppercase', verticalAlign: 'middle' }}>{children}</span>
);
```

## Do / Don't

- Do make every text container a pill or 40px-radius card, stroked 3px `#1E1E1E`.
- Do lift cards/tiles/pills with solid `rgba(26,26,26,0.08)` offsets, bottom-right only.
- Do set headline/stat/card titles in Bodoni ink; colour goes on numerals and fills only.
- Do emphasise with `Highlight`, not bold/underline. Italic only via `<em>`.
- Do scatter 5–8 floating pills on declarative pages; keep `CAPSULE_BG`/`Grain` everywhere.
- Don't blur or recolour a shadow, or put one on a floating pill.
- Don't uppercase Bodoni, or set small Space Grotesk in sentence case.
- Don't add a tenth accent, or give accent meaning.
- Don't leave cover corners bare, nor crowd data pages.
- CJK: tracking 0, body lh 1.7, no uppercase on Hanzi.
