---
name: Paper & Ink
description: "Warm cream paper, charcoal serif type, and one crimson mark: a literary page of drop caps, pull quotes, and fine rules."
mode: light
mood: [literary, thoughtful, refined, calm]
tone: [editorial, reflective, elegant, measured]
formality: high
density: medium
scheme: light
best_for: "Essays and keynote talks, research or book presentations, annual letters, and narrative strategy reviews where well-set prose and quotation carry the argument."
avoid_for: "Data-dense dashboards, product demos, or high-energy launches: the quiet all-serif page reads as slow and bookish when the content needs punch."
source: preset
derived: true
---

# Paper & Ink

## Palette

| Role      | Value     | Notes                                                       |
| --------- | --------- | ----------------------------------------------------------- |
| bg        | `#FAF9F7` | warm cream paper, the only page surface                     |
| bg-alt    | `#F1EDE6` | deeper cream for a sidebar or margin panel                  |
| text      | `#1A1A1A` | charcoal ink for headlines and body                         |
| accent    | `#C41E3A` | crimson, the printer's second colour: drop caps, kickers, rule ornaments |
| muted     | `#6E6862` | warm grey for standfirsts, captions, attributions, the folio |
| rule      | `#1A1A1A` | hairlines are ink: 1px charcoal                             |
| rule-soft | `#D8D2C8` | faint rule for column dividers and table rows               |

## Typography

- Display font: `"Cormorant Garamond", "EB Garamond", Garamond, "Times New Roman", serif`. Weight 500 roman for headlines, 500 italic for pull quotes and emphasis, 600 for drop caps. Never heavier, and never below 56px, because its hairlines vanish at small sizes.
- Body font: `"Source Serif 4", "Source Serif Pro", Georgia, serif`. Weight 400 (italic for standfirsts and folios), 600 for uppercase labels.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,500;0,600;1,500&family=Source+Serif+4:ital,wght@0,400;0,600;1,400&display=swap`
- Type scale. Headline weights are deliberately lighter than slide-authoring's 800–900 default: Cormorant tops out at 700, and the register is book, not billboard.
  - Hero (cover): 144px Cormorant 500, line-height 1.02, letter-spacing -0.01em
  - Title / section heading: 104px Cormorant 500, line-height 1.05
  - Page heading: 72px Cormorant 500, line-height 1.1
  - Pull quote: 60px Cormorant italic 500, line-height 1.25
  - Standfirst: 40px Source Serif 4 italic, line-height 1.5, muted
  - Body: 34px Source Serif 4 400, line-height 1.6, measure ≤ 1100px (~65 characters)
  - Drop cap: 172px Cormorant 600 crimson, three body lines deep
  - Label / kicker: 22px Source Serif 4 600, uppercase, 0.24em tracking. Folio: 24px italic.

## Layout

- Content padding: 160px horizontal, 120px vertical (840px vertical budget).
- Alignment: left-aligned single text column, body capped at 1100px. Covers and lone pull-quote pages may center, like a title page.
- Grid: content pages may use `360px 1fr` at 96px gap, with a narrow margin column for the kicker and marginal notes and the main column for heading and prose. Prose next to a pull quote uses `1.2fr 1fr` at 96px gap.
- Rules, not boxes, carry the structure. Leave 48–64px of air above and below every rule.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 104 }: { children: React.ReactNode; size?: number }) => (
  <h1
    style={{
      fontFamily: '"Cormorant Garamond", "EB Garamond", Garamond, serif',
      fontSize: size, // 144 on covers
      fontWeight: 500,
      lineHeight: size > 120 ? 1.02 : 1.05,
      letterSpacing: '-0.01em',
      margin: 0,
      color: '#1A1A1A',
    }}
  >
    {children}
  </h1>
);

// Italicise one phrase per headline, in ink rather than crimson.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'italic' }}>{children}</em>
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
        bottom: 64,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'baseline',
        paddingTop: 16,
        borderTop: '1px solid #1A1A1A',
        fontFamily: '"Source Serif 4", Georgia, serif',
        color: '#6E6862',
      }}
    >
      <span style={{ fontSize: 22, fontWeight: 600, letterSpacing: '0.24em', textTransform: 'uppercase' }}>
        Paper &amp; Ink
      </span>
      <span style={{ fontSize: 24, fontStyle: 'italic' }}>
        {current} of {total}
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
      fontFamily: '"Source Serif 4", Georgia, serif',
      fontSize: 22,
      fontWeight: 600,
      letterSpacing: '0.24em',
      textTransform: 'uppercase',
      color: '#C41E3A',
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: static. Print doesn't move, so pages cut cleanly and the typography does the work.

## Aesthetic

Literary print: a well-set essay in a quarterly review, or the opening spread of a hardcover. Warm cream paper and charcoal ink carry everything. Crimson appears only as a printer's second colour, on the drop cap, the kicker, and the ornament in a rule. Cormorant Garamond gives headlines and pull quotes a high-contrast, bookish elegance, and Source Serif 4 carries the reading. Typography and hairline rules make the structure, never boxes or fills. Generous margins and a narrow measure make the page feel considered and never crowded. The system is all-serif, with no sans, no shadows, no rounded corners, no gradients, and no faux-paper textures.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#FAF9F7',
      color: '#1A1A1A',
      position: 'relative',
      padding: '120px 160px',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
    }}
  >
    <div style={{ position: 'absolute', top: 120, left: 160, right: 160 }}>
      <MastheadRule />
    </div>
    <Eyebrow>Annual Letter · 2026</Eyebrow>
    <div style={{ marginTop: 28 }}>
      <Title size={144}>
        The <Em>Long</Em> View
      </Title>
    </div>
    <p style={{ fontFamily: '"Source Serif 4", Georgia, serif', fontStyle: 'italic', fontSize: 40, lineHeight: 1.5, color: '#6E6862', maxWidth: 1100, margin: '32px 0 0' }}>
      A short standfirst that sets up the argument in a sentence.
    </p>
    <div style={{ marginTop: 56 }}>
      <OrnamentRule />
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Body copy. The drop cap and pull quote sit against it.
const bodyText = {
  fontFamily: '"Source Serif 4", Georgia, serif',
  fontSize: 34,
  lineHeight: 1.6,
  color: '#1A1A1A',
  maxWidth: 1100,
  margin: 0,
} as const;

// Drop cap: crimson Cormorant, three body lines deep. Use it once per page, on the opening paragraph.
// <p style={bodyText}><DropCap>T</DropCap>he quarter closed…</p>
const DropCap = ({ children }: { children: string }) => (
  <span
    style={{
      float: 'left',
      fontFamily: '"Cormorant Garamond", Garamond, Georgia, serif',
      fontSize: 172,
      fontWeight: 600,
      lineHeight: 0.8,
      color: '#C41E3A',
      margin: '12px 18px 0 0',
    }}
  >
    {children}
  </span>
);

// Pull quote: italic Cormorant between two ink hairlines, with crimson marks.
const PullQuote = ({ children, cite }: { children: React.ReactNode; cite: string }) => (
  <figure style={{ margin: 0, padding: '40px 0', borderTop: '1px solid #1A1A1A', borderBottom: '1px solid #1A1A1A' }}>
    <blockquote
      style={{
        margin: 0,
        fontFamily: '"Cormorant Garamond", Garamond, Georgia, serif',
        fontSize: 60,
        fontStyle: 'italic',
        fontWeight: 500,
        lineHeight: 1.25,
        color: '#1A1A1A',
      }}
    >
      <span style={{ color: '#C41E3A' }}>“</span>
      {children}
      <span style={{ color: '#C41E3A' }}>”</span>
    </blockquote>
    <figcaption style={{ marginTop: 24, fontFamily: '"Source Serif 4", Georgia, serif', fontSize: 22, fontWeight: 600, letterSpacing: '0.24em', textTransform: 'uppercase', color: '#6E6862' }}>
      — {cite}
    </figcaption>
  </figure>
);

// Ornament rule: hairline, crimson lozenge, hairline. Use at section breaks and under cover titles.
const OrnamentRule = ({ width = 480 }: { width?: number }) => (
  <div style={{ display: 'flex', alignItems: 'center', gap: 20, width }}>
    <div style={{ flex: 1, height: 1, background: '#1A1A1A' }} />
    <div style={{ width: 10, height: 10, background: '#C41E3A', transform: 'rotate(45deg)' }} />
    <div style={{ flex: 1, height: 1, background: '#1A1A1A' }} />
  </div>
);

// Thick-thin masthead rule for the top of a cover or chapter opener.
const MastheadRule = () => (
  <div style={{ height: 4, borderTop: '3px solid #1A1A1A', borderBottom: '1px solid #1A1A1A' }} />
);
```

## Do / Don't

- Do open a prose page with a drop cap, on the first paragraph only.
- Do let rules organise the page: hairlines around pull quotes and above the footer, the ornament rule at breaks, and the thick-thin rule atop covers.
- Do use italic as the second voice, for standfirsts, pull quotes, emphasis, and the folio.
- Do keep body copy at a book measure (≤ 1100px) with generous leading.
- Don't use crimson for body text or fills, or in more than two or three small marks per page.
- Don't add sans-serif or mono faces, or weights of 700 and up. The system is all-serif and light.
- Don't use shadows, rounded corners, cards, gradients, or faux-paper textures.
- Don't set Cormorant Garamond below 56px. Switch to Source Serif 4 instead.
