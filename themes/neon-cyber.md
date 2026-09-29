---
name: Neon Cyber
description: "Deep navy void lit by cyan and magenta neon: glowing type, drifting particles, and luminous grids."
mode: dark
mood: [futuristic, electric, confident, techy]
tone: [bold, technical, sleek, forward-looking]
formality: medium
density: low
scheme: dark
best_for: "Product launches, AI and developer keynotes, hackathon demos, and startup pitches that should feel futuristic and high-energy."
avoid_for: "Conservative finance, legal, healthcare, or academic rooms and data-dense readouts; the glow and particle texture fight fine print and read as flashy."
source: preset
derived: true
---

# Neon Cyber

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#0A0F1C` | deep navy void, every page |
| bg-alt | `#111A2E` | lifted navy for panels |
| text | `#E8F4FF` | cool white, primary copy |
| accent | `#00FFCC` | cyan neon: the glowing word, numbers, grids |
| accent-2 | `#FF00AA` | magenta neon: eyebrows, markers, the one hot spark |
| muted | `#7A8BA8` | steel blue, secondary copy and footer chrome |
| border | `rgba(0,255,204,0.2)` | cyan hairline on navy |
| grid | `rgba(0,255,204,0.09)` | grid-pattern lines |
| glow | `rgba(0,255,204,0.6)`, `rgba(255,0,170,0.55)` | cyan / magenta `box-shadow` and `text-shadow` halos |

## Typography

- Display font: `"Sora", system-ui, sans-serif`, weight 600–700, tight tracking. Stands in for Clash Display (Fontshare-only).
- Body font: `"Plus Jakarta Sans", system-ui, sans-serif`, weight 400–500. Stands in for Satoshi.
- Labels (eyebrow, footer, tags): Sora 600, uppercase, 0.24–0.28em tracking, like a HUD read-out.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Sora:wght@600;700&family=Plus+Jakarta+Sans:wght@400;500&display=swap`
- Type scale:
  - Hero title: 160px, weight 700, line-height 1, -0.03em tracking (covers of ≤3 words)
  - Title / section heading: 112px, weight 700, line-height 1.04 (`Title` default)
  - Page heading: 72px, weight 600, line-height 1.1
  - Stat value: 144px, Sora 700, always cyan with glow
  - Body: 34px, weight 400, line-height 1.55; lead 40px
  - Caption / label: 22px, Sora 600, uppercase, 0.24em tracking

## Layout

- Content padding: 120px. The canvas is exactly 16 × 9 cells of 120px (the `GridField` cell), so content edges sit on grid lines.
- Alignment: left-aligned. Covers center vertically; content pages top-anchor at 120px. Split columns on cell boundaries (e.g. 8 + 7 cells, one-cell gutter).
- Layering, back to front: `NEON_BG`, then `GridField` / `Particles`, then content (`position: 'relative'`), then `Footer`.
- Density is low: keep 40%+ of the page dark. Glow only reads against the void.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Sora", system-ui, sans-serif',
      fontSize: 112,
      fontWeight: 700,
      lineHeight: 1.04,
      letterSpacing: '-0.03em',
      margin: 0,
      color: '#E8F4FF',
      textShadow: '0 0 32px rgba(0,255,204,0.18)',
    }}
  >
    {children}
  </h1>
);

// Neon tube: wrap ONE word per headline for the cyan glow.
const Neon = ({ children }: { children: React.ReactNode }) => (
  <span
    style={{
      color: '#00FFCC',
      textShadow: '0 0 6px rgba(0,255,204,0.9), 0 0 20px rgba(0,255,204,0.6), 0 0 48px rgba(0,255,204,0.35)',
    }}
  >
    {children}
  </span>
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
        bottom: 56,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingTop: 16,
        borderTop: '1px solid rgba(0,255,204,0.2)',
        fontFamily: '"Sora", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 600,
        letterSpacing: '0.24em',
        textTransform: 'uppercase',
        color: '#7A8BA8',
      }}
    >
      <span style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
        <span style={{ width: 8, height: 8, borderRadius: '50%', background: '#FF00AA', boxShadow: '0 0 8px #FF00AA, 0 0 20px rgba(255,0,170,0.6)' }} />
        NEON CYBER
      </span>
      <span style={{ color: '#00FFCC', textShadow: '0 0 12px rgba(0,255,204,0.6)' }}>
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
      display: 'flex',
      alignItems: 'center',
      gap: 20,
      fontFamily: '"Sora", system-ui, sans-serif',
      fontSize: 24,
      fontWeight: 600,
      letterSpacing: '0.28em',
      textTransform: 'uppercase',
      color: '#FF00AA',
      textShadow: '0 0 12px rgba(255,0,170,0.55)',
    }}
  >
    <span style={{ width: 48, height: 2, background: '#FF00AA', boxShadow: '0 0 10px #FF00AA' }} />
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. The `<Neon>` word flickers on once at entry and the particles drift upward over 120s; nothing else moves. Pages cut or take a 240ms fade.
- Keyframes (inject with `webfonts.md`'s create-or-update `<style>` pattern). Apply `flickerOn 0.9s ease-out both` to `<Neon>`, `drift 120s linear infinite` to `<Particles>`:

```css
@keyframes flickerOn {
  0% { opacity: 0; } 10% { opacity: 1; } 12% { opacity: 0.2; }
  20% { opacity: 1; } 24% { opacity: 0.4; } 30%, 100% { opacity: 1; }
}
@keyframes drift {
  to { background-position: 0 -262px, 0 -386px, 0 -178px; }
}
```

## Aesthetic

Neon signage in a dark city, seen through a HUD. A deep navy void carries every page; a faint cyan grid and drifting particles give it depth; light comes from two neon tubes only, cyan for the idea that matters and magenta for the spark that says where to look. Geometric type sits flat in cool white, so the one glowing word reads as lit, not printed. Confident and forward-looking: a keynote, not a game menu. No glitch effects, no rainbow gradients.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: NEON_BG,
      color: '#E8F4FF',
      position: 'relative',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
      padding: '0 120px',
    }}
  >
    <GridField />
    <Particles />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 40, maxWidth: 1560 }}>
      <Eyebrow>Launch · 2026</Eyebrow>
      <Title>
        The Next <Neon>Signal</Neon>
      </Title>
      <NeonRule />
      <p style={{ fontFamily: '"Plus Jakarta Sans", system-ui, sans-serif', fontSize: 34, lineHeight: 1.55, color: '#7A8BA8', maxWidth: 1200, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Page background: magenta bloom top-right, cyan bloom bottom-left.
const NEON_BG =
  'radial-gradient(ellipse 60% 55% at 90% 5%, rgba(255,0,170,0.16), transparent), radial-gradient(ellipse 55% 60% at 5% 100%, rgba(0,255,204,0.12), transparent), #0A0F1C';

// 120px cyan grid (one layout cell), fading toward the edges.
const GridField = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      inset: 0,
      pointerEvents: 'none',
      backgroundImage:
        'linear-gradient(rgba(0,255,204,0.09) 1px, transparent 1px), linear-gradient(90deg, rgba(0,255,204,0.09) 1px, transparent 1px)',
      backgroundSize: '120px 120px',
      maskImage: 'radial-gradient(ellipse at 50% 50%, #000 25%, transparent 80%)',
    }}
  />
);

// Particle background: three dot lattices on coprime tiles read as a random field.
const Particles = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      inset: 0,
      pointerEvents: 'none',
      backgroundImage:
        'radial-gradient(circle, rgba(0,255,204,0.6) 0 1.5px, transparent 2.5px), radial-gradient(circle, rgba(255,0,170,0.5) 0 1.5px, transparent 2.5px), radial-gradient(circle, rgba(232,244,255,0.35) 0 1px, transparent 2px)',
      backgroundSize: '157px 131px, 229px 193px, 97px 89px',
    }}
  />
);

// Magenta perspective floor: section breaks and closers only.
const HorizonGrid = () => (
  <div aria-hidden style={{ position: 'absolute', left: 0, right: 0, bottom: 0, height: 480, perspective: 520, pointerEvents: 'none' }}>
    <div
      style={{
        position: 'absolute',
        inset: 0,
        transform: 'rotateX(64deg)',
        transformOrigin: '50% 100%',
        backgroundImage:
          'linear-gradient(rgba(255,0,170,0.55) 2px, transparent 2px), linear-gradient(90deg, rgba(255,0,170,0.55) 2px, transparent 2px)',
        backgroundSize: '120px 120px',
        maskImage: 'linear-gradient(to top, #000 15%, transparent 95%)',
      }}
    />
  </div>
);

// Cyan-to-magenta neon tube: under a headline or as a section divider.
const NeonRule = ({ width = 240 }: { width?: number }) => (
  <div style={{ width, height: 3, background: 'linear-gradient(90deg, #00FFCC, #FF00AA)', boxShadow: '0 0 12px rgba(0,255,204,0.6), 0 0 28px rgba(255,0,170,0.35)' }} />
);

// Glowing frame for stats and cards: square corners, lit edge.
const NeonPanel = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      padding: 48,
      background: 'rgba(17,26,46,0.72)',
      border: '1px solid rgba(0,255,204,0.45)',
      boxShadow: '0 0 24px rgba(0,255,204,0.18), inset 0 0 32px rgba(0,255,204,0.06)',
    }}
  >
    {children}
  </div>
);
```

## Do / Don't

- Do keep every page on deep navy. Neon only reads against darkness.
- Do glow one word or number per page (`<Neon>`, stat values); the rest stays flat cool white.
- Do give cyan the lead and magenta the spark (eyebrows, markers, one detail), never equal billing.
- Do put `GridField` or `Particles` behind every page, faint enough that body copy stays crisp.
- Don't glow body copy; it blurs running text. Labels get only a soft halo.
- Don't add a third neon colour or rainbow gradients.
- Don't round panel corners or use drop shadows. Depth comes from light.
- Don't stack two grid patterns on one page.
