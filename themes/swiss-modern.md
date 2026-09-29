---
name: Swiss Modern
description: "Bauhaus-precise grid on pure white and black, with one confident red accent."
mode: light
mood: [precise, confident, modern, structured]
tone: [clean, rational, authoritative, minimal]
formality: high
density: medium
scheme: light
best_for: "Product launches, design systems, and technical or engineering readouts that want to look precise and considered rather than decorative."
avoid_for: "Warm, personal, or narrative-driven content — the grid-first system reads as cold when the content itself carries no structure."
source: preset
derived: true
---

# Swiss Modern

## Palette

| Role         | Value     | Notes                                    |
| ------------ | --------- | ----------------------------------------- |
| bg           | `#FFFFFF` | pure white, primary surface               |
| bg-alt       | `#000000` | pure black, inverted/secondary surface    |
| text         | `#000000` | primary text on white                     |
| text-inverse | `#FFFFFF` | primary text on black                     |
| accent       | `#FF3300` | the single red accent — used sparingly    |
| muted        | `#666666` | secondary text, captions                  |
| border       | `#000000` | grid lines and rules, always pure black   |

## Typography

- Display font: `"Archivo", system-ui, sans-serif` — weight 800–900, tight tracking, all caps for headings that need maximum authority.
- Body font: `"Nunito", system-ui, sans-serif` — weight 400–600.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Archivo:wght@800;900&family=Nunito:wght@400;600&display=swap`
- Type scale:
  - Hero title: 160px, weight 900, line-height 0.95, letter-spacing -0.01em
  - Section heading: 96px, weight 800, line-height 1
  - Page heading: 64px, weight 800, line-height 1.05
  - Body: 32px, weight 400, line-height 1.5
  - Caption / label: 22px, weight 600, uppercase, letter-spacing 0.08em

## Layout

- Content padding: 120px from every canvas edge (1920×1080).
- Grid: a visible column grid — 12 columns at 120px gutters, drawn as thin black hairlines behind content. Content sits asymmetrically on the grid rather than centered; a large index number or label anchors one corner while the headline block sits off-axis.
- Never center content by default. Asymmetry against the visible grid is the system's whole point.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Archivo", sans-serif',
      fontSize: 96,
      fontWeight: 800,
      lineHeight: 1,
      letterSpacing: '-0.01em',
      margin: 0,
      color: '#000000',
    }}
  >
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
    <div
      style={{
        position: 'absolute',
        left: 120,
        right: 120,
        bottom: 60,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        fontFamily: '"Archivo", sans-serif',
        fontSize: 22,
        fontWeight: 600,
        letterSpacing: '0.08em',
        textTransform: 'uppercase',
        color: '#000000',
      }}
    >
      <span style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
        <span style={{ width: 12, height: 12, background: '#FF3300' }} />
        SWISS MODERN
      </span>
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
      fontFamily: '"Archivo", sans-serif',
      fontSize: 22,
      fontWeight: 600,
      letterSpacing: '0.08em',
      textTransform: 'uppercase',
      color: '#FF3300',
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: static. The grid is the drama — pages cut rather than fade, matching the system's precision.

## Aesthetic

International Typographic Style, unapologetically. Pure white and pure black do all the structural work; a single red accent marks the one thing per page that matters. A visible grid runs behind every page and content sits asymmetrically against it — nothing is centered, everything is placed with intent. Geometric primitives (rules, squares, circles) stand in for illustration. The register is rational and confident: precise typography, generous negative space, zero decoration for decoration's sake.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#FFFFFF',
      color: '#000000',
      position: 'relative',
      padding: 120,
    }}
  >
    <GridOverlay />
    <div style={{ position: 'absolute', top: 120, left: 120 }}>
      <Eyebrow>01 / Overview</Eyebrow>
    </div>
    <div style={{ position: 'absolute', bottom: 260, left: 120, maxWidth: 1400 }}>
      <Title>The Big Idea</Title>
      <p style={{ fontFamily: '"Nunito", sans-serif', fontSize: 32, color: '#666666', marginTop: 32 }}>
        A short subtitle that explains what this slide is about.
      </p>
    </div>
    <Dot style={{ position: 'absolute', top: 120, right: 120 }} />
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Visible 12-column grid overlay — thin black hairlines behind every page.
const GridOverlay = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      inset: 0,
      pointerEvents: 'none',
      backgroundImage: 'repeating-linear-gradient(90deg, #000 0, #000 1px, transparent 1px, transparent 160px)',
      opacity: 0.08,
    }}
  />
);

// Solid geometric marker — stands in for illustration. Circle or square.
const Dot = ({ style }: { style?: React.CSSProperties }) => (
  <div style={{ width: 48, height: 48, borderRadius: '50%', background: '#FF3300', ...style }} />
);

const Square = ({ style }: { style?: React.CSSProperties }) => (
  <div style={{ width: 48, height: 48, background: '#000000', ...style }} />
);

// Full-width hairline rule — section breaks, grid boundaries.
const HairlineRule = () => <div style={{ width: '100%', height: 1, background: '#000000' }} />;
```

## Do / Don't

- Do keep every page asymmetric against the grid — nothing centered.
- Do use red only once per page, on the one thing that matters most.
- Do lean on pure black and white for structure before reaching for the accent.
- Do use geometric primitives (circles, squares, rules) instead of illustration.
- Don't soften corners or add shadows — the system is flat and sharp-edged throughout.
- Don't mix in a second accent color. Red is the only hot color in the system.
- Don't center content by default; asymmetry against the visible grid is the point.
