---
name: Electric Studio
description: "White panel over electric blue, Manrope at 800, and a quote set as the hero."
mode: light
mood: [bold, confident, crisp, energetic]
tone: [clean, professional, direct, assured]
formality: medium
density: low
scheme: mixed
best_for: "Studio and agency pitches, product or brand launches, keynotes, and client presentations that carry one big idea or quote per page."
avoid_for: "Dense data reports or long-form reading. The split panels and oversized type leave little room for tables and paragraphs."
source: preset
derived: true
---

# Electric Studio

## Palette

| Role          | Value     | Notes                                                         |
| ------------- | --------- | ------------------------------------------------------------- |
| bg            | `#FFFFFF` | white, the top panel and primary surface                      |
| bg-dark       | `#0A0A0A` | near-black surface for quote and statement pages              |
| panel         | `#4361EE` | electric blue, the bottom panel of the split                  |
| text          | `#0A0A0A` | primary text on white                                         |
| text-light    | `#FFFFFF` | primary text on blue and near-black                           |
| accent        | `#4361EE` | accent bar, corner mark, quote glyph, key numbers (= panel)   |
| muted         | `#666666` | secondary text on white                                       |
| muted-on-blue | `#D4DBFC` | secondary text and labels on the blue panel                   |
| muted-on-dark | `#8A8A8A` | secondary text and attributions on near-black                 |
| border        | `#E6E6E6` | rare hairline on white, e.g. between stat columns             |

## Typography

- Display font: `"Manrope", system-ui, -apple-system, "Segoe UI", sans-serif`, weight 800, tight negative tracking.
- Body font: the same Manrope stack, weight 400 for body and 500 for leads and subtitles.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;800&display=swap`
- Type scale:
  - Title (cover and section): 120px, weight 800, line-height 1, letter-spacing -0.03em
  - Hero quote: 88px, weight 800, line-height 1.1, letter-spacing -0.02em, with a 280px opening glyph in accent
  - Page heading: 64px, weight 800, line-height 1.1, letter-spacing -0.02em
  - Lead / subtitle: 40px, weight 500, line-height 1.4
  - Body: 32px, weight 400, line-height 1.55
  - Label / caption: 22px, weight 800, uppercase, letter-spacing 0.14em

## Layout

- Padding: 120px left and right. Corner marks sit 72px from the top, and the Footer sits 60px from the bottom.
- Two-panel split, white on top and blue below. The seam sits at y = 620 on covers and section openers, and at y = 840 on content pages, where the blue band only carries a takeaway line and the Footer.
- On the white panel, anchor the title block to the seam (bottom: 72) rather than the top. Subtitles start 72px below the seam, inside the blue panel.
- All four corners carry a brand mark: the blue square top-left, a context label top-right, the wordmark bottom-left, and the page number bottom-right.
- Quote and statement pages drop the split and use a single near-black surface.
- Spacing is minimal but confident: gaps of 48–72px, one idea per page, and never more than three bullets.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Manrope", system-ui, sans-serif',
      fontSize: 120,
      fontWeight: 800,
      lineHeight: 1,
      letterSpacing: '-0.03em',
      margin: 0,
      color: '#0A0A0A',
    }}
  >
    {children}
  </h1>
);
```

### Footer

The Footer sits on the blue panel or a near-black page by default. Pass `onLight` only on an all-white page.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = ({ onLight = false }: { onLight?: boolean }) => {
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
        fontFamily: '"Manrope", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 800,
        letterSpacing: '0.14em',
        textTransform: 'uppercase',
        color: onLight ? '#0A0A0A' : '#FFFFFF',
      }}
    >
      <span>ELECTRIC STUDIO</span>
      <span>
        {String(current).padStart(2, '0')}
        <span style={{ color: onLight ? '#666666' : '#D4DBFC' }}> / {String(total).padStart(2, '0')}</span>
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
      gap: 16,
      fontFamily: '"Manrope", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 800,
      letterSpacing: '0.14em',
      textTransform: 'uppercase',
      color: '#4361EE',
    }}
  >
    <span style={{ width: 40, height: 6, background: '#4361EE' }} />
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. The blue panel rises from the seam and the accent bar draws down, both in 300–450ms with `cubic-bezier(0.2, 0.8, 0.2, 1)`, and then type fades up. Nothing bounces or loops.

```css
@keyframes panelRise {
  from { transform: scaleY(0); }
  to   { transform: scaleY(1); }
}
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(24px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

Use `panelRise` with `transformOrigin: 'bottom'` on the blue panel and `'top'` on the AccentBar.

## Aesthetic

A contemporary design studio's pitch deck, clean and high-contrast, with no hesitation in it. One typeface, Manrope, runs from 800-weight headlines to 400-weight body, so the hierarchy comes from size and weight rather than font pairing. The page is literally split in two: a white panel carries the headline and an electric-blue panel carries the supporting line. A blue accent bar runs down the white panel's edge and joins the blue panel into one L-shaped frame. Brand marks anchor all four corners. Near-black is saved for pages where a quote is the hero, set huge and heavy under an oversized blue glyph. The pages are flat and sharp-cornered, with no gradients, shadows, or illustration. The confidence comes from space and scale.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      position: 'relative',
      background: '#FFFFFF',
      fontFamily: '"Manrope", system-ui, sans-serif',
    }}
  >
    <div style={{ position: 'absolute', left: 0, right: 0, top: 0, height: 620 }}>
      <AccentBar />
      <CornerMarks label="Q3 · 2026" />
      <div style={{ position: 'absolute', left: 120, right: 120, bottom: 72, display: 'flex', flexDirection: 'column', gap: 28 }}>
        <Eyebrow>Chapter 01</Eyebrow>
        <Title>The Big Idea</Title>
      </div>
    </div>
    <div style={{ position: 'absolute', left: 0, right: 0, top: 620, bottom: 0, background: '#4361EE' }}>
      <p style={{ position: 'absolute', top: 72, left: 120, maxWidth: 1200, margin: 0, fontSize: 40, fontWeight: 500, lineHeight: 1.4, color: '#FFFFFF' }}>
        A short subtitle that explains what this deck is about.
      </p>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Accent bar on the panel edge: a 16px strip of solid blue flush to the panel's left edge
// for its full height. Place it inside a positioned panel. On the cover it meets the blue
// panel and forms one L-shaped frame.
const AccentBar = () => (
  <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: 0, width: 16, background: '#4361EE' }} />
);

// Brand marks in the two top corners: a solid blue square top-left and a context label
// top-right. The Footer holds the bottom two corners.
const CornerMarks = ({ label, onDark = false }: { label: string; onDark?: boolean }) => (
  <>
    <div aria-hidden style={{ position: 'absolute', top: 72, left: 120, width: 28, height: 28, background: '#4361EE' }} />
    <div
      style={{
        position: 'absolute',
        top: 72,
        right: 120,
        lineHeight: '28px',
        fontFamily: '"Manrope", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 800,
        letterSpacing: '0.14em',
        textTransform: 'uppercase',
        color: onDark ? '#8A8A8A' : '#666666',
      }}
    >
      {label}
    </div>
  </>
);

// Quote as the hero element: an oversized blue glyph above a heavy 88px line, with the
// attribution as a label. Goes on a near-black page with AccentBar and <Footer />.
const Quote = ({ children, cite }: { children: React.ReactNode; cite: string }) => (
  <figure style={{ margin: 0, fontFamily: '"Manrope", system-ui, sans-serif' }}>
    <div aria-hidden style={{ height: 150, fontSize: 280, fontWeight: 800, lineHeight: 1, color: '#4361EE' }}>
      “
    </div>
    <blockquote style={{ margin: 0, fontSize: 88, fontWeight: 800, lineHeight: 1.1, letterSpacing: '-0.02em', color: '#FFFFFF' }}>
      {children}
    </blockquote>
    <figcaption style={{ marginTop: 48, fontSize: 22, fontWeight: 800, letterSpacing: '0.14em', textTransform: 'uppercase', color: '#8A8A8A' }}>
      {cite}
    </figcaption>
  </figure>
);
```

## Do / Don't

- Do split every cover and section opener into a white panel over a blue one, with the seam at 620px.
- Do run the AccentBar down the white panel's left edge so that it joins the blue panel.
- Do anchor all four corners with CornerMarks and the Footer.
- Do give at least one page per deck to a `Quote` on near-black. It is the system's showpiece.
- Don't add a second accent colour, gradients, shadows, or rounded corners.
- Don't put blue text on the blue panel. Text there is white or `#D4DBFC`.
- Don't pair Manrope with a second typeface. Build the hierarchy from weight (800 against 400/500) and size.
- Don't crowd a page. If the white panel can't hold a block with 72px of clearance above the seam, split the content across pages.
