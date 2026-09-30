---
name: Cobalt Grid
description: "Electric cobalt serifs on cream graph paper, framed by hairline rules and stair-stepped pixel-glitch scanlines."
mode: light
mood: [editorial, design-research, modernist, monochrome]
tone: [considered, literary, studious, quietly-modern]
formality: high
density: medium
scheme: light
best_for: "Design-research bulletins, studio annuals, agency capabilities, architecture, art and academic decks, and curated trend reports that want one strict ink and printed-ledger calm."
avoid_for: "Decks that need warmth, multi-colour energy, or a casual, playful voice; the cobalt, cream and grid palette is intentionally austere."
source: bold:cobalt-grid
---

# Cobalt Grid

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F0EBDE` | warm cream paper, the only surface |
| text | `#1F2BE0` | electric cobalt ink: every headline, body line, rule and mark |
| accent | `#1F2BE0` | the same cobalt; there is no second hue, emphasis comes from size, face or italic |
| muted | `#5560E5` | ink-soft, for rare secondary marks; dimmed chrome is ink at 40–60% opacity |
| paper-2 | `#E6E0CE` | deeper cream for a rare region tint |
| grid | `rgba(31,43,224,0.10)` | graph-paper lines and "off" chart cells |
| ink-faint | `rgba(31,43,224,0.18)` | 1px row dividers in lists, tables and ledgers |

## Typography

- Display: `"Newsreader", Georgia, "Times New Roman", serif`, weight 400 only (never bold); italic 400 for inline emphasis. Every display size carries negative tracking.
- Body and labels: `"Hanken Grotesk", system-ui, -apple-system, sans-serif`, 400 for body, 600 for uppercase labels at 0.16–0.18em.
- Chrome: `"DM Mono", ui-monospace, Menlo, monospace`, 400 at 0.04–0.08em: page numbers, tags, ticks, vertical labels, delta arrows.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Newsreader:ital,opsz,wght@0,6..72,400;1,6..72,400&family=Hanken+Grotesk:wght@400;600&family=DM+Mono:wght@400&display=swap`
- Type scale (display sizes converted from the source's `min(vw, vh)` clamps at 1920×1080; its web-sized body and labels, 18px and under, raised to slide-authoring's floor):
  - Hero 194px, lh 0.92, -0.008em · big numeral 194px, -0.015em
  - Closing 151px, lh 0.96 · manifesto 119px and quote 97px, lh 1.05 · chapter 108px, lh 1 (all -0.005em)
  - Section headline (topbar) 88px, lh 0.95 (92px on index pages)
  - Subtitle under a hero 50px serif, lh 1.1 · row headline 38px · ledger name 36px
  - Body 32px, lh 1.5 · lede 36px
  - Kicker 24px Hanken 600, 0.18em · label 22px, 0.16em · mono tag 24px, 0.04em · mono chrome and ticks 22px, 0.06em
- CJK: append `"Noto Serif SC"` to the display and body stacks; zero tracking, no uppercase, line-height 1.7 on Hanzi; mono chrome stays Latin.

## Layout

- Chrome frame, on every page, drawn by `Footer`: 1.5px cobalt hairlines 28px from the top and 22px from the bottom, inset 69px left and right; a dim mono label bottom-left and the page number bottom-right, both 52px from the bottom.
- Content frame: inset 86px top, 69px sides, 108px bottom (1782 × 886 usable). Centred manifesto and quote statements use 154px sides.
- `PAPER` (42px graph paper) under every page, never switched off.
- Gaps: 56px between regions, 24px standard, 17px tight, 13px between stacked rows.
- Declarative pages (cover, chapter, quote, closing) carry a `PixelGlitch` column flush right (the closing mirrors it left): 612px on the cover, 312px compact. Keep text clear of it.
- Dense pages (index, data, ledger) open with `Topbar`, then fill the frame with rows split by faint dividers. A sparse dense page reads as a wireframe.
- Zero radius on every shape.

## Fixed components

### Title

```tsx
// Hero 194 by default. Chapter size={108}, closing size={151}. Section headlines use Topbar.
const Title = ({ children, size = 194 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Newsreader", Georgia, "Times New Roman", serif', fontSize: size, fontWeight: 400, lineHeight: size > 140 ? 0.92 : 1, letterSpacing: '-0.008em', margin: 0, color: '#1F2BE0' }}>
    {children}
  </h1>
);

// Inline emphasis is italic in the same cobalt, never a second colour.
const Em = ({ children }: { children: React.ReactNode }) => <em style={{ fontStyle: 'italic' }}>{children}</em>;
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// The whole chrome frame: two hairlines, a dim mono label (deck title, date) bottom-left, page number bottom-right.
const Footer = ({ label }: { label?: string }) => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  const rule = { position: 'absolute', left: 69, right: 69, height: 1.5, background: '#1F2BE0', zIndex: 4 } as const;
  const mono = { position: 'absolute', bottom: 52, zIndex: 4, fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, lineHeight: 1, letterSpacing: '0.06em', color: '#1F2BE0' } as const;
  return (
    <>
      <div aria-hidden style={{ ...rule, top: 28 }} />
      <div aria-hidden style={{ ...rule, bottom: 22 }} />
      {label && <span style={{ ...mono, left: 69, opacity: 0.4 }}>{label}</span>}
      <span style={{ ...mono, right: 69 }}>
        {pad(current)} / {pad(total)}
      </span>
    </>
  );
};
```

### Eyebrow / accents

```tsx
// Hanken kicker: 600, uppercase, tracked. Untracked caps read as untreated.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Hanken Grotesk", system-ui, sans-serif', fontSize: 24, fontWeight: 600, lineHeight: 1, letterSpacing: '0.18em', textTransform: 'uppercase', color: '#1F2BE0' }}>
    {children}
  </div>
);

// Mono lab-tag: catalogue numbers, topbar tags, row numbers, deltas ("No. 04", "↑ 12%").
const Tag = ({ children }: { children: React.ReactNode }) => (
  <span style={{ fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 24, lineHeight: 1, letterSpacing: '0.04em', color: '#1F2BE0' }}>{children}</span>
);
```

## Motion

- Philosophy: static. Nothing inside a page moves, like a printed bulletin; if the deck needs a page transition, use a plain 280ms opacity fade.

## Aesthetic

A two-colour risograph trend report: warm cream paper, one electric cobalt ink, and graph paper under everything, in the line of WIRED Japan, Shift magazine and architectural tracing paper. Newsreader towers at hero size in weight 400, Hanken Grotesk carries body copy and tracked caps, and DM Mono carries every catalogue number and tick. Depth is purely structural: a hairline frame, 1.5px topbar rules, faint row dividers, stair-stepped scanline glitch columns and QR-style mosaics. Studious, quietly modern, austere. No second colour, no bold serif, no rounded corners, no shadows, no gradients.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', ...PAPER, color: '#1F2BE0' }}>
    <PixelGlitch />
    <QRBlock style={{ position: 'absolute', top: 126, right: 168 }} />
    <div style={{ position: 'absolute', top: 86, left: 69, bottom: 108, width: 1180, display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
      <Eyebrow>Trend Report · 2026</Eyebrow>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 40 }}>
        <Title>The Quiet Index</Title>
        <p style={{ fontFamily: '"Newsreader", Georgia, serif', fontSize: 50, lineHeight: 1.1, margin: 0, maxWidth: 1000 }}>
          A short editorial subtitle, set in the display serif.
        </p>
      </div>
    </div>
    <Footer label="The Quiet Index" />
  </div>
);
```

## Signature elements

```tsx
// Graph paper: spread onto every page root. It is the canvas tone, not decoration.
const PAPER = {
  backgroundColor: '#F0EBDE',
  backgroundImage: 'linear-gradient(to right, rgba(31,43,224,0.10) 1px, transparent 1px), linear-gradient(to bottom, rgba(31,43,224,0.10) 1px, transparent 1px)',
  backgroundSize: '42px 42px',
} as const;

// Pixel-glitch column: full-height stair-stepped bands of vertical scanlines on cream, flush to one edge.
// Steps are [top, height, width fraction]; bands sit on the 42px grid and the last stays inside the margin, clear of the page number.
const GLITCH_STEPS = [[0, 126, 1], [126, 84, 0.84], [210, 126, 0.92], [336, 168, 0.7], [504, 84, 0.78], [588, 126, 0.52], [714, 126, 0.36], [840, 84, 0.44], [924, 156, 0.08]] as const;
const PixelGlitch = ({ width = 612, side = 'right', opacity = 1 }: { width?: number; side?: 'left' | 'right'; opacity?: number }) => (
  <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, width, opacity, zIndex: 3, pointerEvents: 'none', ...(side === 'left' ? { left: 0, transform: 'scaleX(-1)' } : { right: 0 }) }}>
    {GLITCH_STEPS.map(([top, height, f]) => (
      <div key={top} style={{ position: 'absolute', right: 0, top, height, width: Math.round((f * width) / 12) * 12, background: 'repeating-linear-gradient(90deg, #1F2BE0 0 3px, #F0EBDE 3px 12px)' }} />
    ))}
  </div>
);

// QR patch: 8×8 cobalt mosaic on a paper plate. The 1.5px paper outset keeps it legible over the glitch column.
const QR = '11101111 10100101 11101111 00011000 10110101 11101011 10100110 11101101';
const QRBlock = ({ size = 104, bits = QR, style }: { size?: number; bits?: string; style?: React.CSSProperties }) => (
  <div aria-hidden style={{ width: size, height: size, boxSizing: 'border-box', display: 'grid', gridTemplateColumns: 'repeat(8, 1fr)', gridTemplateRows: 'repeat(8, 1fr)', gap: 1.5, padding: 4, background: '#F0EBDE', boxShadow: '0 0 0 1.5px #F0EBDE', zIndex: 4, ...style }}>
    {Array.from(bits.replace(/ /g, ''), (b, i) => <span key={i} style={{ background: b === '1' ? '#1F2BE0' : 'transparent' }} />)}
  </div>
);

// Section header for index, data and ledger pages: serif headline left, mono tag right, 1.5px cobalt rule under.
const Topbar = ({ title, tag }: { title: React.ReactNode; tag: string }) => (
  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', gap: 56, paddingBottom: 15, borderBottom: '1.5px solid #1F2BE0' }}>
    <h2 style={{ fontFamily: '"Newsreader", Georgia, serif', fontSize: 88, fontWeight: 400, lineHeight: 0.95, letterSpacing: '-0.005em', margin: 0, color: '#1F2BE0' }}>{title}</h2>
    <Tag>{tag}</Tag>
  </div>
);

// Faint 1px between rows (a ledger's header row takes '1.5px solid #1F2BE0'); solid 1px above a quote attribution.
const ROW = { borderBottom: '1px solid rgba(31,43,224,0.18)' } as const;
const ATTRIBUTION = { borderTop: '1px solid #1F2BE0', paddingTop: 13 } as const;

// Pixel-stack bar: data as grid cells lit from the bottom. Sit 6–8 in a flex row (gap 24, alignItems 'flex-end')
// above a 1.5px cobalt axis with mono ticks. Never a solid filled bar.
const PixelBar = ({ value, of = 12 }: { value: number; of?: number }) => (
  <div style={{ display: 'flex', flexDirection: 'column-reverse', gap: 3, width: 72 }}>
    {Array.from({ length: of }, (_, i) => <span key={i} style={{ height: 18, background: i < value ? '#1F2BE0' : 'rgba(31,43,224,0.10)' }} />)}
  </div>
);

// Catalogue column: mono labels stacked along the right edge, rotated 90°. Ledger deltas: "↑" at full ink, "↓" and "—" at opacity 0.6.
const VLabel = ({ children }: { children: React.ReactNode }) => (
  <span style={{ writingMode: 'vertical-rl', fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, letterSpacing: '0.04em', color: '#1F2BE0' }}>{children}</span>
);
```

## Do / Don't

- Do spread `PAPER` and render `Footer` on every page; the grid and the hairline frame are the system.
- Do set every serif at weight 400 in cobalt and let size carry the hierarchy.
- Do track every Hanken label (600, uppercase, 0.16em or more) and every mono element (0.04–0.08em).
- Do give declarative pages a `PixelGlitch` column, with a `QRBlock` where a discrete anchor helps.
- Do fill index, data and ledger pages; leave manifesto, quote and closing pages open to the grid.
- Don't add a second hue, a bold serif, rounded corners, drop shadows, gradients or solid bar charts.
- Don't let the glitch column or any content reach the page number or cross the text block.
