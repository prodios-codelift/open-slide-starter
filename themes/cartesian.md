---
name: Cartesian
description: "Warm sandstone canvas, Playfair Display serifs and 1px taupe hairlines, with compass-drawn rings drifting behind; quiet and unhurried."
mode: light
mood: [quiet, considered, elegant, warm-minimal]
tone: [classical, literary, restrained, confident-quiet]
formality: high
density: low
scheme: light
best_for: "Investment theses, white papers, advisory work, longform research, and gallery or cultural decks where restraint is the message."
avoid_for: "Decks that need visual heat, multiple accents, or urgency; the warm-neutral palette is intentionally low-energy."
source: bold:cartesian
---

# Cartesian

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#EDE8E0` | warm sandstone, every page |
| bg-alt | `#E2DBD1` | deeper stone: image frames, portrait circles, chart grid |
| text | `#1A1A1A` | ink: every Playfair headline, numeral and quote |
| muted | `#5A5A5A` | warm grey: body paragraphs and subtitles |
| accent | `#8A8178` | taupe: labels, eyebrows, small numerals, page counter |
| line | `#B8B0A4` | the universal 1px hairline: rules, borders, rings |
| card-fill | `rgba(255,255,255,0.3)` | tracing-paper wash inside a card |

## Typography

- Display font: `"Playfair Display", Georgia, "Times New Roman", serif` at weight 400 only, sentence case, always ink. Italic 400 for rare emphasis.
- Body font: `"Inter", system-ui, -apple-system, "Segoe UI", sans-serif` at 400 for body, 500 for labels.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;1,400&family=Inter:wght@400;500&display=swap`
- Type scale (source `rem`/`clamp()` scaled ×1.64 at 1920 wide, held to slide-authoring's floor):
  - Display (cover hero): 144px, line-height 1.1, letter-spacing -0.01em
  - H1 (section, closer): 112px (`Title` default); H2 (page headline): 72px; H3: 44px; all line-height 1.1
  - Stat figure 56px, agenda numeral 40px (taupe), quote mark 128px — all Playfair
  - Subtitle 36px / 1.5; body 32px / 1.6; compact body 28px — Inter
  - Label / eyebrow: 22px Inter 500, uppercase, 0.25em; attribution and counter: 22px Inter 400, uppercase, 0.18em
- CJK: append `"Noto Serif SC"` to both stacks (700 headlines, 400 body); no tracking or uppercase on Hanzi.

## Layout

- Content padding: 120px vertical, 192px horizontal (1920×1080); the `VerticalLine` margin rule at 154px sits just outside the text column.
- One idea per page, left-aligned or asymmetric two-column; centered only for quotes and closers. Leave at least half the canvas empty.
- Gutters: 116px major, 96px standard, 56px card grid. Gaps: label → headline 28px, headline → body 24px, header → grid 64px.
- Decoration sits absolute behind a `position: 'relative'` content block; two per page at most.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 112 }: { children: React.ReactNode; size?: number }) => (
  <h1
    style={{
      fontFamily: '"Playfair Display", Georgia, "Times New Roman", serif',
      fontSize: size,
      fontWeight: 400,
      lineHeight: 1.1,
      letterSpacing: '-0.01em',
      margin: 0,
      color: '#1A1A1A',
    }}
  >
    {children}
  </h1>
);
```

### Footer

No rule, no header bar. Pass real deck chrome (company, date) as `label`.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ label }: { label?: string }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div
      style={{
        position: 'absolute',
        left: 192,
        right: 192,
        bottom: 64,
        display: 'flex',
        justifyContent: 'space-between',
        fontFamily: '"Inter", system-ui, sans-serif',
        fontSize: 22,
        letterSpacing: '0.18em',
        textTransform: 'uppercase',
        color: '#8A8178',
      }}
    >
      <span>{label}</span>
      <span>
        {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      fontFamily: '"Inter", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 500,
      letterSpacing: '0.25em',
      textTransform: 'uppercase',
      color: '#8A8178',
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: static. Pages are set like a printed catalogue; nothing inside moves. If the deck needs a transition, use a plain 240ms opacity fade.

## Aesthetic

Museum catalogue meets architectural monograph: the Cooper Hewitt catalogue, Vignelli's editorial work, pencil on tracing paper. A warm sandstone page carries thin-stroke Playfair headlines in ink and quiet Inter body in grey. Every structure is a single 1px taupe line; faint compass rings, solid with a dashed twin inside, drift behind the content as drafting atmosphere. Hierarchy comes from type contrast and space alone. No bold serif, no colour accents, no shadows, gradients or rounded corners.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#EDE8E0',
      color: '#1A1A1A',
      position: 'relative',
      padding: '120px 192px',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
      fontFamily: '"Inter", system-ui, sans-serif',
    }}
  >
    <GeoDecoration />
    <HorizontalAccent />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 28, maxWidth: 1400 }}>
      <Eyebrow>Chapter One · 2026</Eyebrow>
      <Title size={144}>The Quiet Case</Title>
      <p style={{ fontSize: 36, lineHeight: 1.5, color: '#5A5A5A', maxWidth: 1000, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <Footer label="Northfield Advisory" />
  </div>
);
```

## Signature elements

```tsx
// Compass ring: a 1px taupe circle, solid or dashed.
const Ring = ({ size, dashed = false, style }: { size: number; dashed?: boolean; style?: React.CSSProperties }) => (
  <div aria-hidden style={{ position: 'absolute', width: size, height: size, borderRadius: '50%', border: `1px ${dashed ? 'dashed' : 'solid'} #B8B0A4`, ...style }} />
);

// Corner construction: solid ring with a dashed ring at 80% inside, bleeding off the
// top-right corner. Swap top/right for bottom/left to anchor another corner.
const GeoDecoration = ({ size = 960 }: { size?: number }) => (
  <div aria-hidden data-bleed style={{ position: 'absolute', top: -size * 0.3, right: -size * 0.3, width: size, height: size, opacity: 0.5, pointerEvents: 'none' }}>
    <Ring size={size} />
    <Ring size={size * 0.8} dashed style={{ top: size * 0.1, left: size * 0.1 }} />
  </div>
);

// Centered ring with a dashed ring at 70%: closing and quote pages.
const GeoRing = () => (
  <div aria-hidden style={{ position: 'absolute', left: 480, top: 60, width: 960, height: 960, opacity: 0.3, pointerEvents: 'none' }}>
    <Ring size={960} />
    <Ring size={672} dashed style={{ top: 144, left: 144 }} />
  </div>
);

// Drafting margin rule, floor to ceiling.
const VerticalLine = () => (
  <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: 154, width: 1, background: '#B8B0A4', opacity: 0.3 }} />
);

// The only ink line in the system: a terminal rule for covers and closers.
const HorizontalAccent = () => (
  <div aria-hidden style={{ position: 'absolute', left: 192, bottom: 162, width: 384, height: 1, background: '#1A1A1A' }} />
);

// Agenda row: taupe numeral, label, 1px rule below. Stack for a list.
const AgendaRow = ({ n, children }: { n: string; children: React.ReactNode }) => (
  <div style={{ display: 'flex', alignItems: 'baseline', gap: 48, padding: '24px 0', borderBottom: '1px solid #B8B0A4' }}>
    <span style={{ fontFamily: '"Playfair Display", Georgia, serif', fontSize: 40, color: '#8A8178', minWidth: 64 }}>{n}</span>
    <span style={{ fontSize: 34, color: '#1A1A1A' }}>{children}</span>
  </div>
);

// Tracing-paper card: 1px taupe outline, faint white wash. No radius, no shadow.
const Card = ({ children }: { children: React.ReactNode }) => (
  <div style={{ border: '1px solid #B8B0A4', background: 'rgba(255,255,255,0.3)', padding: '48px 40px' }}>{children}</div>
);

// Stat: modest figure over a label. Row: borderTop '1px solid #B8B0A4', paddingTop 32, gap 56.
const Stat = ({ value, label }: { value: string; label: string }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
    <span style={{ fontFamily: '"Playfair Display", Georgia, serif', fontSize: 56, lineHeight: 1 }}>{value}</span>
    <span style={{ fontSize: 22, fontWeight: 500, letterSpacing: '0.25em', textTransform: 'uppercase', color: '#8A8178' }}>{label}</span>
  </div>
);

// Image frame: deeper stone with a corner-to-corner hairline X until the real <img> fills it.
const XFrame = ({ width, height, children }: { width: number; height: number; children?: React.ReactNode }) => (
  <div
    style={{
      width,
      height,
      border: '1px solid #B8B0A4',
      backgroundColor: '#E2DBD1',
      backgroundImage:
        'linear-gradient(to top right, transparent calc(50% - 1px), #B8B0A4 50%, transparent calc(50% + 1px)), linear-gradient(to bottom right, transparent calc(50% - 1px), #B8B0A4 50%, transparent calc(50% + 1px))',
    }}
  >
    {children}
  </div>
);
```

Quote pages: a 128px Playfair `“` in taupe at 50% opacity above a 72px ink headline, a 22px uppercase taupe attribution below. Charts: primary series ink 2px, comparison `#B8B0A4` dashed `5 5`, grid `#E2DBD1`, ticks `#8A8178`.

## Do / Don't

- Do make every divider, border and ring a 1px `#B8B0A4` hairline; the one ink line is `HorizontalAccent`.
- Do set every Playfair element at weight 400 in ink; taupe only for small numerals.
- Do set labels, attributions and counters in uppercase Inter with 0.18–0.25em tracking.
- Do use one or two decorations per page, at 30–50% opacity, behind content.
- Don't add any colour accent, not even in charts.
- Don't bold or uppercase Playfair, or pair it with a sans other than Inter.
- Don't use shadows, gradients, rounded rectangles or borders over 1px; circles are the only curves.
