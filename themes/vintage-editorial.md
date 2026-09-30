---
name: Vintage Editorial
description: "Warm cream pages and heavy Fraunces headlines with a wink, punctuated by circle-line-dot geometry and bold bordered boxes."
mode: light
mood: [witty, confident, editorial, warm]
tone: [conversational, playful, literate, assured]
formality: medium
density: low
scheme: light
best_for: "Brand stories, thought-leadership talks, agency or creative pitches, and culture or publishing decks where a voice with personality carries the argument."
avoid_for: "Dense data readouts, technical deep-dives, and somber or compliance-heavy material — the wit and airy centred column undercut gravity and can't hold fine detail."
source: preset
derived: true
---

# Vintage Editorial

## Palette

| Role   | Value     | Notes                                                                 |
| ------ | --------- | --------------------------------------------------------------------- |
| bg     | `#F5F3EE` | warm cream — every page                                               |
| text   | `#1A1A1A` | ink — headlines, body, rules, borders, all geometry strokes           |
| accent | `#E8D4C0` | warm sand — fills only: highlighter band, disc, CTA box, section page |
| muted  | `#555555` | secondary copy, subtitles, footer label                               |
| border | `#1A1A1A` | 4px CTA borders, 2–3px geometry strokes, 1px footer hairline (= text) |
| bg-alt | `#E8D4C0` | sand as a full-page surface for section breaks and the closer         |

Sand on cream is ≈1.2:1 — it never carries text or a thin line on its own.

## Typography

- Display font: `"Fraunces", Georgia, "Times New Roman", serif` — weight 900 for hero and section heads, 700 for page heads and CTA copy, 700 italic for the one witty aside per headline. Leave optical sizing on (the default) so large sizes get the high-contrast display cut.
- Body font: `"Work Sans", system-ui, sans-serif` — weight 400 for copy, 500 for labels and the footer.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,700;0,9..144,900;1,9..144,700&family=Work+Sans:wght@400;500&display=swap`
- Type scale:
  - Hero title (cover): 160px, weight 900, line-height 1.04, letter-spacing -0.02em
  - Section heading (Title default): 120px, weight 900
  - Page heading: 72px, weight 700, line-height 1.1
  - Lead / subtitle: 40px Work Sans 400, line-height 1.5, muted
  - Body: 34px Work Sans 400, line-height 1.6
  - CTA copy: 44px Fraunces 700
  - Caption / label: 24px Work Sans 500, uppercase, letter-spacing 0.18em

## Layout

- Content padding: 120px top/bottom, 160px left/right (1920×1080). Footer hairline sits at bottom 56.
- Centered column: the type block is centered horizontally — headlines up to 1320px wide, lead and body up to 1100px. Cover, section, quote, and closer pages center their text too.
- Content pages keep the column centered but left-align any paragraph or list longer than two lines; centered multi-line body reads poorly.
- Geometry sits off-axis: one `GeoMark` per page in a corner (top-right by default), at least 40px clear of any text. Centered type against off-center geometry is the whole composition.
- Rhythm: 40px eyebrow → title, 48px title → lead, 64px before a CTA box.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 120 }: { children: React.ReactNode; size?: number }) => (
  <h1
    style={{
      fontFamily: '"Fraunces", Georgia, "Times New Roman", serif',
      fontSize: size,
      fontWeight: 900,
      lineHeight: 1.04,
      letterSpacing: '-0.02em',
      textAlign: 'center',
      textWrap: 'balance',
      margin: 0,
      color: '#1A1A1A',
    }}
  >
    {children}
  </h1>
);

// The witty aside — one phrase per headline, italic with a sand highlighter band.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em
    style={{
      fontStyle: 'italic',
      fontWeight: 700,
      padding: '0 0.08em',
      backgroundImage: 'linear-gradient(transparent 58%, #E8D4C0 58%, #E8D4C0 90%, transparent 90%)',
    }}
  >
    {children}
  </em>
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
        left: 160,
        right: 160,
        bottom: 56,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'baseline',
        paddingTop: 16,
        borderTop: '1px solid #1A1A1A',
        fontFamily: '"Work Sans", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 500,
        letterSpacing: '0.18em',
        textTransform: 'uppercase',
        color: '#555555',
      }}
    >
      <span>Vintage Editorial</span>
      <span style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontWeight: 700, fontSize: 26, letterSpacing: 0, color: '#1A1A1A' }}>
        {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Centered kicker flanked by short ink rules.
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      gap: 24,
      marginBottom: 40,
      fontFamily: '"Work Sans", system-ui, sans-serif',
      fontSize: 24,
      fontWeight: 500,
      letterSpacing: '0.18em',
      textTransform: 'uppercase',
      color: '#1A1A1A',
    }}
  >
    <span style={{ width: 48, height: 2, background: '#1A1A1A' }} />
    {children}
    <span style={{ width: 48, height: 2, background: '#1A1A1A' }} />
  </div>
);
```

## Motion

- Philosophy: static. Pages turn like a printed magazine — the geometry is set in ink and never moves.

## Aesthetic

Mid-century magazine spread with a sense of humour. Warm cream stock, heavy high-contrast Fraunces headlines, and clean Work Sans copy give it the confidence of a well-edited periodical; the personality comes from the writing — headlines that read like a columnist's opening line, with one italic aside highlighted in sand. Type sits in a centered column while a single abstract mark — circle outline, a stroke through it, a dot — sits off in a corner as the counterweight. Bold square-cornered bordered boxes carry calls to action. Strictly geometric: no illustrations, icons, emoji, gradients-as-decoration, or soft shadows. Ink and cream do the work; sand is the only warmth.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      position: 'relative',
      background: '#F5F3EE',
      color: '#1A1A1A',
      fontFamily: '"Work Sans", system-ui, sans-serif',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '120px 160px',
      textAlign: 'center',
    }}
  >
    <GeoMark style={{ top: 88, right: 104 }} />
    <Eyebrow>Issue 01 · Spring 2026</Eyebrow>
    <div style={{ maxWidth: 1320 }}>
      <Title size={160}>
        The Big Idea, <Em>briefly</Em>
      </Title>
    </div>
    <p style={{ fontSize: 40, lineHeight: 1.5, color: '#555555', maxWidth: 1100, margin: '48px 0 0' }}>
      A short, slightly cheeky subtitle that says what this deck is about.
    </p>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// The mark: circle outline + a stroke through it + a dot, over an offset sand disc.
// 300×300, absolutely positioned — place it in one corner via `style`.
const GeoMark = ({ style }: { style?: React.CSSProperties }) => (
  <div aria-hidden style={{ position: 'absolute', width: 300, height: 300, pointerEvents: 'none', ...style }}>
    <div style={{ position: 'absolute', left: 84, top: 84, width: 180, height: 180, borderRadius: '50%', background: '#E8D4C0' }} />
    <div style={{ position: 'absolute', left: 36, top: 36, width: 200, height: 200, borderRadius: '50%', border: '3px solid #1A1A1A', boxSizing: 'border-box' }} />
    <div style={{ position: 'absolute', left: 0, top: 263, width: 290, height: 3, background: '#1A1A1A', transformOrigin: '0 50%', transform: 'rotate(-45deg)' }} />
    <div style={{ position: 'absolute', left: 191, top: 45, width: 28, height: 28, borderRadius: '50%', background: '#1A1A1A' }} />
  </div>
);

// Bold bordered CTA box — square, heavy, flat. Pass fill="#E8D4C0" for the sand variant.
const CtaBox = ({ children, fill = 'transparent' }: { children: React.ReactNode; fill?: string }) => (
  <div
    style={{
      display: 'inline-block',
      border: '4px solid #1A1A1A',
      background: fill,
      padding: '32px 56px',
      fontFamily: '"Fraunces", Georgia, serif',
      fontSize: 44,
      fontWeight: 700,
      lineHeight: 1.2,
      color: '#1A1A1A',
    }}
  >
    {children}
  </div>
);

// Small circle-line-dot divider — the mark in miniature, between blocks or above a quote.
const Ornament = () => (
  <div aria-hidden style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
    <span style={{ width: 20, height: 20, borderRadius: '50%', border: '2px solid #1A1A1A', boxSizing: 'border-box' }} />
    <span style={{ width: 120, height: 2, background: '#1A1A1A' }} />
    <span style={{ width: 12, height: 12, borderRadius: '50%', background: '#1A1A1A' }} />
  </div>
);
```

- Copy voice is part of the system: headlines are a sentence with a turn ("Revenue grew. Our patience did not."), one `<Em>` aside per headline, CTAs phrased as an invitation rather than a command.
- Geometry only: circles, lines, dots, and boxes built from CSS. No illustrations.

## Do / Don't

- Do center the type column and set one `GeoMark` off-axis in a corner — that tension is the look.
- Do write like a columnist: short declarative headlines with a twist, one italic sand-highlighted aside.
- Do end persuasive pages on a `CtaBox`; use a sand page (`#E8D4C0`) for section breaks and the closer.
- Do keep sand as a fill — highlighter band, disc, box, page.
- Don't set text or hairlines in sand; it vanishes on cream.
- Don't add illustrations, icons, emoji, or photos as decoration.
- Don't round the CTA box or add soft shadows — borders are square, heavy, and flat.
- Don't set body in Fraunces or headlines in Work Sans.
- Don't center multi-line paragraphs; center the column, left-align the text.
