---
name: Bold Poster
description: "White poster sheet, brown-black ink and one tomato red: tilted Shrikhand display over Baskerville body and tracked Space Grotesk labels."
mode: light
mood: [bold, editorial, loud, confident]
tone: [dramatic, graphic, sharp, intentional]
formality: medium
density: low
scheme: light
best_for: "Decks that should land like a magazine cover: brand manifestos, founder vision, editorial or cultural pitches, even a keynote that wants a few quotable words."
avoid_for: "Decks that must carry dense information per slide; the layout is built around a few large statements, not paragraphs of detail."
source: bold:bold-poster
---

# Bold Poster

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#FFFFFF` | white sheet, the default ground |
| text | `#1C1410` | warm brown-black ink: body, every border, dark-panel ground |
| accent | `#D8000F` | tomato red, the only accent: numerals, eyebrows, leftbars, bullets, progress bar, red-panel ground |
| muted | `#8E8A88` | ink at 50% on white: counter, captions |
| light | `#F5F2EF` | warm off-white for alternating pillar stripes |
| on-panel | `#FFFFFF` | text on red and ink panels; `rgba(255,255,255,0.6)` for tertiary |
| hairline | `rgba(28,20,16,0.08)` | soft rule between bullet rows |

Four colours, no fifth. Red never sets body text and never fills a shape without text on it.

## Typography

- Display font: `"Shrikhand", "Cooper Black", Georgia, serif`, weight 400 (its only weight): every headline, stat, numeral and card title. Hierarchy comes from size, colour and tilt.
- Body font: `"Libre Baskerville", Baskerville, Georgia, serif`, 400, line-height 1.6–1.75 (never under 1.5).
- Label font: `"Space Grotesk", system-ui, sans-serif`, 600, uppercase, 0.18–0.25em tracking: eyebrows, labels, counter, links. 400 for bullets.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Shrikhand&family=Libre+Baskerville:ital,wght@0,400;1,400&family=Space+Grotesk:wght@400;600&display=swap`
- Type scale (display at the source's 1920 poster sizes; its web-sized text doubled onto slide-authoring's scale):
  - Hero stack: 220 / 260 red at -4° / 200 at +2°, line-height 0.88 (deliberately past the 200 cap)
  - Stat 320px red at -6°; closing title 260px red at -5°; red-panel quote 110px white
  - Title (section header) 112px; numeral 88px red; card title 60px
  - Body 32px / 1.7; cell body 28px / 1.6; bullets 28px Space Grotesk 400
  - Eyebrow, label, counter: 22px Space Grotesk 600, uppercase

## Layout

- Content padding: 120px vertical, 134px horizontal (the source's 7vw inset).
- Cover: three-line hero stack top-left, tagline pinned bottom-right (max 560px) on a red leftbar.
- Content: Eyebrow + Title top-left, then 2–4 cells (48px × 64px gap). Pillar pages go full-bleed: columns padded 64px × 48px, 6px ink rules between, grounds alternating `#FFFFFF` / `#F5F2EF`.
- Statement pages flood red or ink and hold one tilted element in massive negative space.
- Square corners everywhere. Borders are the depth: 2px hairline, 3px cell, 4px card/link, 6px grid frame and pillar rule, 8px red leftbar, 10px progress bar.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Shrikhand", "Cooper Black", Georgia, serif',
      fontSize: 112,
      fontWeight: 400,
      lineHeight: 1,
      letterSpacing: '0.01em',
      margin: 0,
      color: '#1C1410',
    }}
  >
    {children}
  </h1>
);

// One line of the hero stack. A cover Title holds three: at least one red, at least one tilted.
const Line = ({ children, size, tilt = 0, red = false }: { children: React.ReactNode; size: number; tilt?: number; red?: boolean }) => (
  <span
    style={{
      display: 'block', width: 'fit-content', fontSize: size, lineHeight: 0.88,
      margin: tilt ? '0.1em 0' : 0,
      transform: tilt ? `rotate(${tilt}deg)` : undefined,
      color: red ? '#D8000F' : undefined,
    }}
  >
    {children}
  </span>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Red progress bar on the bottom edge + NN / NN counter. Pass the page's ground.
const Footer = ({ surface = 'light' }: { surface?: 'light' | 'dark' | 'red' }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <>
      <div
        aria-hidden
        style={{
          position: 'absolute', left: 0, bottom: 0, height: 10,
          width: `${(current / total) * 100}%`,
          background: surface === 'red' ? '#1C1410' : '#D8000F',
        }}
      />
      <div
        style={{
          position: 'absolute', right: 48, bottom: 36,
          fontFamily: '"Space Grotesk", system-ui, sans-serif',
          fontSize: 22, fontWeight: 600, letterSpacing: '0.18em',
          color: surface === 'light' ? '#8E8A88' : 'rgba(255,255,255,0.6)',
        }}
      >
        {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
      </div>
    </>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      fontFamily: '"Space Grotesk", system-ui, sans-serif',
      fontSize: 22, fontWeight: 600, letterSpacing: '0.24em',
      textTransform: 'uppercase', color: '#D8000F',
    }}
  >
    {children}
  </div>
);

// Inline emphasis inside Baskerville body switches face, never just weight.
const Strong = ({ children }: { children: React.ReactNode }) => (
  <strong style={{ fontFamily: '"Space Grotesk", system-ui, sans-serif', fontWeight: 600 }}>{children}</strong>
);
```

## Motion

- Philosophy: subtle. The poster is static; at most a page rises in (12px + 0.98 scale, 260ms). Put it on a wrapper, never on a tilted element, or it erases the rotation.

```css
@keyframes posterIn {
  from { opacity: 0; transform: translateY(12px) scale(0.98); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}
```

## Aesthetic

A populist editorial poster: vintage Italian sports-magazine lettering, a 1970s European brand annual report, a wine merchant's catalogue. Every page should feel printed. Chunky Shrikhand at poster scale, tilted off-axis, carries every headline and number; Libre Baskerville gives the body a literary register; small tracked Space Grotesk labels read as stamped metadata. White sheet, warm ink, one saturated red. Depth is structural: heavy ink rules, red leftbars, whole pages flooded red or ink. Loud and confident with few words. No rounded cards, drop shadows, gradients or second accent.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#FFFFFF',
      color: '#1C1410',
      position: 'relative',
      padding: '120px 134px',
      display: 'flex',
      flexDirection: 'column',
      gap: 48,
    }}
  >
    <Eyebrow>Manifesto · 2026</Eyebrow>
    <Title>
      <Line size={220}>Make</Line>
      <Line size={260} tilt={-4} red>Things</Line>
      <Line size={200} tilt={2}>Loud</Line>
    </Title>
    <div style={{ position: 'absolute', right: 134, bottom: 130, maxWidth: 560 }}>
      <RedBar>
        <p style={{ fontFamily: '"Libre Baskerville", Baskerville, Georgia, serif', fontSize: 30, lineHeight: 1.6, margin: 0 }}>
          A short subtitle that says what this deck is about.
        </p>
      </RedBar>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Editorial card: 8px red left rule, no outline. Use 6px on dark panels.
const RedBar = ({ children }: { children: React.ReactNode }) => (
  <div style={{ borderLeft: '8px solid #D8000F', paddingLeft: 36 }}>{children}</div>
);

// Statement figure: red Shrikhand, always tilted -6°. One per page, white space all round.
const StatBig = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Shrikhand", "Cooper Black", Georgia, serif', fontSize: 320, lineHeight: 0.82, color: '#D8000F', transform: 'rotate(-6deg)', width: 'fit-content' }}>
    {children}
  </div>
);

// Stacked "pressed" shadow: only for white display type on a #D8000F page.
const PRESSED = '3px 3px 0 rgba(28,20,16,0.25), 6px 6px 0 rgba(28,20,16,0.2), 9px 9px 0 rgba(28,20,16,0.15)';
const RedQuote = ({ children }: { children: React.ReactNode }) => (
  <p style={{ fontFamily: '"Shrikhand", "Cooper Black", Georgia, serif', fontSize: 110, lineHeight: 1.15, color: '#FFFFFF', textShadow: PRESSED, margin: 0 }}>
    {children}
  </p>
);

// Double-border data grid: 6px ink frame, 3px cell borders touching at every join.
const InkGrid = ({ children }: { children: React.ReactNode }) => (
  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', border: '6px solid #1C1410' }}>{children}</div>
);
const Cell = ({ figure, label, children }: { figure: string; label: string; children: React.ReactNode }) => (
  <div style={{ border: '3px solid #1C1410', padding: '40px 36px', display: 'flex', flexDirection: 'column', gap: 16 }}>
    <div style={{ fontFamily: '"Shrikhand", "Cooper Black", Georgia, serif', fontSize: 88, lineHeight: 1, color: '#D8000F' }}>{figure}</div>
    <div style={{ fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 22, fontWeight: 600, letterSpacing: '0.2em', textTransform: 'uppercase' }}>{label}</div>
    <p style={{ fontFamily: '"Libre Baskerville", Baskerville, Georgia, serif', fontSize: 28, lineHeight: 1.6, margin: 0 }}>{children}</p>
  </div>
);

// Red em-dash bullet with a soft hairline under each row. No disc bullets, ever.
const Bullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ position: 'relative', listStyle: 'none', padding: '10px 0 10px 44px', borderBottom: '2px solid rgba(28,20,16,0.08)', fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 28, lineHeight: 1.45 }}>
    <span style={{ position: 'absolute', left: 0, color: '#D8000F', fontWeight: 700 }}>—</span>
    {children}
  </li>
);

// Closing-page link: tracked uppercase over a 4px red underline.
const PosterLink = ({ children }: { children: React.ReactNode }) => (
  <span style={{ fontFamily: '"Space Grotesk", system-ui, sans-serif', fontSize: 24, fontWeight: 600, letterSpacing: '0.18em', textTransform: 'uppercase', borderBottom: '4px solid #D8000F', paddingBottom: 8 }}>
    {children}
  </span>
);
```

## Do / Don't

- Do open with a three-line `Line` stack: sizes differ, at least one line red, one tilted.
- Do set every number in red Shrikhand, from 320px stats to inline figures.
- Do tilt statement type (`StatBig` -6°, closing title -5°); untilted red display looks misplaced.
- Do switch the ground (white, stripe, red, ink) when pages feel flat, and pass it to `Footer`.
- Don't add a second accent, tint, gradient or drop shadow; `PRESSED` on red is the only shadow.
- Don't round corners, and don't cross the faces (no Shrikhand body, Baskerville labels or Space Grotesk headlines).
- Don't crowd statement pages: one tilted element and a line of Baskerville.
- CJK: Noto Serif SC 900/400 + Noto Sans SC 500; keep tilts and red, drop uppercase and tracking.
