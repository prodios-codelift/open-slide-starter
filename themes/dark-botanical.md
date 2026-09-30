---
name: Dark Botanical
description: "Near-black canvas with centered Cormorant serif, soft blurred orbs of terracotta, blush and gold pooled in one corner."
mode: dark
mood: [elegant, sophisticated, artistic, premium]
tone: [refined, poetic, understated, warm]
formality: high
density: low
scheme: dark
best_for: "Luxury, beauty, fashion and lifestyle brand stories, gallery or cultural talks, and premium product launches that want a quiet, gallery-lit elegance."
avoid_for: "Data-dense readouts, engineering reviews, and table- or chart-heavy decks — the light serif, muted grey, and centered sparse layout lose clarity under load."
source: preset
derived: true
---

# Dark Botanical

## Palette

| Role        | Value     | Notes                                                      |
| ----------- | --------- | ---------------------------------------------------------- |
| bg          | `#0f0f0f` | near-black, the only surface                               |
| text        | `#e8e4df` | warm off-white, primary copy and headlines                 |
| accent      | `#d4a574` | warm terracotta: eyebrows, vertical lines, key numbers     |
| muted       | `#9a9590` | warm grey: secondary copy, footer, captions                |
| accent-pink | `#e8b4b8` | blush: italic emphasis inside headlines, second orb        |
| accent-gold | `#c9b896` | pale gold: signature italic lines, page numbers, third orb |

## Typography

- Display font: `"Cormorant", "Cormorant Garamond", Georgia, "Times New Roman", serif` at weight 400 for headlines and 600 for smaller page headings. Its italic is the signature voice.
- Body font: `"IBM Plex Sans", system-ui, -apple-system, sans-serif` at weight 300 for body and 400 for labels.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Cormorant:ital,wght@0,400;0,600;1,400;1,600&family=IBM+Plex+Sans:wght@300;400&display=swap`
- Type scale (Cormorant has a small x-height, so display sizes sit at the upper end of the defaults):
  - Hero title: 176px, weight 400, line-height 1, letter-spacing -0.01em
  - Section heading: 120px, weight 400, line-height 1.05
  - Page heading: 72px, weight 600, line-height 1.1
  - Signature italic line: 44px, Cormorant italic 400, line-height 1.3
  - Body: 34px, Plex Sans 300, line-height 1.6
  - Caption / label: 22px, Plex Sans 400, uppercase, letter-spacing 0.32em

## Layout

- Content padding: 160px horizontal, 120px vertical (1920×1080).
- Alignment: centered, single column. Headlines max 1400px wide, body max 1100px, stacked on one vertical axis with 32–48px gaps.
- Orbs pool in one corner per page, bleeding off the edge and never behind the text block. Alternate top-right and bottom-left across pages for rhythm.
- Two-column content pages keep centered headings and split the body at a thin vertical accent line instead of a gutter.
- Leave at least half the canvas empty. Density is low by design.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Cormorant", "Cormorant Garamond", Georgia, serif',
      fontSize: 120,
      fontWeight: 400,
      lineHeight: 1.05,
      letterSpacing: '-0.01em',
      margin: 0,
      color: '#e8e4df',
    }}
  >
    {children}
  </h1>
);

// Italic blush emphasis: wrap one word or phrase per headline.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'italic', color: '#e8b4b8' }}>{children}</em>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div
      style={{
        position: 'absolute',
        left: 160,
        right: 160,
        bottom: 64,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'baseline',
        fontFamily: '"IBM Plex Sans", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 400,
        letterSpacing: '0.32em',
        textTransform: 'uppercase',
        color: '#9a9590',
      }}
    >
      <span>Dark Botanical</span>
      <span
        style={{
          fontFamily: '"Cormorant", Georgia, serif',
          fontStyle: 'italic',
          fontSize: 28,
          letterSpacing: '0.04em',
          textTransform: 'none',
          color: '#c9b896',
        }}
      >
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
      fontFamily: '"IBM Plex Sans", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 400,
      letterSpacing: '0.32em',
      textTransform: 'uppercase',
      color: '#d4a574',
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Text blooms in slowly from a soft blur (0.9–1.2s, ease-out), and orbs may drift very slowly. Nothing snaps or bounces.

```css
@keyframes bloom {
  from { opacity: 0; filter: blur(8px); transform: translateY(12px); }
  to   { opacity: 1; filter: blur(0); transform: translateY(0); }
}
@keyframes drift {
  0%, 100% { transform: translate(0, 0); }
  50%      { transform: translate(-24px, 18px); }
}
```

## Aesthetic

Gallery-lit elegance, like a perfumer's lookbook or a botanical exhibition catalogue after dark. A near-black canvas holds centered Cormorant headlines in warm off-white, with blush italics carrying the emphasis. The only imagery is abstract: a few large, heavily blurred orbs of terracotta, blush and pale gold overlap in one corner like light through petals. Thin vertical lines in warm tones mark the page's axis. Everything is quiet and generous with space. No illustrations, icons, photos of plants, hard edges, or bright saturated colour.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#0f0f0f',
      color: '#e8e4df',
      position: 'relative',
      padding: '120px 160px',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      textAlign: 'center',
    }}
  >
    <OrbCluster />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 40 }}>
      <VerticalLine />
      <Eyebrow>Autumn Collection · 2026</Eyebrow>
      <Title>
        The Quiet <Em>Bloom</Em>
      </Title>
      <Signature>A short subtitle, set in italic like a handwritten note.</Signature>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Soft blurred orb: the system's only imagery. Bleeds off-canvas, so mark it data-bleed.
const Orb = ({ size, color, style }: { size: number; color: string; style?: React.CSSProperties }) => (
  <div
    aria-hidden
    data-bleed
    style={{
      position: 'absolute',
      width: size,
      height: size,
      borderRadius: '50%',
      background: color,
      filter: 'blur(90px)',
      opacity: 0.5,
      pointerEvents: 'none',
      ...style,
    }}
  />
);

// Three overlapping orbs pooled in the top-right corner. Mirror the offsets for bottom-left.
const OrbCluster = () => (
  <>
    <Orb size={640} color="#d4a574" style={{ top: -220, right: -180 }} />
    <Orb size={460} color="#e8b4b8" style={{ top: 140, right: 160, opacity: 0.38 }} />
    <Orb size={340} color="#c9b896" style={{ top: -80, right: 440, opacity: 0.3 }} />
  </>
);

// Thin vertical accent line, fading in from nothing. Use it above a centered title or as a column divider.
const VerticalLine = ({ height = 140 }: { height?: number }) => (
  <div
    aria-hidden
    style={{ width: 1, height, background: 'linear-gradient(to bottom, rgba(212,165,116,0), #d4a574)' }}
  />
);

// Italic signature line for subtitles, pull-quotes, and sign-offs.
const Signature = ({ children }: { children: React.ReactNode }) => (
  <p
    style={{
      fontFamily: '"Cormorant", Georgia, serif',
      fontStyle: 'italic',
      fontSize: 44,
      lineHeight: 1.3,
      color: '#c9b896',
      margin: 0,
      maxWidth: 1100,
    }}
  >
    {children}
  </p>
);
```

## Do / Don't

- Do center content on one vertical axis and let the orbs carry the asymmetry.
- Do use italic Cormorant for emphasis (`<Em>`) and for subtitles and sign-offs (`<Signature>`).
- Do keep warm accents (terracotta, blush, gold) for small things: eyebrows, lines, italics, numerals.
- Do pool orbs in a single corner and keep them heavily blurred.
- Don't add illustrations, icons, botanical clip-art or photos. Only abstract CSS shapes.
- Don't use a pure white or a cold, saturated colour; the whole palette stays warm.
- Don't set body copy in the serif or headlines in the sans.
- Don't use hard edges, drop shadows, or boxed cards; separate things with space and thin lines.
