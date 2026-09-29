---
name: Notebook Tabs
description: "A cream paper page on a dark desk, punched binder holes on the left and pastel index tabs down the right edge."
mode: light
mood: [editorial, organized, elegant, tactile]
tone: [refined, orderly, warm, crafted]
formality: medium
density: medium
scheme: mixed
best_for: "Multi-section reports, workshop or course material, research readouts, and planning decks where the coloured tabs double as a visible table of contents."
avoid_for: "High-energy launches, dark dramatic keynotes, or decks with no clear sections — without real chapters the tabs become decoration with nothing to index."
source: preset
derived: true
---

# Notebook Tabs

## Palette

| Role   | Value     | Notes                                                        |
| ------ | --------- | ------------------------------------------------------------ |
| bg     | `#2D2D2D` | the desk — fills the canvas behind the paper; also hole fill |
| paper  | `#F8F6F1` | cream page — every word of content sits on it                |
| text   | `#1A1A1A` | primary copy on paper and all text on tabs                   |
| accent | `#98D4BB` | mint — tab 1, and the default Eyebrow fill                   |
| muted  | `#6E6A62` | warm grey — secondary copy, footer, captions                 |
| border | `#D9D4C7` | hairline rules on paper                                      |
| tab-2  | `#C7B8EA` | lavender                                                     |
| tab-3  | `#F4B8C5` | pink                                                         |
| tab-4  | `#A8D8EA` | sky                                                          |
| tab-5  | `#FFE6A7` | butter cream                                                 |

The five pastels are fills only (tabs, eyebrow pills) — never text on the paper.

## Typography

- Display font: `"Bodoni Moda", "Bodoni 72", Didot, Georgia, serif` — weight 400 for titles (high-contrast hairlines at display optical size), 700 for stat numerals only.
- Body font: `"DM Sans", system-ui, sans-serif` — weight 400 for copy, 500 for labels, tabs, and emphasis.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bodoni+Moda:opsz,wght@6..96,400;6..96,700&family=DM+Sans:wght@400;500&display=swap` — the `opsz` range lets Bodoni switch to its fine-hairline display cut at large sizes.
- Type scale:
  - Hero title (cover): 140px Bodoni 400, line-height 1.0, letter-spacing -0.02em
  - Section heading: 112px Bodoni 400, line-height 1.05
  - Page heading (`Title` default): 96px Bodoni 400, line-height 1.05, letter-spacing -0.01em
  - Stat numeral: 140px Bodoni 700, line-height 0.9
  - Lead: 40px DM Sans 400, line-height 1.5, muted
  - Body: 32px DM Sans 400, line-height 1.6
  - Label / eyebrow / footer / tab: 22px DM Sans 500, uppercase, letter-spacing 0.12em

## Layout

- Desk: `#2D2D2D` fills the 1920×1080 canvas.
- Paper: inset top 72, bottom 72, left 96, right 160 → a 1664×936 sheet, 6px radius, soft drop shadow. The wider right margin holds the tabs.
- Binder holes: three 30px holes, centred 64px from the paper's left edge, evenly spaced top to bottom.
- Tabs: stacked on the paper's right edge from 72px below its top — 160px tall, 12px apart, 48px deep (active tab 64px). Five tabs maximum.
- Content box (relative to the paper): top 96, right 120, bottom 136, left 160 — clears the holes and the footer. That is 1384×704px of usable area (canvas x 256–1640, y 168–872); budget every page against 704px.
- Alignment: left-aligned editorial column; a two-column split (7/5) with an 80px gutter for text-plus-figure pages.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 96 }: { children: React.ReactNode; size?: number }) => (
  <h1
    style={{
      fontFamily: '"Bodoni Moda", "Bodoni 72", Didot, Georgia, serif',
      fontSize: size,
      fontWeight: 400,
      lineHeight: size >= 120 ? 1 : 1.05,
      letterSpacing: size >= 120 ? '-0.02em' : '-0.01em',
      margin: 0,
      color: '#1A1A1A',
    }}
  >
    {children}
  </h1>
);
```

### Footer

Render inside `<Paper>` — offsets are relative to the paper so the rule clears the binder holes.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div
      style={{
        position: 'absolute',
        left: 160,
        right: 120,
        bottom: 56,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'baseline',
        paddingTop: 16,
        borderTop: '1px solid #D9D4C7',
        fontFamily: '"DM Sans", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 500,
        letterSpacing: '0.12em',
        textTransform: 'uppercase',
        color: '#6E6A62',
      }}
    >
      <span>NOTEBOOK · 2026</span>
      <span style={{ fontFamily: '"Bodoni Moda", Georgia, serif', fontSize: 28, fontWeight: 400, letterSpacing: 0, color: '#1A1A1A' }}>
        {String(current).padStart(2, '0')}
        <span style={{ color: '#6E6A62' }}> / {String(total).padStart(2, '0')}</span>
      </span>
    </div>
  );
};
```

### Eyebrow / accents

A pastel pill — pass the active tab's colour so the eyebrow and the tab name the same section.

```tsx
const Eyebrow = ({ children, color = '#98D4BB' }: { children: React.ReactNode; color?: string }) => (
  <div
    style={{
      width: 'fit-content',
      background: color,
      color: '#1A1A1A',
      padding: '10px 18px',
      borderRadius: 4,
      fontFamily: '"DM Sans", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 500,
      letterSpacing: '0.12em',
      textTransform: 'uppercase',
      marginBottom: 40,
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Paper, holes, and tabs are fixed chrome and never animate — the stack must look identical page to page so only the active tab appears to move; content on the paper enters with a short fade-up (0.5s, 80ms stagger).

```css
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(20px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

## Aesthetic

A well-kept ring binder on a dark desk. Each slide is a sheet of cream stock with a soft shadow, three punched holes down the left, and pastel index tabs on the right edge naming the deck's sections — the tabs are the table of contents and the "you are here" marker at once. Bodoni Moda's high-contrast Didone gives headlines magazine elegance; DM Sans keeps copy plain and legible. Organized, calm, and tactile: pastels only as fills, gentle radii only on paper corners and tab ends, no gradients, no neon, no illustration.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#2D2D2D', fontFamily: '"DM Sans", system-ui, sans-serif', color: '#1A1A1A' }}>
    <Paper>
      <BinderHoles />
      <Tabs>
        <Tab color="#98D4BB" active>Overview</Tab>
        <Tab color="#C7B8EA">Results</Tab>
        <Tab color="#F4B8C5">Risks</Tab>
        <Tab color="#A8D8EA">Plan</Tab>
      </Tabs>
      <div style={{ position: 'absolute', top: 96, right: 120, bottom: 136, left: 160, display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
        <Eyebrow color="#98D4BB">Chapter 01 · Overview</Eyebrow>
        <Title size={140}>The Big Idea</Title>
        <p style={{ fontSize: 40, lineHeight: 1.5, color: '#6E6A62', maxWidth: 1100, margin: '40px 0 0' }}>
          A short subtitle that explains what this deck is about.
        </p>
      </div>
      <Footer />
    </Paper>
  </div>
);
```

## Signature elements

```tsx
// The paper sheet on the desk — every page's container. Children position against it.
const Paper = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      position: 'absolute',
      top: 72,
      right: 160,
      bottom: 72,
      left: 96,
      background: '#F8F6F1',
      borderRadius: 6,
      boxShadow: '0 24px 60px rgba(0,0,0,0.45), 0 2px 6px rgba(0,0,0,0.25)',
    }}
  >
    {children}
  </div>
);

// Three punched binder holes down the left edge — the desk shows through.
const Hole = () => (
  <div style={{ width: 30, height: 30, borderRadius: '50%', background: '#2D2D2D', boxShadow: 'inset 0 3px 4px rgba(0,0,0,0.6), 0 1px 0 rgba(255,255,255,0.8)' }} />
);

const BinderHoles = () => (
  <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: 49, display: 'flex', flexDirection: 'column', justifyContent: 'space-evenly' }}>
    <Hole />
    <Hole />
    <Hole />
  </div>
);

// Index tabs on the paper's right edge, vertical labels. Same stack on every page;
// only `active` moves. Colours in order: mint, lavender, pink, sky, butter cream.
const Tabs = ({ children }: { children: React.ReactNode }) => (
  <div style={{ position: 'absolute', top: 72, left: '100%', display: 'flex', flexDirection: 'column', gap: 12 }}>
    {children}
  </div>
);

const Tab = ({ children, color, active = false }: { children: React.ReactNode; color: string; active?: boolean }) => (
  <div
    style={{
      width: active ? 64 : 48,
      height: 160,
      background: color,
      borderRadius: '0 10px 10px 0',
      boxShadow: '4px 4px 12px rgba(0,0,0,0.3)',
      writingMode: 'vertical-rl',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      fontFamily: '"DM Sans", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 500,
      letterSpacing: '0.1em',
      textTransform: 'uppercase',
      color: '#1A1A1A',
    }}
  >
    {children}
  </div>
);

// Hairline rule on paper — section breaks inside a page.
const Rule = () => <div style={{ width: '100%', height: 1, background: '#D9D4C7' }} />;
```

## Do / Don't

- Do put every word of content on the paper; the desk is only a frame.
- Do give each section one tab colour, in palette order, and repeat the full tab stack on every page — only `active` changes.
- Do fill the Eyebrow pill with the active tab's colour.
- Do keep tab labels to one word of 8 characters or fewer.
- Do keep the binder holes and the paper shadow on every page, and keep content 160px clear of the paper's left edge.
- Don't use the pastels as text colours on paper — text is `#1A1A1A` or `#6E6A62`.
- Don't add a sixth tab; merge sections instead.
- Don't set body copy in Bodoni Moda or headlines in DM Sans; Bodoni below ~28px loses its hairlines.
- Don't add gradients, neon, or illustration — the tactility comes from paper, shadow, and holes.
