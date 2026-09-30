---
name: Daisy Days
description: "Cheerful pastel storybook deck: chunky Fredoka headlines, charcoal-outlined stickers with hard offset shadows, and hand-drawn daisies, stars and rainbows."
mode: light
mood: [cheerful, playful, warm, sunny]
tone: [friendly, soft, encouraging, approachable]
formality: low
density: medium
scheme: light
best_for: "Friendly, soft, joyful decks: education, kids and family, wellness, community workshops, craft portfolios, or a playful internal kickoff."
avoid_for: "Audiences that expect authority and precision; the hand-drawn pastel stickers are the opposite of buttoned-up."
source: bold:daisy-days
---

# Daisy Days

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F5F0E6` | cream paper: default canvas, covers, content pages |
| text | `#2D2D2D` | charcoal: text, every border, shadow and stroke |
| accent | `#F8635F` | coral: small markers only (step numbers, dots), never a surface |
| muted | `#6B6B6B` | subtitles, captions, role labels; on cream or white only |
| surface | `#FFFFFF` | every card, avatar, counter pill, on any background |
| butter | `#FDE68A` | badge fill, bullet discs, daisy centres, sun |
| turquoise | `#7ECDC0` | boldest surface pastel |
| soft-pink | `#F7C8D4` | surface, header caps, quote mark |
| mint | `#A8E6CF` | surface, caps, icon fills |
| lavender | `#D4A5E8` | surface, caps, markers |
| peach | `#FFCBA4` | surface, process pages |
| sky | `#A8D8F0` | surface, cloud shading |

Pastels carry no meaning. Sequences rotate coral → mint → sky → lavender → butter.

## Typography

- Display font: `"Fredoka One", "Arial Rounded MT Bold", system-ui, sans-serif`, single weight 400 (reads heavy). Every headline, title, numeral, badge and quote. No italic, no underline.
- Body font: `"Quicksand", system-ui, sans-serif`, 500 body, 600 emphasis and meta, 700 only for quote attribution. Never uppercase; letter-spacing 0.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Fredoka+One&family=Quicksand:wght@500;600;700&display=swap`
- Type scale (source `clamp()` maxima scaled into the canvas ranges):
  - Hero: 144px, lh 1.1, 0.02em (`Title` default)
  - Headline: 96px · section / framed-card title: 64px · in-card title: 44px
  - Quote: 52px, lh 1.35, under a 140px soft-pink `“`
  - Label (step title, day header): 32px Fredoka
  - Body: 34px Quicksand 500, lh 1.6; emphasised lists 600
  - Meta / caption: 26px Quicksand 600, lh 1.45, muted · badge and footer pill: 26px Fredoka
- The split is strict: Fredoka for display, Quicksand for running text. CJK: add ZCOOL XiaoWei / Yozai after each stack, tracking 0, lh 1.75, no uppercase.

## Layout

- Content padding: 120px top/bottom, 160px left/right (1920×1080).
- Content flex-centred both ways, max-width 1000–1500px; the edges belong to the stickers.
- One main container per page (a `Card`, a `FramedCard`, or one grid of small cards) wreathed by 3–7 stickers at the corners, often cropping past the edge. An empty corner reads as broken.
- Layers: surface, stickers (`zIndex: 1`), content (`position: 'relative', zIndex: 2`), `Footer`.
- Surfaces rotate per page: cream by default, any pastel full-bleed (never coral). Cards stay white on every surface.
- Radii: 28px cards, 40px featured cards, 9999px pills, 50% circles, 6px legend swatches. No square corners. Gaps 40 / 32 / 20px.
- Source strokes scaled for the canvas: 3px outline → 4px (small elements 3px); 6px / 4px shadows → 8px / 6px.

## Fixed components

### Title

```tsx
// Cream/white: flat. Pastel surface: shadow 'hard' (turquoise, butter, peach) or 'soft' (pink, mint, lavender, sky), text turns white.
const Title = ({ children, size = 144, shadow }: { children: React.ReactNode; size?: number; shadow?: 'hard' | 'soft' }) => (
  <h1 style={{ fontFamily: '"Fredoka One", "Arial Rounded MT Bold", system-ui, sans-serif', fontSize: size, fontWeight: 400, lineHeight: 1.1, letterSpacing: '0.02em', margin: 0, color: shadow ? '#FFFFFF' : '#2D2D2D', textShadow: shadow ? `4px 4px 0 ${shadow === 'hard' ? '#2D2D2D' : 'rgba(0,0,0,0.2)'}` : 'none' }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Bottom-centre counter pill.
const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: '50%', bottom: 48, transform: 'translateX(-50%)', zIndex: 2, padding: '10px 32px', borderRadius: 9999, border: '4px solid #2D2D2D', background: '#FFFFFF', boxShadow: '6px 6px 0 #2D2D2D', fontFamily: '"Fredoka One", "Arial Rounded MT Bold", system-ui, sans-serif', fontSize: 26, lineHeight: 1.2, letterSpacing: '0.02em', whiteSpace: 'nowrap', color: '#2D2D2D' }}>
      {current} / {total}
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Badge pill: butter by default, any pastel allowed.
const Eyebrow = ({ children, fill = '#FDE68A' }: { children: React.ReactNode; fill?: string }) => (
  <div style={{ padding: '12px 32px', borderRadius: 9999, border: '4px solid #2D2D2D', background: fill, boxShadow: '6px 6px 0 #2D2D2D', fontFamily: '"Fredoka One", "Arial Rounded MT Bold", system-ui, sans-serif', fontSize: 26, lineHeight: 1.2, letterSpacing: '0.02em', whiteSpace: 'nowrap', color: '#2D2D2D' }}>
    {children}
  </div>
);

// List item with an outlined disc bullet, never a glyph.
const Bullet = ({ children, fill = '#FDE68A' }: { children: React.ReactNode; fill?: string }) => (
  <div style={{ display: 'flex', gap: 24, fontFamily: '"Quicksand", system-ui, sans-serif', fontSize: 34, fontWeight: 600, lineHeight: 1.5, color: '#2D2D2D' }}>
    <span style={{ flex: 'none', width: 30, height: 30, marginTop: 11, borderRadius: '50%', border: '3px solid #2D2D2D', background: fill }} />
    {children}
  </div>
);
```

## Motion

- Philosophy: static. The stickers carry the charm; pages cut, or take at most a 240ms fade. Nothing bounces or spins.

## Aesthetic

A picture-book spread crossed with a kawaii sticker sheet. Cream paper holds chunky Fredoka headlines and friendly Quicksand text; every card, badge and marker is a pastel or white shape in a thick charcoal outline, lifted by a solid offset shadow like a sticker on the page. Hand-drawn daisies, stars, suns, clouds and rainbows cluster at the corners and crop off the edges. Sunny and wholesome, one clear subject per page. No gradients, glows, glass, blurred shadows, coloured borders, or square corners.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#F5F0E6', color: '#2D2D2D', padding: '120px 160px', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', textAlign: 'center' }}>
    <Daisy size={220} style={{ top: -40, left: -30 }} />
    <Star size={90} fill="#F7C8D4" style={{ top: 170, left: 210 }} />
    <Sun size={200} style={{ top: 40, right: 60 }} />
    <Star size={70} fill="#A8E6CF" style={{ top: 250, right: 290 }} />
    <Cloud size={220} style={{ bottom: 190, right: 150 }} />
    <Rainbow size={300} style={{ bottom: 40, left: 60 }} />
    <Daisy size={180} style={{ bottom: -30, right: -20 }} />
    <div style={{ position: 'relative', zIndex: 2, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 40, maxWidth: 1400 }}>
      <Eyebrow>Spring Workshop · 2026</Eyebrow>
      <Title>The Big Idea</Title>
      <p style={{ fontFamily: '"Quicksand", system-ui, sans-serif', fontSize: 36, fontWeight: 500, lineHeight: 1.5, color: '#6B6B6B', maxWidth: 1100, margin: 0 }}>A short subtitle that explains what this deck is about.</p>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Sticker layer: behind content, may crop past the edge (data-bleed). Height follows the viewBox.
type S = { size: number; style: React.CSSProperties };
const Sticker = ({ size, vb = '-50 -50 100 100', style, children }: S & { vb?: string; children: React.ReactNode }) => (
  <svg aria-hidden data-bleed viewBox={vb} width={size} fill="none" stroke="#2D2D2D" strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round" style={{ position: 'absolute', zIndex: 1, pointerEvents: 'none', overflow: 'visible', ...style }}>
    {children}
  </svg>
);

const Daisy = (p: S) => (
  <Sticker {...p}>
    {[0, 60, 120, 180, 240, 300].map((r) => <ellipse key={r} cy={-27} rx={13} ry={21} fill="#FFFFFF" transform={`rotate(${r})`} />)}
    <circle r={16} fill="#FDE68A" />
  </Sticker>
);

// Vary fills across one page; never all white or all yellow.
const Star = ({ fill = '#FDE68A', ...p }: S & { fill?: string }) => (
  <Sticker {...p}><path d="M0-46 14-19 44-14 23 7 27 37 0 24-27 37-23 7-44-14-14-19Z" fill={fill} strokeWidth={3.5} /></Sticker>
);

const Sun = (p: S) => (
  <Sticker {...p}>
    <path d="M0-36V-47M0 36V47M-36 0H-47M36 0H47M25-25 33-33M-25-25-33-33M25 25 33 33M-25 25-33 33" strokeWidth={4} />
    <circle r={27} fill="#FDE68A" />
    <path d="M-10 5Q0 15 10 5" />
    <circle cx={-9} cy={-6} r={2} fill="#2D2D2D" />
    <circle cx={9} cy={-6} r={2} fill="#2D2D2D" />
  </Sticker>
);

const Cloud = (p: S) => (
  <Sticker vb="0 0 120 72" {...p}>
    <path d="M25 62A16 16 0 0 1 25 30A22 22 0 0 1 66 20A18 18 0 0 1 96 36A13 13 0 0 1 96 62Z" fill="#FFFFFF" />
    <path d="M38 52H84" stroke="#A8D8F0" strokeWidth={5} />
  </Sticker>
);

const Rainbow = (p: S) => (
  <Sticker vb="-58 -58 116 60" {...p}>
    <g strokeWidth={10} strokeLinecap="butt">
      <path d="M-50 0A50 50 0 0 1 50 0" stroke="#F8635F" />
      <path d="M-40 0A40 40 0 0 1 40 0" stroke="#FDE68A" />
      <path d="M-30 0A30 30 0 0 1 30 0" stroke="#A8E6CF" />
      <path d="M-20 0A20 20 0 0 1 20 0" stroke="#A8D8F0" />
    </g>
    <path d="M-55 0A55 55 0 0 1 55 0H15A15 15 0 0 0-15 0Z" />
  </Sticker>
);

// The page's one main container. Featured variant: borderRadius 40.
const Card = ({ children, style }: { children: React.ReactNode; style?: React.CSSProperties }) => (
  <div style={{ background: '#FFFFFF', border: '4px solid #2D2D2D', borderRadius: 28, boxShadow: '8px 8px 0 #2D2D2D', padding: '48px 56px', ...style }}>{children}</div>
);

// Pastel cap over a white body: one outline, one shadow.
const FramedCard = ({ title, cap = '#A8E6CF', children }: { title: string; cap?: string; children: React.ReactNode }) => (
  <div style={{ background: '#FFFFFF', border: '4px solid #2D2D2D', borderRadius: 40, boxShadow: '8px 8px 0 #2D2D2D', overflow: 'hidden' }}>
    <div style={{ background: cap, borderBottom: '4px solid #2D2D2D', padding: '24px 56px', fontFamily: '"Fredoka One", system-ui, sans-serif', fontSize: 64, lineHeight: 1.15 }}>{title}</div>
    <div style={{ padding: '40px 56px', fontFamily: '"Quicksand", system-ui, sans-serif', fontSize: 34, fontWeight: 500, lineHeight: 1.6 }}>{children}</div>
  </div>
);

// Numbered step / timeline marker. Rotate fills; numeral goes dark on butter.
const Marker = ({ n, fill = '#F8635F', size = 96 }: { n: string; fill?: string; size?: number }) => (
  <div style={{ flex: 'none', width: size, height: size, borderRadius: '50%', border: '4px solid #2D2D2D', background: fill, boxShadow: '6px 6px 0 #2D2D2D', display: 'flex', alignItems: 'center', justifyContent: 'center', fontFamily: '"Fredoka One", system-ui, sans-serif', fontSize: size * 0.46, color: fill === '#FDE68A' ? '#2D2D2D' : '#FFFFFF', textShadow: fill === '#FDE68A' ? 'none' : '3px 3px 0 #2D2D2D' }}>{n}</div>
);
```

## Do / Don't

- Do outline every container, badge and marker in 4px charcoal and lift it with a solid charcoal offset (8px cards, 6px small).
- Do wreath every page with 3–7 stickers (two daisies plus 2–3 stars is the classic cluster), cropping off the corners.
- Do keep cards white on every surface, and headlines white with a text-shadow on pastel surfaces.
- Do open quotes with a 140px soft-pink Fredoka `“`, and put `→` (Fredoka, 64px) between process steps.
- Don't use coral as a surface, card or headline colour.
- Don't blur, tint or soften a box shadow; don't colour or dash a border.
- Don't add a third font, a ninth colour, or new ornament styles (line-art arrows, photo cut-outs).
- Don't stack competing panels.
