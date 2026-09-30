---
name: Biennale Yellow
description: "Solar yellow on warm parchment with deep indigo serif and atmospheric sun-glow gradients."
mode: light
mood: [editorial, atmospheric, warm, poster-like]
tone: [literary, considered, contemplative, Dutch-editorial]
formality: high
density: medium
scheme: light
best_for: "Art-biennale posters and museum programmes: exhibition decks, arts-institution announcements, design-conference brochures, curatorial pitches, literary publications, and studio retrospectives."
avoid_for: "Decks that need visual punch or saturated multi-color energy; the warm-paper canvas and single yellow are intentionally quiet and atmospheric."
source: bold:biennale-yellow
---

# Biennale Yellow

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#E9E5DB` | paper: warm parchment on every surface, never white or grey |
| text | `#1B2566` | ink: the only text color and the only rule color |
| accent | `#F1EE2E` | sun: panels, bloom cores, tile underprint; never text |
| muted | `rgba(27,37,102,0.2)` | soft hairline between list rows; no muted text exists |
| paper-deep | `#DCD6C4` | darker parchment band for surface differentiation |
| sun-soft | `#F8F39B` | buttery middle stop of the sun bloom |
| haze | `#F0DA7C` | mustard outer stop fading the bloom into paper |
| ember | `#E26B4A` | counter-bloom only, 15–22% opacity; never fill or text |

## Typography

- Display font: `"Instrument Serif", Georgia, serif`, weight 400 only; roman for titles, numerals, dates, italic for quotes. Always tight line-height and negative tracking.
- Body font: `"Archivo", "Helvetica Neue", Arial, sans-serif`: 400 for body (lh ≥ 1.45), 600 uppercase at 0.16–0.32em for every label.
- Data font: `"JetBrains Mono", ui-monospace, monospace` 400, only for dates, figures, chart values, page numbers.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Instrument+Serif:ital@0;1&family=Archivo:wght@400;600&family=JetBrains+Mono&display=swap`
- Type scale at 1920×1080. Display keeps the source's deliberately oversized poster scale; web-sized body, labels and mono scale up into slide-authoring's range:
  - Cover display (`Title`) 240px, lh 0.86, -0.018em · closing statement 172px · chapter numeral 540px, lh 0.84, -0.04em
  - Italic manifesto quote 120px, lh 1.04 · page headline (`Headline`) 76px, lh 1.06 · region headline 56px
  - Hero stat 128px, lh 0.92 · date rail 96px, lh 0.96 · list-row title 40px
  - Lede 36px, body 32px, Archivo 400, lh 1.5 · footer-band text 24px
  - Label 24px (tight 22px) Archivo 600, 0.18em · rail label 22px, 0.32em · mono 22–28px
- CJK: Noto Serif SC for display and body, Noto Sans SC 600 for labels; tracking 0, no uppercase, display lh ≥ 1.0.

## Layout

- Edge padding 76px (the source's `pad-edge`); 56px at the bottom when a footer band closes the page; 80px inside a yellow panel.
- Gaps: 48px between regions, 20px between list rows, 44px between footer-band columns.
- Left-aligned, asymmetric. Cover: eyebrow top-left, date rail top-right, title low, four-column footer band along the bottom.
- Layers, back to front: paper → `SunBloom` (+ `EmberBloom` in the opposite corner) → `BlockTiles` or `YellowPanel` → content (`position: 'relative'`) → `Footer`.
- One display moment plus a few quiet supports. Dense pages repeat hairline-separated rows; they never add boxes.

## Fixed components

### Title

```tsx
// Cover and closing display. Page headlines use <Headline>.
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Instrument Serif", Georgia, serif',
      fontSize: 240,
      fontWeight: 400,
      lineHeight: 0.86,
      letterSpacing: '-0.018em',
      margin: 0,
      color: '#1B2566',
    }}
  >
    {children}
  </h1>
);

const Headline = ({ children }: { children: React.ReactNode }) => (
  <h2 style={{ fontFamily: '"Instrument Serif", Georgia, serif', fontSize: 76, fontWeight: 400, lineHeight: 1.06, letterSpacing: '-0.005em', margin: 0, color: '#1B2566' }}>
    {children}
  </h2>
);
```

### Footer

The page number is the only persistent chrome: mono, bottom-right, ink at 75%.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div
      style={{
        position: 'absolute',
        right: 46,
        bottom: 26,
        fontFamily: '"JetBrains Mono", ui-monospace, monospace',
        fontSize: 22,
        lineHeight: 1,
        letterSpacing: '0.08em',
        color: '#1B2566',
        opacity: 0.75,
      }}
    >
      {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Archivo", "Helvetica Neue", sans-serif', fontSize: 24, fontWeight: 600, lineHeight: 1.2, letterSpacing: '0.18em', textTransform: 'uppercase', color: '#1B2566' }}>
    {children}
  </div>
);

// Serif date or range stacked top-right on covers; en-dash for spans.
const DateRail = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Instrument Serif", Georgia, serif', fontSize: 96, lineHeight: 0.96, letterSpacing: '-0.005em', textAlign: 'right', color: '#1B2566' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Pages crossfade in 280ms (ease, opacity only); blooms and type stay still, like print.

```css
@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
```

## Aesthetic

An art-biennale catalogue or quiet exhibition poster. Warm parchment is flooded with soft solar-yellow blooms, one deep indigo ink sets every letter and rule, and Instrument Serif runs huge and tight against small wide-tracked Archivo labels and JetBrains Mono data. The vocabulary is paper, ink and yellow, and yellow arrives three ways: a soft radial bloom, a flooded panel, a translucent tile underprint. Depth is atmospheric, never structural. No shadows, rounded corners, cards, buttons, or second text color.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#E9E5DB',
      color: '#1B2566',
      position: 'relative',
      padding: '76px 76px 56px',
      display: 'flex',
      flexDirection: 'column',
    }}
  >
    <SunBloom />
    <EmberBloom />
    <BlockTiles />
    <div style={{ position: 'relative', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
      <Eyebrow>Annual Programme · 2026</Eyebrow>
      <DateRail>Jun – Nov<br />2026</DateRail>
    </div>
    <div style={{ position: 'relative', marginTop: 'auto', marginBottom: 56 }}>
      <Title>The Slow Season</Title>
    </div>
    <FooterBand>
      <BandCell label="Venue">Arsenale, Hall 4</BandCell>
      <BandCell label="Curators">The programme team</BandCell>
      <BandCell label="Programme">Forty works on patience</BandCell>
      <BandCell label="About">Exhibitions, talks and readings across the city.</BandCell>
    </FooterBand>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Sun bloom: the system's depth. At least one per page, off-centre or behind the focal element.
const SunBloom = ({ at = '62% 42%', size = '42% 38%' }: { at?: string; size?: string }) => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', backgroundImage: `radial-gradient(ellipse ${size} at ${at}, rgba(241,238,46,0.92) 0%, rgba(248,243,155,0.6) 36%, rgba(240,218,124,0.2) 60%, rgba(233,229,219,0) 85%)` }} />
);

// Ember counter-bloom: small and faint, in the corner opposite the sun.
const EmberBloom = ({ at = '4% 96%' }: { at?: string }) => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', backgroundImage: `radial-gradient(circle 480px at ${at}, rgba(226,107,74,0.2), rgba(226,107,74,0) 70%)` }} />
);

// Translucent sun tiles on an 8-row × 4-column grid: a poster underprint for covers and colophons.
const Tile = ({ col, row, opacity }: { col: string; row: string; opacity: number }) => (
  <div style={{ gridColumn: col, gridRow: row, background: `rgba(241,238,46,${opacity})` }} />
);
const BlockTiles = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gridTemplateRows: 'repeat(8, 1fr)', pointerEvents: 'none' }}>
    <Tile col="3 / 4" row="1 / 4" opacity={0.55} />
    <Tile col="4 / 5" row="4 / 6" opacity={0.4} />
    <Tile col="1 / 3" row="7 / 9" opacity={0.45} />
  </div>
);

// Yellow panel: the hardest color statement, a third of the canvas with ink text on top.
const YellowPanel = ({ children }: { children?: React.ReactNode }) => (
  <div style={{ position: 'absolute', top: 0, right: 0, bottom: 0, width: 640, padding: 80, background: '#F1EE2E', color: '#1B2566' }}>{children}</div>
);

// Footer band: four metadata cells, each topped by a 1px ink hairline.
const FooterBand = ({ children }: { children: React.ReactNode }) => (
  <div style={{ position: 'relative', display: 'grid', gridTemplateColumns: '1.1fr 1fr 1.4fr 2fr', gap: 44 }}>{children}</div>
);
const BandCell = ({ label, children }: { label: string; children: React.ReactNode }) => (
  <div style={{ borderTop: '1px solid #1B2566', paddingTop: 16, fontFamily: '"Archivo", sans-serif' }}>
    <div style={{ fontSize: 22, fontWeight: 600, letterSpacing: '0.16em', textTransform: 'uppercase', marginBottom: 10 }}>{label}</div>
    <div style={{ fontSize: 24, lineHeight: 1.45 }}>{children}</div>
  </div>
);

// Chart bar: ink; the featured row is sun with a 1px ink stroke.
const Bar = ({ pct, lit = false }: { pct: number; lit?: boolean }) => (
  <div style={{ width: `${pct}%`, height: 24, background: lit ? '#F1EE2E' : '#1B2566', border: lit ? '1px solid #1B2566' : 'none' }} />
);
```

Numbered lists: grid `96px 1fr`, 52px serif numeral + 40px serif title, 20px bottom padding over a soft hairline. Ledger rows: mono date · serif title · sans venue · mono duration. Chapter dividers pair a 540px serif numeral with a rail label rotated up the left edge: `position: 'absolute', left: 30, top: 540, transformOrigin: '0 0', transform: 'rotate(-90deg) translateX(-50%)'`, Archivo 600 22px, 0.32em, uppercase.

## Do / Don't

- Do start every page on paper with at least one `SunBloom`; a flat parchment page reads as a CMS template.
- Do set every letter and rule in ink. Color lives behind the text, never in it.
- Do keep Instrument Serif at 400, tight and negatively tracked; every label Archivo 600 uppercase at ≥ 0.16em.
- Do reserve JetBrains Mono for dates, figures, chart values and page numbers.
- Don't add shadows, rounded corners, bordered cards, pills, buttons, or borders thicker than 1px.
- Don't invert: no yellow or paper text on ink. Ink fills only chart bars and rules.
- Don't substitute Inter or system-ui for Archivo, or Times for Instrument Serif.
