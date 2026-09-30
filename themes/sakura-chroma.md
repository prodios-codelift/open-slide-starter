---
name: Sakura Chroma
description: "Warm cream cassette-package catalogue: condensed 900-weight display type, ink structure, and a six-color primary ribbon-and-petal system."
mode: light
mood: [retro, playful, kawaii-tech, warm, tactile]
tone: [playful, confident, warm, tactile, 80s-Japanese-tech]
formality: low
density: medium
scheme: light
best_for: "Indie hardware and music-label decks, analog-studio retrospectives, zine pitches, and kawaii-tech product launches wanting bold color and tactile printed-product personality."
avoid_for: "Restrained or quiet corporate/legal/academic contexts — the condensed lockups, ribbon stripes, and primary palette are intentionally loud."
source: bold:sakura-chroma
---

# Sakura Chroma

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F1E6CB` | warm cream paper — every slide's canvas |
| bg-alt | `#E5D6B0` | darker paper tone for layered surfaces |
| text | `#3A2516` | warm-brown ink — all copy, borders, rules, shadows |
| accent | `#E5392A` | red — inline emphasis, stamps, hero numerals |
| muted | `rgba(58,37,22,0.7)` | de-emphasized mono labels and secondary copy |
| hairline | `rgba(58,37,22,0.22)` | 1px body dividers, off-state equalizer tint |
| pink | `#E54489` | ribbon / chip / topstrip accent |
| orange | `#F09131` | ribbon / petal / topstrip accent |
| yellow | `#F0BC2A` | ribbon / petal accent |
| green | `#3D9F47` | ribbon / petal / chip accent |
| blue | `#3F8BC4` | ribbon / petal / topstrip accent, paired hero stat |

## Typography

- Display font: `"Big Shoulders Display", sans-serif` — weight 900 (700 only for the ledger-row-title sub-moment), tight negative tracking -0.012em to -0.025em on every use. Carries every headline, numeral, brand lockup, seal and stamp text.
- Body font: `"Albert Sans", sans-serif` — weight 400 for paragraphs, 700 uppercase (0.16–0.2em tracking) for micro-labels/eyebrows, 600 for emphasis body.
- Mono font: `"JetBrains Mono", ui-monospace, monospace` — weight 400, spec rows / dates / chips / page numbers. Any "data" moment.
- Japanese accent (occasional only, e.g. 限定版): `"Noto Sans JP", sans-serif` weight 500.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Big+Shoulders+Display:wght@700;900&family=Albert+Sans:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&family=Noto+Sans+JP:wght@500;700&display=swap`
- Type scale (converted from the source's `clamp()`/`vw` system at 1920×1080):
  - Cover hero: 190px, weight 900, line-height 0.86, letter-spacing -0.022em
  - Section/topbar heading: 90px, weight 900, line-height 0.9, letter-spacing -0.018em
  - Hero statistic: 170px, weight 900, always `accent` (pair with `blue` for a second stat)
  - Body: 34px, weight 400, line-height 1.5
  - Micro-label / eyebrow: 22px, Albert Sans 700, uppercase, 0.18em tracking
  - Mono spec / page number: 20px / 13px, JetBrains Mono 400

## Layout

- Content padding: 72px top/left/right, 110px bottom (clears the page number) at 1920×1080 — the "frame inset" pattern.
- Most content pages: a topbar (section heading left + tracked mono label right, divided by a 1.5px ink rule) above a body region.
- Cover, manifesto and quote pages break the frame — petals, ribbons and hero numerals layer freely, edge to edge.
- Density is medium-high: pack concurrent regions (topbar + primary visual + secondary panel) on content pages; reserve a single centered statement for manifesto moments only.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Big Shoulders Display", sans-serif', fontSize: 190, fontWeight: 900, lineHeight: 0.86, letterSpacing: '-0.022em', margin: 0, color: '#3A2516' }}>
    {children}
  </h1>
);

// Inline emphasis: color shift only, never italic. Red is default; use blue when red is already in play.
const Em = ({ children, color = '#E5392A' }: { children: React.ReactNode; color?: string }) => (
  <em style={{ fontStyle: 'normal', color }}>{children}</em>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 72, right: 72, bottom: 40, display: 'flex', justifyContent: 'space-between', alignItems: 'center', paddingTop: 14, borderTop: '1.5px solid #3A2516', fontFamily: '"JetBrains Mono", ui-monospace, monospace', fontSize: 13, color: '#3A2516', letterSpacing: '0.06em' }}>
      <span style={{ textTransform: 'uppercase', fontWeight: 700 }}>Sakura Chroma</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Albert Sans", sans-serif', fontSize: 22, fontWeight: 700, letterSpacing: '0.18em', textTransform: 'uppercase', color: '#3A2516' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Pages cross-fade 280ms ease (the source's native transition); nothing else animates except a soft settle on the cover's stamp.
- Keyframe:

```css
@keyframes stampIn {
  from { opacity: 0; transform: rotate(-3deg) scale(0.9); }
  to   { opacity: 1; transform: rotate(-3deg) scale(1); }
}
```

## Aesthetic

Sakura Chroma treats every slide as a page from a 1970s Japanese audio-products catalogue: warm cream paper, deep warm-brown ink structure, six unapologetic primaries doing categorical work across petals, ribbons, chips and stamps. Big Shoulders Display 900 with negative tracking gives every headline a compressed, industrial-catalogue voice; Albert Sans carries quiet body copy; JetBrains Mono marks anything that should read as data. Depth comes from hard 8px ink offset shadows and border definition, never blur. The 4px halftone paper-grain texture is required on every slide, not optional — it is the print register the whole system depends on.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#F1E6CB', color: '#3A2516', position: 'relative', display: 'flex', flexDirection: 'column', justifyContent: 'center', padding: '0 72px', overflow: 'hidden' }}>
    <PaperTexture />
    <PetalCluster style={{ position: 'absolute', top: 64, right: 96, width: 220, height: 180 }} />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 28, maxWidth: 1400 }}>
      <Eyebrow>Catalogue · 2026</Eyebrow>
      <Title>
        The Big <Em>Idea</Em>
      </Title>
      <p style={{ fontFamily: '"Albert Sans", sans-serif', fontSize: 34, lineHeight: 1.5, color: 'rgba(58,37,22,0.7)', maxWidth: 1100, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Required on every slide, 16% opacity.
const PaperTexture = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', zIndex: 1, opacity: 0.16, backgroundImage: 'radial-gradient(circle at 1px 1px, rgba(58,37,22,0.55) 1px, transparent 1.6px)', backgroundSize: '4px 4px' }} />
);

// 4–5 overlapping circles in mixed primaries — signature decorative anchor.
const PetalCluster = ({ style }: { style?: React.CSSProperties }) => (
  <div style={{ position: 'relative', ...style }} aria-hidden>
    <div style={{ position: 'absolute', width: '58%', aspectRatio: '1/1', borderRadius: '50%', background: '#E54489', top: 0, left: 0 }} />
    <div style={{ position: 'absolute', width: '50%', aspectRatio: '1/1', borderRadius: '50%', background: '#F09131', top: '10%', left: '40%' }} />
    <div style={{ position: 'absolute', width: '46%', aspectRatio: '1/1', borderRadius: '50%', background: '#3F8BC4', top: '38%', left: '4%' }} />
    <div style={{ position: 'absolute', width: '42%', aspectRatio: '1/1', borderRadius: '50%', background: '#F0BC2A', top: '46%', left: '48%' }} />
  </div>
);

// 5 stacked bars swept ±22deg, edge-anchored and bled off the other side. Cover/closer only.
const RibbonBand = ({ rotate = -22 }: { rotate?: number }) => (
  <div aria-hidden style={{ position: 'absolute', left: '-30%', width: '160%', height: '90%', top: '5%', transform: `rotate(${rotate}deg)`, display: 'flex', flexDirection: 'column', gap: 6, pointerEvents: 'none' }}>
    {['#E54489', '#F09131', '#F0BC2A', '#3D9F47', '#3F8BC4'].map((c) => (
      <div key={c} style={{ flex: 1, background: c }} />
    ))}
  </div>
);

// 12-point starburst — ink fill, cream text, 1-4 char glyph. Authority mark.
const RosetteSeal = ({ children }: { children: React.ReactNode }) => (
  <div style={{ width: 110, aspectRatio: '1/1', background: '#3A2516', color: '#F1E6CB', display: 'flex', alignItems: 'center', justifyContent: 'center', clipPath: 'polygon(50% 0%, 58.3% 19.1%, 75% 6.7%, 72.6% 27.4%, 93.3% 25%, 80.9% 41.7%, 100% 50%, 80.9% 58.3%, 93.3% 75%, 72.6% 72.6%, 75% 93.3%, 58.3% 80.9%, 50% 100%, 41.7% 80.9%, 25% 93.3%, 27.4% 72.6%, 6.7% 75%, 19.1% 58.3%, 0% 50%, 19.1% 41.7%, 6.7% 25%, 27.4% 27.4%, 25% 6.7%, 41.7% 19.1%)', fontFamily: '"Big Shoulders Display", sans-serif', fontWeight: 900, fontSize: 28 }}>
    {children}
  </div>
);

// Red stamp, optional -3deg rotation. Status badges, product callouts.
const RedStamp = ({ children, rotate = -3 }: { children: React.ReactNode; rotate?: number }) => (
  <div style={{ display: 'inline-block', background: '#E5392A', color: '#F1E6CB', padding: '10px 18px', transform: `rotate(${rotate}deg)`, fontFamily: '"Big Shoulders Display", sans-serif', fontWeight: 900, fontSize: 22, textTransform: 'uppercase', letterSpacing: '0.02em' }}>
    {children}
  </div>
);

// Ink-bordered checkbox row — JIS-style spec checklist.
const SpecRow = ({ label, checked }: { label: string; checked?: boolean }) => (
  <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
    <div style={{ width: 18, height: 18, border: '2px solid #3A2516', background: checked ? '#3A2516' : 'transparent', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#F1E6CB', fontFamily: '"Big Shoulders Display", sans-serif', fontWeight: 900, fontSize: 14 }}>
      {checked ? '×' : ''}
    </div>
    <span style={{ fontFamily: '"Albert Sans", sans-serif', fontSize: 20, fontWeight: 700, letterSpacing: '0.04em' }}>{label}</span>
  </div>
);
```

## Do / Don't

- Do keep the halftone paper-grain texture on every slide at 16% opacity — it is the required print register.
- Do use Big Shoulders Display 900 with negative tracking for every display moment; never for body copy.
- Do reserve `Em`'s color shift (red default, blue when red is overloaded) for inline emphasis — never italicize.
- Do keep borders and shadows ink-only — 1.5px borders for definition, one 8px hard offset shadow (no blur) for lifted callouts.
- Don't round any corner except petals (circles) and the starburst seal.
- Don't introduce a seventh accent color or use a soft blurred `box-shadow` — both break the print register.
