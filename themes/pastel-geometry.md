---
name: Pastel Geometry
description: "A rounded off-white card on powder blue, with a rail of candy-coloured vertical pills stepping short-tall-short down the right edge."
mode: light
mood: [friendly, organized, modern, approachable]
tone: [warm, clear, upbeat, tidy]
formality: medium
density: low
scheme: light
best_for: "Onboarding, product walkthroughs, team updates, workshops, and education decks that should feel friendly and well organized rather than corporate."
avoid_for: "Sober or high-stakes briefings (board, legal, crisis) where candy pastels undercut authority, and data-dense pages the inset card cannot hold."
source: preset
derived: true
---

# Pastel Geometry

## Palette

| Role          | Value     | Notes                                              |
| ------------- | --------- | -------------------------------------------------- |
| bg            | `#C8D9E6` | powder blue: the frame, never a text surface       |
| card          | `#FAF9F7` | warm off-white card, where all content lives       |
| text          | `#1E2636` | deep ink, primary copy on the card                 |
| accent        | `#7C6AAD` | violet: eyebrow, key numbers, one emphasis a page  |
| muted         | `#5E6878` | secondary copy, footer label                       |
| pill-pink     | `#F0B4D4` | pill, tag fill                                     |
| pill-mint     | `#A8D4C4` | pill, tag fill                                     |
| pill-sage     | `#5A7C6A` | pill; the second colour dark enough for text       |
| pill-lavender | `#9B8DC4` | pill, tag fill                                     |
| pill-violet   | `#7C6AAD` | pill (= accent)                                    |
| shadow        | `rgba(46,72,99,0.14)` | blue-tinted card shadow                |

Use ink text on pink, mint, and lavender fills, and card-coloured text on sage or violet.

## Typography

- Display font: `"Plus Jakarta Sans", system-ui, -apple-system, "Segoe UI", sans-serif`, weight 700–800, tight tracking.
- Body font: the same family, weight 400–500.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;700;800&display=swap`
- Type scale:
  - Hero title: 144px, weight 800, line-height 1, letter-spacing -0.03em (cover, titles of about 16 characters or fewer)
  - Section heading (`Title`): 104px, weight 800, line-height 1.05, letter-spacing -0.025em
  - Page heading: 72px, weight 700, line-height 1.1, letter-spacing -0.02em
  - Stat numeral: 120px, weight 800, violet
  - Lead: 40px, weight 500, line-height 1.4
  - Body: 34px, weight 400, line-height 1.5
  - Caption / label: 22px, weight 700, uppercase, letter-spacing 0.12em

## Layout

- Canvas: powder blue fills the 1920×1080 frame.
- Card: 64px from the top, left, and bottom edges, and 152px from the right, so it measures 1704×952. Radius 48 with a soft shadow.
- Content padding inside the card: 96px, which puts text 160px from the canvas edges. Vertical budget: 760px.
- Pill rail: in the right gutter, 64px from the edge and vertically centred. It has 5 pills, each 56px wide, with 16px gaps and heights of 96/160/240/160/96.
- Grid: one left-aligned column, or 2 columns with a 64px gap across the card's 1512px inner width. Inner tiles take a pastel fill, radius 32, and no shadow.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Plus Jakarta Sans", system-ui, sans-serif',
      fontSize: 104,
      fontWeight: 800,
      lineHeight: 1.05,
      letterSpacing: '-0.025em',
      margin: 0,
      color: '#1E2636',
    }}
  >
    {children}
  </h1>
);
```

### Footer

Render it inside `<Card>`, which positions it against the card.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div
      style={{
        position: 'absolute',
        left: 96,
        right: 96,
        bottom: 48,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        fontFamily: '"Plus Jakarta Sans", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 700,
        letterSpacing: '0.12em',
        textTransform: 'uppercase',
        color: '#5E6878',
      }}
    >
      <span>PASTEL GEOMETRY</span>
      <span style={{ background: '#C8D9E6', color: '#1E2636', borderRadius: 999, padding: '8px 22px' }}>
        {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// A small vertical pill echoes the rail, followed by the violet label.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      display: 'flex',
      alignItems: 'center',
      gap: 16,
      fontFamily: '"Plus Jakarta Sans", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 700,
      letterSpacing: '0.12em',
      textTransform: 'uppercase',
      color: '#7C6AAD',
    }}
  >
    <span style={{ width: 12, height: 32, borderRadius: 999, background: '#7C6AAD' }} />
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. The card rises into place and the pills grow in one after another, like tabs sliding out. Gentle, never bouncy.
- Keyframes. Use `cardIn 0.6s cubic-bezier(0.22,1,0.36,1) both` on the card and `pillGrow 0.5s` with the same easing on each pill, delayed by `i * 60ms`:

```css
@keyframes cardIn {
  from { opacity: 0; transform: translateY(12px); }
  to   { opacity: 1; transform: translateY(0); }
}
@keyframes pillGrow {
  from { opacity: 0; transform: scaleY(0.4); }
  to   { opacity: 1; transform: scaleY(1); }
}
```

## Aesthetic

Soft, friendly geometry. Every page is a single rounded off-white card floating on powder blue under a diffuse, blue-tinted shadow. The fingerprint is the rail of vertical pills on the right edge. They share one width and step short, medium, tall, medium, short through pink, mint, sage, lavender, and violet, like colour-coded file tabs beside the card. Plus Jakarta Sans at 800 gives headlines a confident, round voice. Everything is built from two shapes, the pill and the rounded rectangle. It avoids sharp corners, hard shadows, gradients, and illustration, and stays organized and calm, never cute for its own sake.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#C8D9E6',
      position: 'relative',
      fontFamily: '"Plus Jakarta Sans", system-ui, sans-serif',
    }}
  >
    <Card style={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: 36 }}>
      <ActionIcon />
      <Eyebrow>Chapter 01 · Onboarding</Eyebrow>
      <Title>The Big Idea</Title>
      <p style={{ fontSize: 40, fontWeight: 500, lineHeight: 1.4, color: '#5E6878', maxWidth: 1200, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
      <Footer />
    </Card>
    <PillRail />
  </div>
);
```

## Signature elements

```tsx
// The rounded card with a soft shadow. Every page's content sits on it.
const Card = ({ children, style }: { children: React.ReactNode; style?: React.CSSProperties }) => (
  <div
    style={{
      position: 'absolute',
      top: 64,
      left: 64,
      bottom: 64,
      right: 152,
      padding: 96,
      background: '#FAF9F7',
      borderRadius: 48,
      boxShadow: '0 24px 64px rgba(46, 72, 99, 0.14), 0 4px 12px rgba(46, 72, 99, 0.06)',
      ...style,
    }}
  >
    {children}
  </div>
);

// Vertical pills on the right edge, the whole point of the style. They share one
// width, step short, medium, tall, medium, short, and stay identical on every page.
const PILLS = [
  { h: 96, c: '#F0B4D4' },
  { h: 160, c: '#A8D4C4' },
  { h: 240, c: '#5A7C6A' },
  { h: 160, c: '#9B8DC4' },
  { h: 96, c: '#7C6AAD' },
];
const PillRail = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      right: 64,
      top: 132,
      display: 'flex',
      flexDirection: 'column',
      gap: 16,
    }}
  >
    {PILLS.map((p, i) => (
      <div key={i} style={{ width: 56, height: p.h, borderRadius: 999, background: p.c }} />
    ))}
  </div>
);

// Download/action icon in the card's top-right corner.
const ActionIcon = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      top: 56,
      right: 56,
      width: 72,
      height: 72,
      borderRadius: 999,
      background: '#C8D9E6',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
    }}
  >
    <svg width={32} height={32} viewBox="0 0 24 24" fill="none" stroke="#1E2636" strokeWidth={2.2} strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 4v11M7 10l5 5 5-5M5 20h14" />
    </svg>
  </div>
);

// Pastel pill tag for labels, legends, and status (pink, mint, or lavender bg).
const Tag = ({ children, bg = '#A8D4C4' }: { children: React.ReactNode; bg?: string }) => (
  <span
    style={{
      display: 'inline-block',
      background: bg,
      color: '#1E2636',
      borderRadius: 999,
      padding: '10px 26px',
      fontSize: 22,
      fontWeight: 700,
      letterSpacing: '0.04em',
    }}
  >
    {children}
  </span>
);
```

## Do / Don't

- Do keep the pill rail identical on every page. That consistency makes it read as tabs.
- Do keep pill width constant and vary only height, in a symmetric short, medium, tall, medium, short sequence.
- Do put all content on the card. The powder blue is a frame.
- Do make every chip, tag, counter, and chart bar a pill (radius 999), and round other surfaces at 32–48px.
- Do use violet, or sage, for the one emphasized word or numeral per page.
- Don't set text in pink, mint, or lavender. They are too light on the card.
- Don't use sharp corners, hard shadows, gradients, or illustration. Pills and the card are the only geometry.
- Don't crowd the card. Split the page rather than shrink the type.
