---
name: 8-Bit Orbit
description: "Pixel-art neon arcade on a deep navy void, with hard 4px shadows, CRT scanlines and twinkling stars."
mode: dark
mood: [retro-tech, playful, cyberpunk, energetic]
tone: [geeky, neon, rebellious, sci-fi]
formality: low
density: medium
scheme: dark
best_for: "Anything that should feel like a CRT screen at 2am: cyberpunk, gaming, web3, indie dev tools, hackathon demos, synthwave brand decks, and tech talks leaning into nostalgic-digital craft."
avoid_for: "Contexts where the dark neon palette would actively work against the message — quiet institutional finance disclosures, healthcare patient-facing materials, traditional luxury."
source: bold:8-bit-orbit
---

# 8-Bit Orbit

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#0A0E27` | dark void, default surface |
| bg-alt | `#0F1B3D` | deep navy: shadows, pills, dark cards |
| text | `#FFFFFF` | on dark only, never a background |
| body | `rgba(255,255,255,0.7)` | body copy on dark |
| accent | `#5EDCF4` | neon cyan: headlines on dark, stats, brackets |
| pink | `#F0A6CA` | neon pink: surface, 2nd series, stat labels |
| yellow | `#F4D03F` | neon yellow: shadow halos, pill text, badges |
| lavender | `#E2D5F2` | pastel surface for calmer pages |
| muted | `#858793` | white 50% on void: counter total |
| body-light | `rgba(15,27,61,0.75)` | body copy on colored grounds |

## Typography

- Display: `Tektur, sans-serif` — 900 hero and stats, 700 headlines. Native or positive tracking only.
- Body: `"Chakra Petch", sans-serif` — 400 body, 500 quotes. Sentence case, no tracking, line-height ≥ 1.6.
- HUD: `"Space Mono", monospace` — always uppercase, 0.05–0.3em tracking; labels, pills, badges, counters, chart values.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Tektur:wght@700;900&family=Chakra+Petch:wght@400;500&family=Space+Mono:wght@400;700&display=swap`
- Type scale (source caps at web sizes, hero 128 / body 18; scaled up to slide-authoring's range):
  - Hero 144px / 900 / lh 1.05 / +0.04em · opener 96px · headline 64px / 700 / lh 1.15 · card title 40px
  - Stat 96px / 900 / lh 1 · lead 36px / lh 1.8 · quote 40px / 500 · body 32px / lh 1.7
  - Label pill 24px / 700 / 0.2em, every pill · badge, counter, chart text 22px / 0.1em
- CJK: one `"Noto Sans SC"` for all roles, tracking 0, no uppercase.

## Layout

- Padding 120px (usable 1680 × 840); body max-width 1200px; gaps 48 / 32 / 16px. Left-aligned; center only hero titles.
- The 4px pixel unit stays literal at 1920: borders 2/4px, shadow offsets 4/8px, 24px brackets, 40px grid. Type scales; pixel chrome does not.
- Surfaces alternate: void + cyan grid, or pink / cyan / lavender + navy grid.
- Z-order: surface, `<Starfield>` (1), content wrapper (`position: relative, zIndex: 10`), `<Footer>` (20), `<Atmosphere>` (49–51). Page root: `position: relative, cursor: crosshair`.

## Fixed components

### Title

```tsx
// Hero: cyan with the yellow→navy two-layer pixel shadow.
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: 'Tektur, sans-serif', fontSize: 144, fontWeight: 900, lineHeight: 1.05, letterSpacing: '0.04em', margin: 0, color: '#5EDCF4', textShadow: '4px 4px 0 #F4D03F, 8px 8px 0 #0F1B3D' }}>
    {children}
  </h1>
);
// Page headlines: same face at 700, 64px (96px openers), lh 1.15, no two-layer shadow;
// cyan on dark with textShadow '3px 3px 0 #0F1B3D', plain navy '#0F1B3D' on colored grids.
```

### Footer

Counter pill bottom-center; square pips on the right edge (drop past ~30 pages).

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    <>
      <div style={{ position: 'absolute', left: '50%', bottom: 40, transform: 'translateX(-50%)', zIndex: 20, padding: '8px 20px', background: 'rgba(15,27,61,0.8)', fontFamily: '"Space Mono", monospace', fontSize: 22, letterSpacing: '0.15em', color: '#5EDCF4' }}>
        {pad(current)} <span style={{ color: '#858793' }}>/ {pad(total)}</span>
      </div>
      <div style={{ position: 'absolute', right: 40, top: '50%', transform: 'translateY(-50%)', zIndex: 20, display: 'flex', flexDirection: 'column', gap: 12 }}>
        {Array.from({ length: total }, (_, i) => (
          <span key={i} style={{ width: 12, height: 12, boxSizing: 'border-box', border: '2px solid #5EDCF4', background: i + 1 === current ? '#5EDCF4' : 'transparent' }} />
        ))}
      </div>
    </>
  );
};
```

### Eyebrow / accents

```tsx
// Label pill, opening every region. Variants: color '#5EDCF4' or '#F0A6CA'.
const Eyebrow = ({ children, color = '#F4D03F' }: { children: React.ReactNode; color?: string }) => (
  <span style={{ alignSelf: 'flex-start', padding: '12px 28px', background: '#0F1B3D', color, fontFamily: '"Space Mono", monospace', fontSize: 24, fontWeight: 700, lineHeight: 1, letterSpacing: '0.2em', textTransform: 'uppercase' }}>
    {children}
  </span>
);
```

## Motion

- Philosophy: subtle. Only the atmosphere moves (stars twinkle, particles float); content stays still. Inject with the `<style>` pattern in `webfonts.md`.

```css
@keyframes twinkle { 0%, 100% { opacity: 1; } 50% { opacity: 0.2; } }
@keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-16px); } }
```

## Aesthetic

Retro-futuristic pixel art: an arcade cabinet crossed with a Tron-era boardroom, as if the deck just booted up. Everything snaps to a 4px unit — zero-blur shadows stepping down-right, L-brackets instead of outlines, square pips, a 40px grid, and a permanent scanline, grain and CRT-vignette overlay. Three neons glow against deep navy; lavender is the reprieve. Tektur shouts, Chakra Petch explains, Space Mono reads out like a HUD.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', cursor: 'crosshair', ...DARK_GRID, padding: 120, display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <Starfield />
    <div style={{ position: 'relative', zIndex: 10, display: 'flex', flexDirection: 'column', gap: 40 }}>
      <Eyebrow>Level 01 · Launch</Eyebrow>
      <Title>Press Start</Title>
      <p style={{ fontFamily: '"Chakra Petch", sans-serif', fontSize: 36, lineHeight: 1.8, color: 'rgba(255,255,255,0.7)', maxWidth: 1200, margin: 0 }}>
        A short tagline that explains what this deck is about.
      </p>
    </div>
    <Footer />
    <Atmosphere dark />
  </div>
);
```

## Signature elements

```tsx
// 40px etched grid. Colored: grid('#F0A6CA' | '#5EDCF4' | '#E2D5F2', 'rgba(15,27,61,0.08)').
const grid = (ground: string, line: string) => ({ backgroundColor: ground, backgroundImage: `linear-gradient(${line} 1px, transparent 1px), linear-gradient(90deg, ${line} 1px, transparent 1px)`, backgroundSize: '40px 40px' });
const DARK_GRID = grid('#0A0E27', 'rgba(94,220,244,0.07)');

// Grain + scanlines on every page, CRT vignette on dark ones. Always the last child.
const GRAIN = `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='240' height='240'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='3'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E")`;
const Atmosphere = ({ dark = false }: { dark?: boolean }) => {
  const o = { position: 'absolute', inset: 0, pointerEvents: 'none' } as const;
  return (
    <>
      <div aria-hidden style={{ ...o, zIndex: 49, opacity: 0.035, backgroundImage: GRAIN }} />
      <div aria-hidden style={{ ...o, zIndex: 50, mixBlendMode: 'multiply', background: 'repeating-linear-gradient(0deg, transparent 0 2px, rgba(10,14,39,0.04) 2px 4px)' }} />
      {dark && <div aria-hidden style={{ ...o, zIndex: 51, background: 'radial-gradient(ellipse at center, transparent 50%, rgba(10,14,39,0.25) 100%)' }} />}
    </>
  );
};

// Stars: zero-blur box-shadow copies of one square, dark surfaces only.
// Particles: <Pixels size={8} anim="float 8s ease-in-out infinite" at="…" />
const Pixels = ({ at, size = 4, anim = 'twinkle 3s ease-in-out infinite' }: { at: string; size?: number; anim?: string }) => (
  <div aria-hidden style={{ position: 'absolute', top: 0, left: 0, width: size, height: size, zIndex: 1, boxShadow: at, animation: anim }} />
);
const Starfield = () => (
  <>
    <Pixels at="212px 148px #5EDCF4, 1540px 96px #5EDCF4, 1764px 620px #5EDCF4, 312px 880px #5EDCF4" />
    <Pixels anim="twinkle 3s ease-in-out 1s infinite" at="640px 72px #F4D03F, 1360px 404px #F4D03F, 96px 516px #F4D03F" />
    <Pixels anim="twinkle 3s ease-in-out 2s infinite" at="1836px 272px #F0A6CA, 520px 992px #F0A6CA" />
  </>
);

// L-brackets at opposite corners replace outlines; parent is position: relative.
// offset -2 breaks a card edge; -8 brackets a free region.
const Brackets = ({ color = '#5EDCF4', offset = -2 }: { color?: string; offset?: number }) => {
  const b = `4px solid ${color}`;
  const s = { position: 'absolute', width: 24, height: 24, boxSizing: 'border-box' } as const;
  return (
    <>
      <span aria-hidden style={{ ...s, top: offset, left: offset, borderTop: b, borderLeft: b }} />
      <span aria-hidden style={{ ...s, bottom: offset, right: offset, borderBottom: b, borderRight: b }} />
    </>
  );
};

// Stat tile: cyan glass, brackets, shadowed numeral, pink mono label.
const StatBlock = ({ value, label }: { value: string; label: string }) => (
  <div style={{ position: 'relative', padding: '48px 32px', background: 'rgba(94,220,244,0.08)', border: '2px solid rgba(94,220,244,0.2)' }}>
    <Brackets />
    <div style={{ fontFamily: 'Tektur, sans-serif', fontSize: 96, fontWeight: 900, lineHeight: 1, color: '#5EDCF4', textShadow: '3px 3px 0 #0F1B3D' }}>{value}</div>
    <div style={{ marginTop: 16, fontFamily: '"Space Mono", monospace', fontSize: 22, letterSpacing: '0.1em', textTransform: 'uppercase', color: '#F0A6CA' }}>{label}</div>
  </div>
);

// BEVEL: six-step CTA shadow on a cyan block with navy Tektur text (pink block takes a cyan halo).
// PIXEL_L: chart bars, filled cyan → pink → yellow. Hero badges: 2px yellow outline, 22px yellow mono.
const BEVEL = '4px 0 #0F1B3D, 0 4px #0F1B3D, 4px 4px #0F1B3D, 8px 4px #F4D03F, 4px 8px #F4D03F, 8px 8px #F4D03F';
const PIXEL_L = '4px 0 #0F1B3D, 0 4px #0F1B3D, 4px 4px #0F1B3D';
const QuoteLine = () => <div style={{ width: 60, height: 4, background: '#F4D03F', boxShadow: '4px 4px 0 #0F1B3D' }} />;
```

## Do / Don't

- Do put `<Atmosphere>` and the grid on every page, charts included; bare surfaces read as wireframes.
- Do alternate the void with pink, cyan and lavender grids; on those, text goes navy.
- Do shadow every Title yellow→navy and every stat numeral 3px navy.
- Do open regions with the label pill; bracket cards at opposite corners, never full outlines.
- Do give every region one neon; pure navy reads as a dead screen.
- Do draw timelines as 24px square nodes (4px navy border, yellow = active) on a dashed navy rail.
- Don't substitute or cross the three faces (no Tektur body, no Chakra Petch chrome).
- Don't round a corner or blur a shadow; shadows step down-right in 4px units.
- Don't put neon text on a neon ground, or neon on body copy.
- Don't add a fourth neon (no green, no orange) or any italics.
