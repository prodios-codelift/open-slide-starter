---
name: Pin & Paper
description: "Yellow legal-pad paper with a fractal grain, cobalt-ink Space Grotesk, Caveat margin notes and hand-drawn safety pins."
mode: light
mood: [crafted, handmade, warm, thoughtful]
tone: [literary, intimate, warm, grounded]
formality: medium
density: medium
scheme: light
best_for: "Qualitative research findings, founder reflections, longform brand stories and workshop debriefs that want warmth and personality over polish."
avoid_for: "Decks that need to feel digital-native polished or rigorously data-driven; the handwritten Caveat is intentionally informal."
source: bold:pin-and-paper
---

# Pin & Paper

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#EFE56A` | paper yellow, every page (via `PAPER_BG` + `Grain`) |
| text | `#1F3A8A` | cobalt ink: text, borders, pins, offset shadows |
| accent | `#C2342B` | cinnabar: stamp and no-pill only |
| muted | `#5D6D80` | ink at ~70% on paper: chrome, footer |
| card | `#F8F1D6` | cream, the default card fill |
| paper-2 | `#F5ECA0` | alternate card fill |
| paper-3 | `#E8D85A` | "deep" page variant |
| paper-extra | `#FBE6A4` | the tilted card's fill |
| ink-soft | `#2D4FB8` | chart second series |
| rule | `rgba(31,58,138,0.45)` | dashed separators |

## Typography

- Display + body: `"Space Grotesk", "Helvetica Neue", Arial, sans-serif`. 700 headlines (mixed case, negative tracking), 500 quotes, 400 body. The printed voice.
- Script: `"Caveat", cursive` 600–700. Margin notes, numerals, pills. The handwritten voice; ink on paper, yellow on ink.
- Mono: `"DM Mono", ui-monospace, monospace` 500, uppercase, 0.12–0.22em. Chrome, eyebrows, stamps. The archival voice.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;700&family=Caveat:wght@600;700&family=DM+Mono:wght@500&display=swap`
- Type scale (source px at 1920; body and labels raised to slide-authoring's floors):
  - Cover hero 196px, lh 1.04, -0.04em · section (ink page) and stat 168px (stat lh 0.85)
  - Page heading 96px (`Title` default), lh 1.05, -0.03em · dense 84px · card heading 44px, -0.02em
  - Quote 56px SG 500 · body 30px, lh 1.45 · card body 28px
  - Caveat: margin note 44px · step numeral 72px 700 · decorative quote mark 360px
  - Mono: eyebrow / chrome / footer / stamp 22px
- CJK: Long Cang for display and script, LXGW WenKai for body; no tracking or uppercase on CJK.

## Layout

- Edges 64px left/right. Top chrome at top 44, footer at bottom 36; content between y 110 and 950.
- Content pages: 96px heading top-left, then 3–6 pinned cards (gaps 22–32px). A populated notebook page, never one lone headline.
- Cover and section pages: oversized type, two large pins, one Caveat margin note.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 96 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Space Grotesk", "Helvetica Neue", Arial, sans-serif', fontSize: size, fontWeight: 700, lineHeight: size >= 150 ? 1.04 : 1.05, letterSpacing: size >= 150 ? '-0.04em' : '-0.03em', margin: 0, color: '#1F3A8A' }}>
    {children}
  </h1>
);
```

### Footer

Pass real chrome (source, office, presenter) as `label`. `ink` flips it for ink pages.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ label, ink = false }: { label?: string; ink?: boolean }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 64, right: 64, bottom: 36, display: 'flex', justifyContent: 'space-between', fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, letterSpacing: '0.14em', textTransform: 'uppercase', color: ink ? '#EFE56A' : '#5D6D80', opacity: ink ? 0.75 : 1 }}>
      <span>{label}</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, letterSpacing: '0.22em', textTransform: 'uppercase', color: '#1F3A8A', opacity: 0.85 }}>
    {children}
  </div>
);

// Brand glyph for the top-chrome lockup.
const Mark = () => (
  <svg aria-hidden viewBox="0 0 32 16" style={{ width: 40, height: 20 }} fill="none" stroke="currentColor" strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
    <circle cx="26" cy="8" r="5" />
    <path d="M21 8H6M6 5L3 8L6 11" />
  </svg>
);

// Content-page top band: lockup left, meta right. Covers skip it.
const TopChrome = ({ brand, meta }: { brand: string; meta?: React.ReactNode }) => (
  <div style={{ position: 'absolute', top: 44, left: 64, right: 64, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"DM Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, letterSpacing: '0.12em', textTransform: 'uppercase', lineHeight: 1, color: '#1F3A8A' }}>
    <span style={{ display: 'flex', alignItems: 'center', gap: 14 }}><Mark />{brand}</span>
    <span style={{ opacity: 0.7 }}>{meta}</span>
  </div>
);
```

## Motion

- Philosophy: static. Paper, pins and cards are printed matter; pages cut, or take a plain 240ms opacity fade.

## Aesthetic

A field notebook pinned to a corkboard: yellow legal-pad paper under raking light, written in deep cobalt ink. Every page is paper with a soft highlight, a soft shadow and a fractal grain; without the grain it collapses into flat cartoon yellow. Cream cards with a 1.5px ink border, 4px corners and a hard ink offset shadow are pinned to it by hand-drawn safety pins, always tilted. Three voices never swap lanes: Space Grotesk is the printed notice, Caveat the note in the margin, DM Mono the archive tag. Red appears only as a rubber stamp. No blurred shadows, no radius over 4px, no italics, no yellow card on yellow paper.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: PAPER_BG, color: '#1F3A8A', fontFamily: '"Space Grotesk", "Helvetica Neue", Arial, sans-serif' }}>
    <Grain />
    <Pin width={420} rotate={-8} style={{ top: 130, right: 80 }} />
    <Pin open width={360} rotate={14} style={{ bottom: 200, right: 140 }} />
    <Scribble style={{ position: 'absolute', right: 80, bottom: 360, textAlign: 'right', transformOrigin: 'right bottom' }}>
      <Underline>For:</Underline> the room.<br />Two pages. One ask.
    </Scribble>
    <div style={{ position: 'absolute', inset: 0, padding: '110px 64px 130px', display: 'flex', flexDirection: 'column' }}>
      <Eyebrow>A field guide · Vol. I</Eyebrow>
      <div style={{ flex: 1, display: 'flex', alignItems: 'center', maxWidth: 1300 }}>
        <Title size={196}>Kept things</Title>
      </div>
    </div>
    <Footer label="Presented by A. Speaker" />
  </div>
);
```

## Signature elements

```tsx
// Page surface: highlight top-left, shadow bottom-right. Ink pages: INK_BG, text #EFE56A.
const PAPER_BG = 'radial-gradient(120% 90% at 20% 10%, rgba(255,255,255,.18), transparent 60%), radial-gradient(140% 100% at 80% 95%, rgba(0,0,0,.05), transparent 55%), #EFE56A';
const INK_BG = 'radial-gradient(120% 90% at 20% 10%, rgba(255,255,255,.06), transparent 60%), #1F3A8A';

// Fractal paper grain. Non-optional on every page; ink pages pass `ink` (screen, 0.25).
const GRAIN = `url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='240' height='240'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='1.4' numOctaves='2' stitchTiles='stitch'/><feColorMatrix values='0 0 0 0 0.5 0 0 0 0 0.45 0 0 0 0 0.2 0 0 0 .25 0'/></filter><rect width='100%25' height='100%25' filter='url(%23n)'/></svg>")`;
const Grain = ({ ink = false }: { ink?: boolean }) => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', backgroundImage: GRAIN, opacity: ink ? 0.25 : 0.35, mixBlendMode: ink ? 'screen' : 'multiply' }} />
);

// Hand-drawn safety pin, always off-axis (-14 to +20deg). 360–640px decoration; 120px on a card.
const Pin = ({ open = false, width = 360, rotate = -8, color = '#1F3A8A', style }: { open?: boolean; width?: number; rotate?: number; color?: string; style?: React.CSSProperties }) => (
  <svg aria-hidden viewBox={open ? '0 0 360 130' : '0 0 360 110'} style={{ position: 'absolute', width, color, transform: `rotate(${rotate}deg)`, pointerEvents: 'none', ...style }} fill="none" stroke="currentColor" strokeWidth={5} strokeLinecap="round" strokeLinejoin="round">
    {open ? (
      <>
        <path d="M312 48C296 42 290 60 304 68C320 76 340 70 342 54C344 38 322 28 300 34C240 24 140 24 70 40" />
        <path d="M312 66C250 90 150 96 80 86L24 78L38 70M24 78L38 88" />
        <ellipse cx="82" cy="32" rx="22" ry="12" transform="rotate(-18 82 32)" />
      </>
    ) : (
      <>
        <path d="M312 38C296 32 290 50 304 58C320 66 340 60 342 44C344 28 322 18 300 24C240 14 140 14 70 30" />
        <path d="M312 56C250 78 150 82 80 70" />
        <ellipse cx="58" cy="50" rx="24" ry="14" />
      </>
    )}
  </svg>
);

// Pinned card. Alternate fills #F5ECA0 / #FBE6A4; tilt 0.6–1.5deg on one card per page.
const Card = ({ children, fill = '#F8F1D6', tilt = 0, style }: { children: React.ReactNode; fill?: string; tilt?: number; style?: React.CSSProperties }) => (
  <div style={{ position: 'relative', background: fill, border: '1.5px solid #1F3A8A', borderRadius: 4, boxShadow: '5px 6px 0 0 #1F3A8A', padding: '44px 32px 32px', transform: tilt ? `rotate(${tilt}deg)` : undefined, ...style }}>
    <Pin width={120} rotate={-8} style={{ top: -22, left: 36 }} />
    {children}
  </div>
);

// Caveat margin note, slightly rotated; <Underline> is the hand-drawn emphasis.
const Scribble = ({ children, size = 44, style }: { children: React.ReactNode; size?: number; style?: React.CSSProperties }) => (
  <div style={{ fontFamily: '"Caveat", cursive', fontSize: size, fontWeight: 600, lineHeight: 1.1, color: '#1F3A8A', transform: 'rotate(-3deg)', ...style }}>{children}</div>
);
const Underline = ({ children }: { children: React.ReactNode }) => <span style={{ borderBottom: '2px solid #1F3A8A' }}>{children}</span>;

// Rubber stamp: CONFIDENTIAL, RECEIVED. Always -4deg, always red.
const Stamp = ({ children }: { children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', border: '3px solid #C2342B', color: '#C2342B', padding: '8px 20px', fontFamily: '"DM Mono", monospace', fontSize: 22, fontWeight: 500, letterSpacing: '0.18em', textTransform: 'uppercase', transform: 'rotate(-4deg)' }}>{children}</span>
);

// Hand-counted numeral: the only step / agenda marker.
const StepNum = ({ children }: { children: React.ReactNode }) => (
  <span style={{ fontFamily: '"Caveat", cursive', fontSize: 72, fontWeight: 700, lineHeight: 0.9, color: '#1F3A8A' }}>{children}</span>
);

// Dashed separator: agenda rows, CTA steps, card source notes.
const DashedRule = () => <div style={{ borderTop: '1.5px dashed rgba(31,58,138,0.45)' }} />;
```

Stat: 168px SG 700, lh 0.85, unit as a 72px Caveat suffix (`M`, `%`, `×`). Quote page: a 360px Caveat `“` above a cream panel with an `8px 9px 0 0` shadow. Pills (radius 999): yes = ink fill, paper-yellow Caveat 32px; partial = `#F5ECA0` fill, ink Caveat; no = 1.5px red border, red DM Mono 20px uppercase.

## Do / Don't

- Do put `PAPER_BG` and `Grain` on every page; the grain is the surface.
- Do give every card border, 4px radius and hard ink offset shadow, all three.
- Do keep voices in lane: Space Grotesk prints, Caveat annotates, DM Mono files.
- Do add a Caveat margin note on at least half the pages.
- Don't render a pin at 0deg, or tilt more than one card per page.
- Don't use red outside the stamp and the no-pill, or blurred shadows anywhere.
- Don't set body copy in Caveat or headlines in DM Mono.
- Don't put a yellow card on the yellow page, or leave a content page near-empty.
