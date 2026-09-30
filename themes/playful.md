---
name: Playful
description: "Sun-warm peach canvas with charcoal double-stroke cards, hand-rotated blocks, and Syne display type — a friendly indie launch deck."
mode: light
mood: [warm, approachable, indie, friendly]
tone: [upbeat, informal, welcoming]
formality: low
density: medium
scheme: light
best_for: "Indie product launches, creator portfolios, lifestyle brands, and small-business or community decks that want to feel warm and human."
avoid_for: "Contexts where institutional credibility matters more than warmth — the peach palette is intentionally informal."
source: bold:playful
---

# Playful

## Palette

| Role   | Value                | Notes                                                         |
| ------ | --------------------- | -------------------------------------------------------------- |
| bg     | `#F0C8A0`             | peach-clay canvas — the only surface, every page                |
| bg-alt | `#E8B88E`             | darker tonal sibling — image placeholders, "behind" panels      |
| light  | `#F7DEC6`             | lighter tonal sibling — gentle layering without white           |
| text   | `#1A1A1A`             | charcoal ink — all type, borders, fills, SVG strokes            |
| accent | `#1A1A1A`             | alias of text — no separate accent hue, ever                    |
| muted  | `rgba(26,26,26,0.75)` | de-emphasized body copy — same ink at reduced opacity           |

## Typography

- Display font: `"Syne", sans-serif` — weight 700–800 only, always with negative letter-spacing. Never used below 56px.
- Body font: `"Space Grotesk", sans-serif` — weight 400–500 body, 600 for labels/tags.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Space+Grotesk:wght@400;500;600&display=swap`
- Type scale (converted from the source's rem/clamp system):
  - Cover / hero title: 144px, Syne 800, line-height 0.9, letter-spacing -0.03em
  - Section headline: 88px, Syne 700, line-height 1.0, letter-spacing -0.02em
  - Statement / manifesto line: 76px, Syne 700, line-height 1.1
  - Sub-region title: 56px, Syne 700, line-height 1.1, letter-spacing -0.01em
  - Stat hero numeral: 120px, Syne 800 (always weight 800, never lower)
  - Stat mid numeral: 48px, Syne 800
  - Body: 32px, Space Grotesk 400, line-height 1.7
  - Subtitle / lead body: 36px, Space Grotesk 500, line-height 1.6
  - Eyebrow label: 24px, Space Grotesk 600, uppercase, letter-spacing 0.15em
  - Caption: 22px, Space Grotesk 500
  - Tag: 18px, Space Grotesk 600

## Layout

- Content padding: 96px horizontal, 80px vertical on covers/statements; 80px/64px on standard content pages (1920×1080).
- Alignment: left-aligned, single column. One dominant element per slide plus one or two decorative marks — never wall-to-wall.
- Cards, blocks, and stat numerals carry a small ±0.5–3deg rotation, alternating direction between neighbors — never two adjacent elements rotated the same way, never past 3deg.
- No blurred `box-shadow` anywhere. Depth comes only from the double-stroke offset border and rotation.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Syne", sans-serif', fontSize: 144, fontWeight: 800, lineHeight: 0.9, letterSpacing: '-0.03em', margin: 0, color: '#1A1A1A' }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 96, right: 96, bottom: 56, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"Space Grotesk", sans-serif', fontSize: 18, fontWeight: 600, letterSpacing: '0.1em', textTransform: 'uppercase', color: '#1A1A1A' }}>
      <span>PLAYFUL</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Charcoal filled pill with peach text — the system's only inversion, used for eyebrows and tags.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ display: 'inline-block', background: '#1A1A1A', color: '#F0C8A0', padding: '8px 18px', fontFamily: '"Space Grotesk", sans-serif', fontSize: 24, fontWeight: 600, letterSpacing: '0.15em', textTransform: 'uppercase' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. The hand-crafted feel comes from rotation and double borders, not animation — entrances (if any) are a plain 0.3s opacity fade, never a slide or bounce.

## Aesthetic

A hand-crafted editorial system anchored by one warm canvas and one ink color — no gradients, no chromatic accents, no blurred shadows. Depth comes from a double-stroke offset border (a solid outline plus a second offset outline behind it), small hand-placed rotations, and scribbled SVG marks in the corners. Confident but human: a creative-studio sketchbook, not a corporate deck. Corners are sharp, fully round, or organically blob-shaped — never a soft medium radius.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#F0C8A0', color: '#1A1A1A', position: 'relative', padding: '80px 96px', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <GhostBlob />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 32, maxWidth: 1400 }}>
      <Eyebrow>Finance · Q3 2026</Eyebrow>
      <Title>Quarterly Business Review</Title>
      <RoughBox style={{ transform: 'rotate(-1.5deg)', maxWidth: 900 }}>
        <p style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 36, fontWeight: 500, lineHeight: 1.6, margin: 0 }}>
          A short subtitle that explains what this deck is about.
        </p>
      </RoughBox>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Double-stroke offset card — the system's signature depth device. 3px border plus a
// second offset border via ::before, 6-8px down-right. No blur, ever.
const RoughBox = ({ children, style }: { children: React.ReactNode; style?: React.CSSProperties }) => (
  <div style={{ position: 'relative', border: '3px solid #1A1A1A', background: '#F0C8A0', padding: '24px 32px', ...style }}>
    <div aria-hidden style={{ position: 'absolute', inset: '6px -6px -6px 6px', border: '2px solid #1A1A1A', zIndex: -1 }} />
    {children}
  </div>
);

// Oversized atmospheric blob at 8% opacity — watermark cloud behind content, one per slide, in a corner content doesn't occupy.
const GhostBlob = () => (
  <div aria-hidden data-bleed style={{ position: 'absolute', top: -200, right: -220, width: 640, height: 640, background: '#1A1A1A', opacity: 0.08, borderRadius: '40% 60% 70% 30% / 40% 50% 60% 50%', pointerEvents: 'none' }} />
);

// Hand-drawn squiggle — 2px stroke, rounded caps, placed absolutely as corner punctuation.
const Scribble = ({ style }: { style?: React.CSSProperties }) => (
  <svg aria-hidden width="80" height="40" viewBox="0 0 80 40" style={{ position: 'absolute', ...style }}>
    <path d="M2 20 Q 20 2, 40 20 T 78 20" stroke="#1A1A1A" strokeWidth={2} fill="none" strokeLinecap="round" />
  </svg>
);

// Plain outlined rect, slightly rotated — a minimal decorative anchor for slide corners.
const DoodleRect = ({ style }: { style?: React.CSSProperties }) => (
  <div aria-hidden style={{ position: 'absolute', width: 64, height: 64, border: '3px solid #1A1A1A', transform: 'rotate(8deg)', ...style }} />
);
```

## Do / Don't

- Do treat charcoal (`#1A1A1A`) as the only ink — headlines, body, borders, scribbles, fills all share it.
- Do apply the double-stroke offset border (`RoughBox`) to primary content cards; it replaces `box-shadow` entirely.
- Do rotate cards and numerals ±0.5–3deg, alternating direction with neighbors.
- Do place at least one scribble or ghost-blob per slide as hand-drawn breath, anchored to a corner content doesn't occupy.
- Don't introduce a second color. No blues, no reds, no chart palettes — charts stay solid or outlined charcoal.
- Don't use blurred `box-shadow` or `drop-shadow` anywhere.
- Don't use medium border-radius (4–12px). Corners are sharp, fully round, or organic-blob only.
- Don't set Syne below weight 700, or use it for body copy.
- Don't rotate every element the same direction, or past 3deg.
