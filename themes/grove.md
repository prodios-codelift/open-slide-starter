---
name: Grove
description: "Forest-green canvas with warm cream type, Playfair Display never bolder than 400, and a single terracotta-coral accent."
mode: dark
mood: [organic, considered, literary, natural]
tone: [classical, warm, considered, patient]
formality: high
density: medium
scheme: mixed
best_for: "Organic, grown-up decks: sustainability, wellness, outdoor, wine and food, literary or arts, advisory reports, or calm tech and research talks."
avoid_for: "Decks that need neon energy or rapid-fire pop; the forest green and Playfair serif commit to a slow, classical voice."
source: bold:grove
---

# Grove

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#192b1b` | deep forest green, default surface and cover |
| text | `#d4cfbf` | warm cream, never pure white |
| accent | `#c8524a` | terracotta coral: `<Em>`, kicker, rule, em-dash, stats, quote mark |
| muted | `#898d7d` | secondary copy on green (`rgba(212,207,191,0.6)` flattened) |
| hint | `rgba(212,207,191,0.32)` | faintest metadata on green |
| bg-alt | `#1e3221` | lifted green for image regions |
| bg-light | `#e8e4d6` | parchment: quotes and "page" moments |
| bg-light-alt | `#dedad0` | cooler parchment, second light region |
| text-light | `#192b1b` | text on parchment (same hex as bg) |
| muted-light | `rgba(25,43,27,0.58)` | secondary text on parchment |
| border | `rgba(212,207,191,0.12)` | 1px hairline on green |
| border-light | `rgba(25,43,27,0.14)` | 1px hairline on parchment |
| watermark | `rgba(212,207,191,0.06)` | numeral on green; `rgba(25,43,27,0.06)` on parchment |

## Typography

- Display font: `"Playfair Display", "Noto Serif SC", Georgia, serif`, weight 400 only, never bold. Every headline, quote, stat and numeral; italic coral is the accent.
- Body font: `"Jost", "Noto Serif SC", system-ui, sans-serif`, weight 300 only: the "good paper" voice.
- Label font: `"JetBrains Mono", ui-monospace, monospace`, weight 300, always uppercase, 0.12em+ tracking. Kickers, chrome, counters, stat labels.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;1,400&family=Jost:wght@300&family=JetBrains+Mono:wght@300&display=swap`
- Type scale (source `vw` at 1920 wide; body and labels raised into slide-authoring's range):
  - Hero title 192px, line-height 1, -0.01em · chapter 106px, lh 1.1 · statement 81px, lh 1.15
  - Page heading 62px, lh 1.2 · sub-heading 38px, lh 1.3
  - Watermark numeral 346px, -0.03em (deliberately oversized) · quote mark 154px, lh 0.6 · quote body 62px italic, lh 1.35
  - Stat figure 86px coral, -0.02em
  - Lead 36px, lh 1.65 · body and bullets 32px, lh 1.7 · caption 24px, lh 1.55
  - Label 22px mono: kicker 0.14em, chrome and stat label 0.12em, chapter ordinal 0.2em
- CJK: serif roles fall back to LXGW WenKai TC, body to Noto Serif SC (subset with `&text=`); no uppercase or tracking on Hanzi, loosen line-height ~0.1, and `<Em>` reads as colour only.

## Layout

- Padding: 154px horizontal, 70px vertical (1920×1080); quote pages 169px / 84px. Gaps: 48 between sections, 30 between related elements, 15 inside a unit.
- Content pages: `ChromeBar` at the top, `Footer` at the bottom, one moment between (content band ~150–930px). Cover, chapter, quote and end pages drop `ChromeBar`.
- Left-aligned. Sparse and breathing: one headline, one lede, one accent. Stats sit three to a row; text-and-image pages split 1fr 1fr.
- Section breaks inside a page: a full-width 1px `border` hairline. Zero radius, flat, no shadows.
- Green is the default; flip to parchment (`light` props) for quotes and literal-page moments.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 106, light = false }: { children: React.ReactNode; size?: number; light?: boolean }) => (
  <h1 style={{ fontFamily: '"Playfair Display", "Noto Serif SC", Georgia, serif', fontSize: size, fontWeight: 400, lineHeight: size >= 150 ? 1 : 1.1, letterSpacing: '-0.01em', margin: 0, color: light ? '#192b1b' : '#d4cfbf' }}>
    {children}
  </h1>
);

// The Grove accent: one word or phrase per headline turns italic coral.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'italic', color: '#c8524a' }}>{children}</em>
);
```

Sizes: cover 192, chapter 106 (default), page heading 62.

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Bottom chrome bar: section name + NN / TT over a 1px hairline.
const Footer = ({ label, light = false }: { label: string; light?: boolean }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 154, right: 154, bottom: 70, display: 'flex', justifyContent: 'space-between', paddingTop: 15, borderTop: `1px solid ${light ? 'rgba(25,43,27,0.14)' : 'rgba(212,207,191,0.12)'}`, fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 300, letterSpacing: '0.12em', textTransform: 'uppercase', color: light ? 'rgba(25,43,27,0.58)' : 'rgba(212,207,191,0.6)' }}>
      <span>{label}</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Coral mono kicker + 36px coral rule: one unit, always together, above the headline.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 18 }}>
    <div style={{ fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 300, letterSpacing: '0.14em', textTransform: 'uppercase', color: '#c8524a' }}>{children}</div>
    <div style={{ width: 36, height: 1, background: '#c8524a' }} />
  </div>
);
```

## Motion

- Philosophy: subtle. Kicker, rule, headline, lede enter in a slow stagger (0.7s `cubic-bezier(0.16, 1, 0.3, 1)`, delays 0 / 80 / 180 / 300 / 440 / 600 / 780ms). Pages cut or take a 240ms fade; nothing bounces.
- `groveUp` for text, `groveReveal` for rules and image regions (inject per `webfonts.md`'s create-or-update `<style>` pattern):

```css
@keyframes groveUp { from { opacity: 0; transform: translateY(28px); } to { opacity: 1; transform: none; } }
@keyframes groveReveal { from { clip-path: inset(0 100% 0 0); } to { clip-path: inset(0 0 0 0); } }
```

## Aesthetic

A literary monograph or boutique brand book: printed ink on linen, not a digital surface. Deep forest green holds warm cream Playfair headlines at one weight, with one word turned italic terracotta; Jost Light sits back as the body, and thin mono chrome frames each page with 1px hairlines. Depth comes only from hairlines, a three-step opacity ladder, and a near-invisible serif numeral in the corner. Restraint is the register: one moment per page, deep negative space, coral in small deliberate places. No bold serif, shadows, gradients, blur, rounded corners, or fourth colour.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#192b1b', color: '#d4cfbf', position: 'relative', padding: '0 154px', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <Watermark>03</Watermark>
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 30 }}>
      <Eyebrow>Annual Report · 2026</Eyebrow>
      <Title size={192}>
        A Quiet <Em>Harvest</Em>
      </Title>
      <p style={{ fontFamily: '"Jost", "Noto Serif SC", system-ui, sans-serif', fontSize: 36, fontWeight: 300, lineHeight: 1.65, color: 'rgba(212,207,191,0.6)', maxWidth: 1100, margin: 0 }}>
        A short lede that says what this deck is about.
      </p>
    </div>
    <Footer label="Annual Report" />
  </div>
);
```

## Signature elements

```tsx
// Top chrome bar: two mono labels over a 1px hairline. Every content page; never cover, chapter, quote or end.
const ChromeBar = ({ left, right, light = false }: { left: string; right: string; light?: boolean }) => (
  <div style={{ position: 'absolute', left: 154, right: 154, top: 70, display: 'flex', justifyContent: 'space-between', paddingBottom: 15, borderBottom: `1px solid ${light ? 'rgba(25,43,27,0.14)' : 'rgba(212,207,191,0.12)'}`, fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 300, letterSpacing: '0.12em', textTransform: 'uppercase', color: light ? 'rgba(25,43,27,0.58)' : 'rgba(212,207,191,0.6)' }}>
    <span>{left}</span>
    <span>{right}</span>
  </div>
);

// Watermark numeral at 6%: bottom-right texture on covers, chapters and statements. Bleeds off the bottom edge.
const Watermark = ({ children, light = false }: { children: React.ReactNode; light?: boolean }) => (
  <div aria-hidden data-bleed style={{ position: 'absolute', right: 154, bottom: '-0.15em', fontFamily: '"Playfair Display", Georgia, serif', fontSize: 346, fontWeight: 400, lineHeight: 1, letterSpacing: '-0.03em', color: light ? 'rgba(25,43,27,0.06)' : 'rgba(212,207,191,0.06)', pointerEvents: 'none' }}>
    {children}
  </div>
);

// Coral mono em-dash: the only list marker. Parent <ul>: listStyle none, padding 0, flex column, gap 15.
const Bullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ display: 'grid', gridTemplateColumns: '2em 1fr', fontFamily: '"Jost", "Noto Serif SC", system-ui, sans-serif', fontSize: 32, fontWeight: 300, lineHeight: 1.7 }}>
    <span style={{ fontFamily: '"JetBrains Mono", monospace', color: '#c8524a' }}>—</span>
    <span>{children}</span>
  </li>
);

// Stat: coral serif figure over a mono label, closed by a hairline. No fill, no box.
const Stat = ({ value, label }: { value: string; label: string }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 15, paddingBottom: 30, borderBottom: '1px solid rgba(212,207,191,0.12)' }}>
    <span style={{ fontFamily: '"Playfair Display", Georgia, serif', fontSize: 86, fontWeight: 400, lineHeight: 1, letterSpacing: '-0.02em', color: '#c8524a' }}>{value}</span>
    <span style={{ fontFamily: '"JetBrains Mono", monospace', fontSize: 22, fontWeight: 300, letterSpacing: '0.12em', textTransform: 'uppercase', color: 'rgba(212,207,191,0.6)' }}>{label}</span>
  </div>
);

// Quote on parchment (#e8e4d6, padding 84px 169px): giant coral mark over an always-italic serif body.
const Quote = ({ children }: { children: React.ReactNode }) => (
  <figure style={{ margin: 0, maxWidth: 1400 }}>
    <div aria-hidden style={{ fontFamily: '"Playfair Display", Georgia, serif', fontSize: 154, lineHeight: 0.6, color: '#c8524a' }}>“</div>
    <blockquote style={{ margin: '30px 0 0', fontFamily: '"Playfair Display", Georgia, serif', fontStyle: 'italic', fontSize: 62, fontWeight: 400, lineHeight: 1.35, letterSpacing: '-0.01em', color: '#192b1b' }}>{children}</blockquote>
  </figure>
);
```

## Do / Don't

- Do set every serif at weight 400 and give each headline at most one `<Em>` in italic coral.
- Do pair every kicker with its 36px coral rule (`Eyebrow`) above the headline.
- Do frame content pages with `ChromeBar` and `Footer`; leave them off chapters and quotes.
- Do use parchment for quotes and page-like moments, with the `light` variants.
- Do keep one focused moment per page; remove an element rather than shrink type.
- Don't bold the serif, set mono in sentence case, or add a fourth typeface.
- Don't use coral as a fill or for body copy.
- Don't use shadows, gradients, blur, rounded corners, or borders thicker than 1px.
- Don't use round bullets or hyphens; the coral em-dash is the only marker.
