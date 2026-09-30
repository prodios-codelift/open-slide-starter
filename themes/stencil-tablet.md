---
name: Stencil & Tablet
description: "Bone paper with stencil-cut headlines and a seven-color earth palette: archaeology meets brand."
mode: light
mood: [archival, earthy, tactile, considered, graphic]
tone: [weighty, considered, tactile, literary]
formality: high
density: medium
scheme: light
best_for: "Museum and cultural-institution decks, art/architecture brands, heritage and craft brands, longform research, and manifestos that want a tactile field-manual feel."
avoid_for: "Contexts that demand digital-native polish or playful pop — the stencil-cut display and earth-tone palette commit to a deliberate analog feel."
source: bold:stencil-tablet
---

# Stencil & Tablet

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#E2DCC9` | bone — default page field on most slides |
| bg-dark | `#000000` | black — alt field on agenda/section-divider slides |
| paper | `#F4EFE0` | lighter cream — matrix tables, timeline bars, "lighter" cards |
| text | `#0A0A0A` | ink — primary text on bone/paper/light-accent fills |
| text-on-dark | `#E2DCC9` | bone — primary text on black/teal/blue fills (never white) |
| muted | `rgba(10,10,10,0.55)` | footer and meta chrome on light fields |
| accent | `#EE7A2E` | orange — the system's loudest, most-used accent |
| accent-2 | `#C73B7A` | magenta — covers, quotes, statements, "no" pills |
| sienna | `#A06A3C` | warm brown — process and principle cards |
| teal | `#2D7E73` | cool accent — process cards, "yes" pills; flips text to bone |
| blue | `#3F73B7` | mid-tone accent — process variety; flips text to bone |
| mustard | `#D8A93B` | action bars, stat cards, "partial" pills |
| olive | `#6F7A2E` | least-used accent, sixth/seventh-position variety |

## Typography

- Display font: `"Stardos Stencil", serif`, weight 700 only — a stencil face with characteristic ink-break gaps. Carries every headline and every numeral, always uppercase.
- Chrome font: `"Barlow Condensed", sans-serif`, weight 600–900, uppercase, 0.04–0.14em tracking. Carries all metadata, pills, legends, and footers.
- Body font: `"Inter", sans-serif`, weight 400–500, sentence case only.
- Quote-mark specialist: `"Bowlby One", serif` — used only for the opening glyph inside a quote panel.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Stardos+Stencil:wght@400;700&family=Bowlby+One&family=Barlow+Condensed:wght@500;600;700;800;900&family=Inter:wght@400;500;600&display=swap`
- Type scale (already 1920-wide px in the source):
  - Numeral mega (section divider): 540px, Stardos 700, line-height 0.8 — always accent-on-black
  - Cover hero (max scale, use sparingly): 220px, Stardos 700, line-height 0.82, uppercase
  - Section headline: 120px, Stardos 700, line-height 0.92, uppercase
  - Page headline / Title default: 92px, Stardos 700, line-height 0.92, uppercase
  - Numeral in a tablet card: 220px, Stardos 700, line-height 0.9
  - Topbar / chrome: 32px, Barlow 800, uppercase, 0.04em
  - Body: 22px, Inter 400, line-height 1.4
  - Footer / pill / caption: 18–22px, Barlow 600–700, uppercase, 0.06–0.08em

## Layout

- Content padding: 64px horizontal, 48px top, 36px bottom (1920×1080). Top chrome sits at top:48/left-right:64; footer chrome at bottom:36/left-right:64.
- Alignment: color blocks as layout — rounded "tablet" cards tile across the bone field in a row or grid with 22–28px gaps. The bone field visible between cards is structural; don't shrink it to fit more.
- A typical slide covers most of its canvas in color blocks. The exception is the section-divider slide, where one 540px numeral on black and empty space around it IS the design.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Stardos Stencil", serif', fontSize: 100, fontWeight: 700, lineHeight: 0.92, letterSpacing: '-0.01em', textTransform: 'uppercase', margin: 0, color: '#0A0A0A', maxWidth: 1300 }}>
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
    <div style={{ position: 'absolute', left: 64, right: 64, bottom: 36, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: '"Barlow Condensed", sans-serif', fontSize: 22, fontWeight: 600, letterSpacing: '0.08em', textTransform: 'uppercase', color: 'rgba(10,10,10,0.55)' }}>
      <span>STENCIL & TABLET</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Barlow Condensed", sans-serif', fontSize: 24, fontWeight: 800, letterSpacing: '0.14em', textTransform: 'uppercase', color: '#EE7A2E' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Headlines and tablet cards rise and fade in over 0.4–0.6s; nothing bounces, glows, or drifts — the system is flat and confident, not animated.

```css
@keyframes riseIn {
  from { opacity: 0; transform: translateY(16px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

## Aesthetic

A West Coast skate-poster meets municipal stencil signage system. Stardos Stencil carries every headline and numeral with characteristic ink-break gaps; Barlow Condensed runs all chrome at extra-heavy uppercase weights; Inter is the quiet voice for the small amount of body copy. Color blocks — sienna, magenta, orange, teal, blue, mustard, olive — tile across a bone-cream field as rounded 22–26px "tablet" cards; a black field with bone type appears only on agenda and bold-divider slides. Flat by design: no drop shadows, no gradients. Scale is the primary expressive tool — numerals run from 160px to 540px — and color is the secondary one.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#E2DCC9', color: '#0A0A0A', position: 'relative', padding: 64, display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
    <Eyebrow>FINANCE · Q3 2026</Eyebrow>
    <div style={{ display: 'flex', alignItems: 'flex-end', justifyContent: 'space-between', gap: 48 }}>
      <Title>Quarterly Business Review</Title>
      <Tablet accent="#EE7A2E" numeral="01" headline="Overview" />
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// The system's namesake container: a rounded card holding a giant stencil
// numeral above a stencil headline. Cool fills (teal, blue) flip text to
// bone; warm/light fills (sienna, magenta, orange, mustard, olive, paper,
// bone) stay with ink. A tablet without a numeral is just a generic card.
const Tablet = ({ accent, numeral, headline, children }: { accent: string; numeral: string; headline: string; children?: React.ReactNode }) => {
  const dark = accent === '#2D7E73' || accent === '#3F73B7' || accent === '#000000';
  return (
    <div style={{ width: 420, borderRadius: 26, padding: '38px 32px 32px', background: accent, color: dark ? '#E2DCC9' : '#0A0A0A', display: 'flex', flexDirection: 'column', gap: 12 }}>
      <div style={{ fontFamily: '"Stardos Stencil", serif', fontSize: 140, fontWeight: 700, lineHeight: 0.85, letterSpacing: '-0.02em' }}>{numeral}</div>
      <div style={{ fontFamily: '"Stardos Stencil", serif', fontSize: 30, fontWeight: 700, lineHeight: 1.05, textTransform: 'uppercase' }}>{headline}</div>
      {children && <p style={{ fontFamily: 'Inter, sans-serif', fontSize: 20, lineHeight: 1.45, margin: 0 }}>{children}</p>}
    </div>
  );
};

// Full-width mustard callout bar for section-opening moments: an uppercase
// tag, a vertical ink rule, and a stencil headline.
const ActionBar = ({ tag, children }: { tag: string; children: React.ReactNode }) => (
  <div style={{ background: '#D8A93B', borderRadius: 22, padding: '24px 32px', display: 'flex', alignItems: 'center', gap: 24 }}>
    <span style={{ fontFamily: '"Barlow Condensed", sans-serif', fontSize: 22, fontWeight: 800, letterSpacing: '0.08em', textTransform: 'uppercase', color: '#0A0A0A' }}>{tag}</span>
    <div style={{ width: 2, alignSelf: 'stretch', background: '#0A0A0A' }} />
    <span style={{ fontFamily: '"Stardos Stencil", serif', fontSize: 34, fontWeight: 700, textTransform: 'uppercase' }}>{children}</span>
  </div>
);

// Fully rounded matrix-status pill. Fixed convention: teal=yes, mustard=
// partial, magenta=no, paper-with-ink-border=note. Decorative elsewhere.
const Pill = ({ status, children }: { status: 'yes' | 'partial' | 'no' | 'note'; children: React.ReactNode }) => {
  const fill = { yes: '#2D7E73', partial: '#D8A93B', no: '#C73B7A', note: '#F4EFE0' }[status];
  const color = status === 'yes' ? '#E2DCC9' : '#0A0A0A';
  const border = status === 'note' ? '1.5px solid #0A0A0A' : 'none';
  return (
    <span style={{ display: 'inline-block', borderRadius: 999, padding: '6px 16px', background: fill, color, border, fontFamily: '"Barlow Condensed", sans-serif', fontSize: 18, fontWeight: 700, letterSpacing: '0.08em', textTransform: 'uppercase' }}>
      {children}
    </span>
  );
};
```

## Do / Don't

- Do set every headline in Stardos Stencil uppercase at weight 700, at any size.
- Do use Barlow Condensed extra-heavy uppercase (0.04em+ tracking) for every chrome, label, pill, and footer element.
- Do tile tablet cards and color blocks across the bone field — the blocks ARE the layout, not decoration on top of it.
- Do round every card to 22–26px and keep 22–28px gaps between cards; the bone field between them is structural.
- Do use bone (`#E2DCC9`), never white, for text on dark fills.
- Don't add drop shadows or gradients — the system is flat blocks of saturated color.
- Don't use Inter for headlines or chrome, and don't use Stardos Stencil for body copy under 22px.
- Don't invent an eighth accent color; the seven-accent palette plus bone/black/paper is closed.
- Don't crowd cards with less than 22px gaps, and don't run the 540px section numeral on a light field.
