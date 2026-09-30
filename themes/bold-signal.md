---
name: Bold Signal
description: "A saturated orange card on a charcoal gradient, with oversized section numbers and poster-weight type."
mode: dark
mood: [confident, bold, energetic, modern]
tone: [direct, assertive, punchy, contemporary]
formality: medium
density: low
scheme: dark
best_for: "Keynotes, pitch decks, product launches, and agency or brand presentations where every page lands one big idea with maximum impact."
avoid_for: "Dense data readouts, academic or compliance material, and quiet or somber topics — the orange slab shouts, and fine print drowns beside it."
source: preset
derived: true
---

# Bold Signal

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#1A1A1A` | charcoal — base surface and both gradient ends |
| bg-alt | `#2D2D2D` | lifted charcoal — the gradient's midpoint |
| bg-gradient | `linear-gradient(135deg, #1A1A1A 0%, #2D2D2D 50%, #1A1A1A 100%)` | every page's backdrop — never flat |
| text | `#FFFFFF` | primary text on charcoal |
| accent | `#FF5722` | the card fill; section numbers and eyebrows on charcoal |
| text-on-card | `#1A1A1A` | every piece of text on the card — never white on orange |
| muted | `#8C8C8C` | secondary copy, footer, captions on charcoal (≈ white at 50%) |
| border | `#3A3A3A` | hairlines and dividers on charcoal |
| card-alt | `#FF6F61` | coral — optional per-deck swap for the card; one card colour per deck |

## Typography

- Display font: `"Archivo Black", "Arial Black", system-ui, sans-serif` — ships a single weight that renders as black; set `fontWeight: 400` so the browser doesn't synthesise a faux bold on top.
- Body font: `"Space Grotesk", system-ui, sans-serif` — weight 400 for copy, 500 for labels and navigation.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Archivo+Black&family=Space+Grotesk:wght@400;500&display=swap`
- Type scale:
  - Hero title (short cover titles, on the card): 160px, line-height 0.95, letter-spacing -0.02em
  - Section number: 160px display, line-height 0.85 — always two digits
  - Title / section heading: 120px display, line-height 1, letter-spacing -0.02em
  - Page heading: 72px display, line-height 1.05
  - Stat value (on the card): 160px display, line-height 0.9
  - Body: 36px, weight 400, line-height 1.5
  - Label / nav / caption: 22px, weight 500, uppercase, letter-spacing 0.1em

## Layout

- Content padding: 120px left/right, 120px top; the footer sits in a dark band at bottom 60.
- Grid: 12 columns across the 1680px content width — 118px columns, 24px gutters (period 142px, starting at x = 120). Every block snaps to a column edge; nothing is centred.
- Anchors: section number top-left, breadcrumbs top-right, title bottom-left — the same three corners on every page.
- Cover and section pages: the card *is* the stage — `left 120, top 120, right 120, bottom 160` (1680×800), 80px inner padding, with number, breadcrumbs, and title all inside it.
- Content pages: charcoal gradient with the anchors on the page; the card shrinks to a focal block on columns 8–12 (x 1116–1800) holding the one stat or claim that matters. One card per page.

## Fixed components

### Title

```tsx
const Title = ({ children, color = '#FFFFFF' }: { children: React.ReactNode; color?: string }) => (
  <h1
    style={{
      fontFamily: '"Archivo Black", "Arial Black", system-ui, sans-serif',
      fontSize: 120,
      fontWeight: 400,
      lineHeight: 1,
      letterSpacing: '-0.02em',
      margin: 0,
      color,
    }}
  >
    {children}
  </h1>
);
```

On the card pass `color="#1A1A1A"`.

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
        fontFamily: '"Space Grotesk", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 500,
        letterSpacing: '0.1em',
        textTransform: 'uppercase',
        color: '#8C8C8C',
      }}
    >
      <span style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
        <span style={{ width: 32, height: 4, background: '#FF5722' }} />
        BOLD SIGNAL
      </span>
      <span>
        <span style={{ color: '#FFFFFF' }}>{String(current).padStart(2, '0')}</span> / {String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children, color = '#FF5722' }: { children: React.ReactNode; color?: string }) => (
  <div
    style={{
      fontFamily: '"Space Grotesk", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 500,
      letterSpacing: '0.1em',
      textTransform: 'uppercase',
      color,
      marginBottom: 24,
    }}
  >
    {children}
  </div>
);

// Oversized two-digit section number — top-left anchor. Orange on charcoal, charcoal on the card.
const SectionNumber = ({ children, color = '#FF5722' }: { children: React.ReactNode; color?: string }) => (
  <div
    style={{
      fontFamily: '"Archivo Black", "Arial Black", system-ui, sans-serif',
      fontSize: 160,
      fontWeight: 400,
      lineHeight: 0.85,
      letterSpacing: '-0.03em',
      color,
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. One decisive move per page — the card wipes in from the left, then the title rises (0.5–0.7s, ease-out, no bounce).

```css
@keyframes cardWipe {
  from { clip-path: inset(0 100% 0 0); }
  to   { clip-path: inset(0 0 0 0); }
}
@keyframes riseIn {
  from { opacity: 0; transform: translateY(32px); }
  to   { opacity: 1; transform: translateY(0); }
}
/* card:  animation: cardWipe 0.6s cubic-bezier(0.22, 1, 0.36, 1) both;
   title: animation: riseIn 0.5s 0.3s cubic-bezier(0.22, 1, 0.36, 1) both; */
```

## Aesthetic

Bold modern poster. A single slab of saturated orange sits on a deep charcoal gradient and does all the talking — it is the page's focal point, and whatever lives on it is the one thing the audience should remember. Archivo Black gives headlines and numerals a heavy, compressed-poster punch; Space Grotesk keeps labels and copy crisp and technical. Structure comes from a strict 12-column grid and three fixed anchors — number top-left, breadcrumbs top-right, title bottom-left — so pages feel engineered rather than decorated. Flat and sharp throughout: no rounded corners, no shadows, no illustration, no second accent.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      position: 'relative',
      background: 'linear-gradient(135deg, #1A1A1A 0%, #2D2D2D 50%, #1A1A1A 100%)',
      color: '#FFFFFF',
      fontFamily: '"Space Grotesk", system-ui, sans-serif',
    }}
  >
    <Card style={{ position: 'absolute', left: 120, top: 120, right: 120, bottom: 160 }}>
      <SectionNumber color="#1A1A1A">01</SectionNumber>
      <div style={{ position: 'absolute', top: 80, right: 80 }}>
        <Breadcrumbs>
          <Crumb active color="#1A1A1A">Intro</Crumb>
          <Crumb color="#1A1A1A">Results</Crumb>
          <Crumb color="#1A1A1A">Outlook</Crumb>
        </Breadcrumbs>
      </div>
      <div style={{ position: 'absolute', left: 80, bottom: 80, maxWidth: 1400 }}>
        <Eyebrow color="#1A1A1A">Chapter 01 · Overview</Eyebrow>
        <Title color="#1A1A1A">The Big Idea</Title>
      </div>
    </Card>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// The focal card — a flat orange slab. Position it per page via `style`.
const Card = ({ children, style }: { children?: React.ReactNode; style?: React.CSSProperties }) => (
  <div
    style={{
      position: 'relative',
      boxSizing: 'border-box',
      background: '#FF5722',
      color: '#1A1A1A',
      padding: 80,
      ...style,
    }}
  >
    {children}
  </div>
);

// Breadcrumb nav — top-right. Current section at full opacity, the rest at 0.4.
const Breadcrumbs = ({ children }: { children: React.ReactNode }) => (
  <nav style={{ display: 'flex', gap: 40 }}>{children}</nav>
);

const Crumb = ({ children, active = false, color = '#FFFFFF' }: { children: React.ReactNode; active?: boolean; color?: string }) => (
  <span
    style={{
      fontFamily: '"Space Grotesk", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 500,
      letterSpacing: '0.1em',
      textTransform: 'uppercase',
      color,
      opacity: active ? 1 : 0.4,
    }}
  >
    {children}
  </span>
);

// Faint 12-column guide (118px columns, 24px gutters) — optional texture on charcoal pages.
const GridOverlay = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      top: 0,
      bottom: 0,
      left: 120,
      right: 120,
      pointerEvents: 'none',
      backgroundImage: 'repeating-linear-gradient(90deg, rgba(255,255,255,0.03) 0 118px, transparent 118px 142px)',
    }}
  />
);

// Stat on the card — the one number a content page is about.
const Stat = ({ value, label }: { value: string; label: string }) => (
  <div style={{ color: '#1A1A1A' }}>
    <div style={{ fontFamily: '"Archivo Black", "Arial Black", sans-serif', fontSize: 160, lineHeight: 0.9, letterSpacing: '-0.03em' }}>{value}</div>
    <div style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 28, fontWeight: 500, marginTop: 24 }}>{label}</div>
  </div>
);
```

## Do / Don't

- Do give every page exactly one orange card, and put the page's single most important thing on it.
- Do number sections with oversized two-digit numerals (01, 02…) anchored top-left.
- Do keep breadcrumbs top-right with the current section at full opacity and the rest at 0.4.
- Do set all text on the card in charcoal `#1A1A1A` — white on orange fails contrast.
- Do snap every block to the 12-column grid and anchor titles bottom-left.
- Don't mix card colours within a deck, or place two cards on one page — a second focal point cancels the first.
- Don't round the card or add shadows; it is a flat, sharp-edged slab.
- Don't flatten the backdrop to solid `#1A1A1A` — the diagonal gradient gives the charcoal its depth.
- Don't set body copy in Archivo Black or headlines in Space Grotesk.
