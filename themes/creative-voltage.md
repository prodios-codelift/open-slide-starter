---
name: Creative Voltage
description: "Electric blue split against midnight navy, a neon-yellow charge, wide Syne headlines, and a hand-signed script flourish."
mode: dark
mood: [energetic, bold, creative, playful]
tone: [punchy, irreverent, confident, retro-modern]
formality: low
density: low
scheme: dark
best_for: "Creative agency and studio pitches, brand or product launches, design and creative-tech talks, hackathon demos, and event decks that should feel charged and a little rebellious."
avoid_for: "Board, finance, legal, or somber topics and dense data readouts. The neon and script flourishes undercut gravity, and mono body copy is slow to read in bulk."
source: preset
derived: true
---

# Creative Voltage

## Palette

| Role          | Value     | Notes                                                 |
| ------------- | --------- | ----------------------------------------------------- |
| bg            | `#0066FF` | electric blue, left panel and primary surface         |
| bg-dark       | `#1A1A2E` | midnight navy, right panel and statement pages        |
| text          | `#FFFFFF` | primary text on both surfaces                         |
| accent        | `#D4FF00` | neon yellow: badges, Script, seam, key numerals       |
| muted         | `#A5A5C0` | secondary text and captions on navy                   |
| muted-on-blue | `#CCE0FF` | secondary text and labels on blue                     |
| ink           | `#1A1A2E` | text on neon badges, halftone dots on blue            |
| rule          | `#2E2E4A` | rare hairline on navy, e.g. between list rows         |

## Typography

- Display font: `"Syne", system-ui, sans-serif`, weight 800 for titles, 700 for page headings. Wide, quirky, tight tracking, mixed case.
- Body / label font: `"Space Mono", ui-monospace, Menlo, monospace`, weight 400 for body, 700 for badges and labels.
- Script accent font: `"Yellowtail", "Brush Script MT", cursive`, weight 400, one or two words per page.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=Space+Mono:wght@400;700&family=Yellowtail&display=swap`
- Type scale:
  - Hero title (cover, one or two words): 160px, Syne 800, line-height 0.92, letter-spacing -0.03em
  - Title / section heading: 128px, Syne 800, line-height 0.95, letter-spacing -0.02em
  - Page heading: 72px, Syne 700, line-height 1.05, letter-spacing -0.01em
  - Stat numeral: 200px, Syne 800, neon, letter-spacing -0.04em
  - Script accent: 104px, Yellowtail, neon, rotated -6°
  - Body: 32px, Space Mono 400, line-height 1.55 (mono runs wide; about 28 characters per 550px)
  - Label / badge / caption: 22px, Space Mono 700, uppercase, letter-spacing 0.12em

## Layout

- Padding: 120px from canvas edges; 96px of clearance either side of the seam.
- Split panels, blue left and navy right, with an 8px neon seam:
  - Cover and section openers: seam at x = 1152. Blue holds the Eyebrow (top: 120) and the Title, anchored at bottom: 200. Navy (x = 1248–1800) holds the Script and the lede.
  - Content pages: seam at x = 720. Blue holds the Eyebrow and a 72px heading, top-anchored. Navy (x = 816–1800) holds body, bullets, and at most one Callout.
  - Statement and stat pages drop the split: all navy, one neon numeral or line, one Script.
- One Halftone per page, in a panel corner, fading toward the content.
- The Footer spans both panels at bottom: 60. Anchor blocks to panel edges, never to the canvas centre.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Syne", system-ui, sans-serif',
      fontSize: 128,
      fontWeight: 800,
      lineHeight: 0.95,
      letterSpacing: '-0.02em',
      margin: 0,
      color: '#FFFFFF',
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
        fontFamily: '"Space Mono", ui-monospace, monospace',
        fontSize: 22,
        fontWeight: 700,
        letterSpacing: '0.12em',
        textTransform: 'uppercase',
        color: '#FFFFFF',
      }}
    >
      <span style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
        <span style={{ width: 14, height: 14, borderRadius: '50%', background: '#D4FF00' }} />
        CREATIVE VOLTAGE
      </span>
      <span>
        <span style={{ color: '#D4FF00' }}>{String(current).padStart(2, '0')}</span> /{' '}
        {String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

The eyebrow is a neon badge: a solid pill with ink text.

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      display: 'inline-flex',
      alignSelf: 'flex-start',
      padding: '10px 22px',
      borderRadius: 999,
      background: '#D4FF00',
      color: '#1A1A2E',
      fontFamily: '"Space Mono", ui-monospace, monospace',
      fontSize: 22,
      fontWeight: 700,
      letterSpacing: '0.12em',
      textTransform: 'uppercase',
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Snappy 250–400ms entrances: the Script wipes on as if written, and badges pop with a small overshoot (`cubic-bezier(0.34, 1.56, 0.64, 1)`). Nothing loops or glows.

```css
@keyframes writeOn {
  from { clip-path: inset(0 100% 0 0); }
  to   { clip-path: inset(0 0 0 0); }
}
@keyframes pop {
  from { opacity: 0; transform: scale(0.8); }
  to   { opacity: 1; transform: scale(1); }
}
```

Use `writeOn` on `Script`, never `pop`, which would overwrite its rotation.

## Aesthetic

Retro-modern creative studio: part rave flyer, part risograph zine, rebuilt on a digital grid. Electric blue and midnight navy split the page, and a neon-yellow seam charges the line where they meet. Syne 800 shouts the headline in wide, slightly odd letterforms, Space Mono carries the substance like a spec sheet, and one neon script word adds a hand-signed flourish. Corner halftone gives the flat colour a printed grain. Neon is punctuation, never paragraphs or large fills. Flat and hard-edged: no gradients beyond the halftone fade, no soft shadows, no illustration.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      position: 'relative',
      background: '#1A1A2E',
      color: '#FFFFFF',
      fontFamily: '"Space Mono", ui-monospace, monospace',
    }}
  >
    <SplitPanels seam={1152} />
    <Halftone style={{ left: 552, top: 0, width: 600, height: 480 }} />
    <div style={{ position: 'absolute', top: 120, left: 120 }}>
      <Eyebrow>Chapter 01</Eyebrow>
    </div>
    <div style={{ position: 'absolute', left: 120, bottom: 200, width: 936 }}>
      <Title>The Big Idea</Title>
    </div>
    <div style={{ position: 'absolute', left: 1248, right: 120, bottom: 200 }}>
      <Script>let's go</Script>
      <p style={{ margin: '40px 0 0', fontSize: 32, lineHeight: 1.55, color: '#A5A5C0' }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Split panels: blue left, navy right, 8px neon seam. Render first in a relative page root.
const SplitPanels = ({ seam = 1152 }: { seam?: number }) => (
  <>
    <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: 0, width: seam, background: '#0066FF' }} />
    <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: seam, right: 0, background: '#1A1A2E' }} />
    <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: seam - 4, width: 8, background: '#D4FF00' }} />
  </>
);

// Halftone: a dot field fading out from the `from` corner. Navy dots on blue; '#0066FF' on navy.
const Halftone = ({ color = '#1A1A2E', from = '100% 0%', style }: { color?: string; from?: string; style?: React.CSSProperties }) => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      pointerEvents: 'none',
      backgroundImage: `radial-gradient(circle, ${color} 3.5px, transparent 4px)`,
      backgroundSize: '16px 16px',
      maskImage: `radial-gradient(circle at ${from}, #000 0%, transparent 72%)`,
      ...style,
    }}
  />
);

// Script accent: one or two neon words, rotated, as a hand-signed flourish.
const Script = ({ children }: { children: React.ReactNode }) => (
  <span
    style={{
      display: 'inline-block',
      fontFamily: '"Yellowtail", "Brush Script MT", cursive',
      fontSize: 104,
      lineHeight: 1,
      color: '#D4FF00',
      transform: 'rotate(-6deg)',
    }}
  >
    {children}
  </span>
);

// Neon callout: a neon-framed note with a badge tab on its top edge. Navy panel only.
const Callout = ({ label, children }: { label: string; children: React.ReactNode }) => (
  <div
    style={{
      position: 'relative',
      border: '3px solid #D4FF00',
      padding: '48px 40px 36px',
      fontFamily: '"Space Mono", ui-monospace, monospace',
      fontSize: 32,
      lineHeight: 1.5,
      color: '#FFFFFF',
    }}
  >
    <span
      style={{
        position: 'absolute',
        top: -22,
        left: 32,
        padding: '6px 16px',
        borderRadius: 999,
        background: '#D4FF00',
        color: '#1A1A2E',
        fontSize: 22,
        fontWeight: 700,
        letterSpacing: '0.12em',
        textTransform: 'uppercase',
      }}
    >
      {label}
    </span>
    {children}
  </div>
);
```

## Do / Don't

- Do split covers and section openers blue-left, navy-right, with the neon seam between them.
- Do give every page one neon badge (the Eyebrow) and at most one Script word.
- Do set headlines in Syne and everything else (body, labels, numbers in copy) in Space Mono.
- Do keep one Halftone per page in a corner, fading away from the text.
- Don't set body copy or large fills in neon. Neon is punctuation.
- Don't write sentences in script, or use it at under 72px.
- Don't add a second accent colour, white surfaces, soft shadows, or glows.
- Don't centre content on the canvas. Anchor it to a panel edge.
