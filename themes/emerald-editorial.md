---
name: Emerald Editorial
description: "Magazine-cover editorial: saturated emerald, deep navy ink and oat paper, Bodoni Moda 900 at poster scale, and double-rule playbill ornaments."
mode: light
mood: [editorial, considered, confident, magazine-cover]
tone: [literary, authoritative, warm, designed]
formality: high
density: medium
scheme: mixed
best_for: "Leadership readouts, strategy briefings and planning reviews, or launches and research recaps, that should feel like the front of a serious magazine."
avoid_for: "Contexts that need to read as quiet, neutral, or institutionally restrained; the emerald field is too saturated to disappear into the background."
source: bold:emerald-editorial
---

# Emerald Editorial

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#3CD896` | emerald canvas: cover and every content page |
| text | `#0F1A5C` | navy ink: all type on emerald and paper, every rule and border |
| accent | `#0F1A5C` | navy as a fill: inverse tiles, pills, section panels. Emphasis is inversion, never a new hue |
| muted | `#3A4593` | ink-3: secondary copy only where full ink is too loud; sparingly |
| paper | `#F1E9D6` | oat: the alt tile and alt bar series, always with navy type |
| on-ink | `#3CD896` | emerald type, bars and rules on navy (the only colour flip) |
| bg-2 / bg-3 | `#2DC684` / `#25B377` | reserved darker emeralds for two adjacent emerald surfaces |
| ink-2 | `#1B2774` | reserved lifted navy for ink-on-ink nuance |
| rule / rule-strong | `rgba(15,26,92,0.22)` / `rgba(15,26,92,0.85)` | faint navy gridline / near-solid rule; never structural |
| grid-on-ink | `rgba(60,216,150,0.22)` | 2px chart gridlines inside a navy chart card |

## Typography

- Display: `"Bodoni Moda", Didot, "Bodoni 72", Georgia, serif`. 900 for every headline, numeral and figure (tracking -0.01 to -0.04em, line-height 0.9–0.96); 800 for ornament words, card titles and units; 700 only for chart axis numbers. Never lighter, never italic, never at label size.
- Body and chrome: `Manrope, system-ui, -apple-system, sans-serif`. 500 for paragraphs; 700/800 in UPPERCASE with 0.05–0.18em tracking for every eyebrow, label, tag, caption and footline. Never at display size.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bodoni+Moda:wght@700;800;900&family=Manrope:wght@500;700;800&display=swap`
- Type scale (source px at 1920; display deliberately oversized, body lifted from the source's 28/26/24 to slide-authoring's floor):
  - Jumbo numeral 460 / lh 0.9 / -0.04em, navy panels only
  - Section / agenda title 200 / lh 0.9 · cover 184 / lh 0.92 / -0.01em · closing 180
  - Statement 130 / lh 0.96 · KPI-row 128 · process 120 · chart 104 · routine headline 92 (`Title` default)
  - KPI figure 144 / -0.03em + unit 60/800 · side stat 92 + unit 48 · step numeral 80
  - Ornament word 84 (statement) / 76 (closing) / 68 (cover), weight 800
  - Card titles 64 (agenda row) / 48 / 44 / 40 (step), weight 800, -0.005em
  - Lede 36 · body 32 · tile body 28, Manrope 500, lh 1.45–1.5
  - Eyebrow 28/800/0.18em · label and footline 26/700/0.05–0.08em · tag and caption 24/800/0.1–0.14em
- CJK: fall back to `"LXGW WenKai TC", "Noto Serif SC"` (display) and `"Noto Sans SC"` (chrome); letter-spacing 0, line-height +0.1, no uppercase on CJK runs.

## Layout

- Content pages: padding 110px sides and top, 130px bottom when the `Footer` shows. Cover: centred column, 120px 110px. Closing: 80px 110px.
- Chrome: `Masthead` at top 56px and `Footer` at bottom 56px, 110px in from each side. Cover and closing always carry both strips; content pages carry the `Masthead`.
- Content: left-aligned; headline + lede in a `1.1fr 1fr` grid (gap 80, align end) above a row of 3–4 tiles (gap 28–50). Covers, statements and closings are centred.
- Section opener: full-bleed `1fr 1fr` grid, a `NumeralPanel` left; eyebrow, 128px headline, lede and `Pill` marks above a 4px rule on the right (padding 70px 90px).
- Every separator (list row, tile rule, section break) is a 4px solid navy rule. No radius, no shadow, no gradient.
- Density medium: one headline at scale plus 3–4 supporting pieces. Crowded? Enlarge the headline and cut pieces.

## Fixed components

### Title

```tsx
// Bodoni 900. 92 routine; 104–130 statements and data; 184 cover; 200 section. onInk on navy pages.
const Title = ({ children, size = 92, onInk = false }: { children: React.ReactNode; size?: number; onInk?: boolean }) => (
  <h1 style={{ fontFamily: '"Bodoni Moda", Didot, "Bodoni 72", Georgia, serif', fontSize: size, fontWeight: 900, lineHeight: size > 150 ? 0.92 : 0.96, letterSpacing: '-0.015em', margin: 0, color: onInk ? '#3CD896' : '#0F1A5C' }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ label = 'Prepared by the Planning Office', onInk = false }: { label?: string; onInk?: boolean }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 110, right: 110, bottom: 56, display: 'flex', justifyContent: 'space-between', fontFamily: 'Manrope, system-ui, sans-serif', fontSize: 26, fontWeight: 700, letterSpacing: '0.05em', textTransform: 'uppercase', whiteSpace: 'nowrap', color: onInk ? '#3CD896' : '#0F1A5C' }}>
      <span>{label}</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children, onInk = false }: { children: React.ReactNode; onInk?: boolean }) => (
  <div style={{ fontFamily: 'Manrope, system-ui, sans-serif', fontSize: 28, fontWeight: 800, letterSpacing: '0.18em', textTransform: 'uppercase', color: onInk ? '#3CD896' : '#0F1A5C' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. Printed ink does not move: pages cut, and nothing animates in.

## Aesthetic

The front of a serious magazine, or a 19th-century theatrical playbill printed in two inks on coloured stock. A saturated emerald field carries deep navy Bodoni Moda at weight 900 and poster scale: 92px is the routine headline, 184–200px the cover and section title, 460px the numeral on a navy panel. Manrope in tracked capitals is the quiet chrome layer. The signature is the double-rule ornament, a small serif word bracketed by stacked rules that splits a title into acts. Depth is inversion only (navy tiles with emerald type, oat-paper alternates), structure is 4px navy rules, and every shape is a strict rectangle. Confident and considered, never corporate: no gradients, shadows, radius, blur or fourth colour.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#3CD896', color: '#0F1A5C', position: 'relative', padding: '120px 110px', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', gap: 40, textAlign: 'center' }}>
    <Masthead left="Volume Seven · Issue Two" right="November · MMXXV" />
    <Eyebrow>Leadership Briefing</Eyebrow>
    <Title size={184}>
      THE STATE
      <Ornament>of</Ornament>
      THE WORK AHEAD
    </Title>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Stacked double rule in currentColor, 8px apart. w = weight: 5 on cover/closing, 4 elsewhere.
const Rules = ({ w = 5, width }: { w?: number; width?: number }) => (
  <span style={{ flex: width ? 'none' : 1, width, height: 2 * w + 12, background: `linear-gradient(currentColor, currentColor) 0 2px / 100% ${w}px no-repeat, linear-gradient(currentColor, currentColor) 0 ${w + 10}px / 100% ${w}px no-repeat` }} />
);

// THE signature: a small Bodoni word bracketed by double rules on BOTH sides. Place it inside a
// centred Title between two display lines. Statement variant: size={84} w={4} width={220}.
const Ornament = ({ children, size = 68, w = 5, width }: { children: React.ReactNode; size?: number; w?: number; width?: number }) => (
  <span style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 32, width: '100%', maxWidth: 1400, margin: '6px auto' }}>
    <Rules w={w} width={width} />
    <span style={{ fontFamily: '"Bodoni Moda", Didot, Georgia, serif', fontSize: size, fontWeight: 800, lineHeight: 1, letterSpacing: 0 }}>{children}</span>
    <Rules w={w} width={width} />
  </span>
);

// Magazine masthead: two uppercase strings across the top (the Footer is its bottom twin).
const Masthead = ({ left, right, onInk = false }: { left: string; right: string; onInk?: boolean }) => (
  <div style={{ position: 'absolute', left: 110, right: 110, top: 56, display: 'flex', justifyContent: 'space-between', fontFamily: 'Manrope, system-ui, sans-serif', fontSize: 26, fontWeight: 700, letterSpacing: '0.05em', textTransform: 'uppercase', whiteSpace: 'nowrap', color: onInk ? '#3CD896' : '#0F1A5C' }}>
    <span>{left}</span>
    <span>{right}</span>
  </div>
);

// Inverse navy tile, or oat paper tile: alternate across a row. Internal rules: borderTop '4px solid currentColor'.
const Tile = ({ children, paper = false }: { children: React.ReactNode; paper?: boolean }) => (
  <div style={{ background: paper ? '#F1E9D6' : '#0F1A5C', color: paper ? '#0F1A5C' : '#3CD896', padding: '32px 36px', display: 'flex', flexDirection: 'column', gap: 18, minWidth: 0 }}>{children}</div>
);

// Mark / tag / delta pill, strict rectangle. onInk inside a navy tile.
const Pill = ({ children, onInk = false }: { children: React.ReactNode; onInk?: boolean }) => (
  <span style={{ alignSelf: 'flex-start', padding: '8px 20px', background: onInk ? '#3CD896' : '#0F1A5C', color: onInk ? '#0F1A5C' : '#3CD896', fontFamily: 'Manrope, system-ui, sans-serif', fontSize: 24, fontWeight: 800, letterSpacing: '0.12em', textTransform: 'uppercase', whiteSpace: 'nowrap' }}>{children}</span>
);

// Agenda / table-of-contents row between 4px navy rules; pass `last` to seal the list.
const AgendaRow = ({ n, name, kind, last = false }: { n: string; name: string; kind: string; last?: boolean }) => (
  <div style={{ display: 'grid', gridTemplateColumns: '130px 1fr 320px', columnGap: 40, alignItems: 'center', padding: '26px 0', borderTop: '4px solid #0F1A5C', borderBottom: last ? '4px solid #0F1A5C' : 'none' }}>
    <span style={{ fontFamily: '"Bodoni Moda", Didot, Georgia, serif', fontSize: 64, fontWeight: 800, lineHeight: 1 }}>{n}</span>
    <span style={{ fontFamily: '"Bodoni Moda", Didot, Georgia, serif', fontSize: 64, fontWeight: 800, lineHeight: 1 }}>{name}</span>
    <span style={{ fontFamily: 'Manrope, system-ui, sans-serif', fontSize: 26, fontWeight: 700, letterSpacing: '0.1em', textTransform: 'uppercase', textAlign: 'right' }}>{kind}</span>
  </div>
);

// Section-opener half: navy panel with a 460px numeral. Corner labels: <Masthead onInk /> as a child.
const NumeralPanel = ({ numeral, children }: { numeral: string; children?: React.ReactNode }) => (
  <div style={{ position: 'relative', height: '100%', background: '#0F1A5C', color: '#3CD896', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
    {children}
    <span style={{ fontFamily: '"Bodoni Moda", Didot, Georgia, serif', fontSize: 460, fontWeight: 900, lineHeight: 0.9, letterSpacing: '-0.04em' }}>{numeral}</span>
  </div>
);
```

## Do / Don't

- Do lead every page with Bodoni 900 at scale; when a page feels crowded, enlarge the headline and cut pieces.
- Do bracket one short word ("of", "and", "worth") between two display lines with `Ornament` on covers, closings and statements.
- Do set cover and closing display words in capitals, content headlines in title case, and every Manrope label in tracked capitals.
- Do separate every list row, tile rule and section with a 4px navy rule; alternate navy and paper tiles across a row.
- Do give cover and closing both strips (`Masthead` + `Footer`); go full-page navy only for section openers and closings.
- Don't add a fourth hue, gradient, shadow, blur or border radius: flat rectangles in emerald, navy and paper only.
- Don't set Bodoni below 700, in italics or at label size, or Manrope at display size or in sentence-case chrome.
- Don't put a 200px+ numeral on emerald; jumbo numerals live on a navy `NumeralPanel`.
- Don't use 1–2px structural rules; 2px is for chart gridlines only.
