---
name: Monochrome
description: "Black ink on ivory ledger paper: paper-thin Jost headlines, Lora italic for the human voice, tracked mono chrome, and no colour at all."
mode: light
mood: [restrained, literary, archival, ledger]
tone: [literary, considered, neutral, honest]
formality: high
density: high
scheme: light
best_for: "Research synthesis, white papers, longform reports, academic and policy briefs, advisory deliverables and bilingual EN/CN reports that should read like a hand-typeset ledger, with the words as the only thing on the page."
avoid_for: "Decks that need visual personality or colour-led storytelling; the all-ink palette is intentionally austere."
source: bold:monochrome
---

# Monochrome

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#FAFADF` | cream paper, every page; never white, never dark |
| text | `#1A1A16` | warm olive-black ink: headlines, body, every rule and border |
| accent | `#1A1A16` | the same ink; no chromatic accent exists |
| muted | `#5E5E54` | graphite: muted lead, secondary body |
| hint | `#8A8A80` | graphite light: kickers, labels, bullet dashes, chrome |
| cream-warm | `#F5F0E4` | insight cards; page tone for an insight or timeline group |
| paper-2 | `#F2F2D2` | inset surface, barely distinct |
| paper-3 | `#F0F0D4` | image-placeholder fill, in a 1px ink border |

## Typography

- Display and body: `"Jost", system-ui, -apple-system, sans-serif` — 200 for display, hero, stats and numerals; 300 for page headlines, lead and body; 400 for sub-heads. Always mixed case.
- Serif: `"Lora", Georgia, "Times New Roman", serif` — 400 only. Italic for pull-quote bodies, roman for insight-card titles. Nowhere else.
- Chrome: `"JetBrains Mono", ui-monospace, Menlo, monospace` — 400, uppercase, 0.12–0.18em. Every label, tag, axis, date, bullet dash and page number.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Jost:wght@200;300;400&family=Lora:ital,wght@0,400;1,400&family=JetBrains+Mono:wght@400&display=swap`
- Type scale (source `vw` at 1920 wide; lead, body, caption and labels, 29px and under, lifted to slide-authoring's floor):
  - Hero 163px / 200 / lh 0.96 / -0.02em · chapter 96px / 200 / lh 1.1 / -0.01em · page headline 61px / 300 / lh 1.2
  - Stat 106px / 200 / lh 1 / -0.03em · flow numeral 67px / 200 / -0.02em
  - Pull quote 61px Lora italic / lh 1.35 · insight-card title 54px Lora roman / lh 1.15
  - Sub-head 38px / 400 / lh 1.3 · lead 36px / 300 / lh 1.6 · body 32px / 300 / lh 1.65 · caption 24px / 300
  - Label 22px mono / 0.14em uppercase
- CJK: append `"Noto Sans SC"` / `"Noto Serif SC"`; Chinese display at 700 (200 reads anemic), no italic, labels mixed case with 0 tracking, hero ~15% smaller.

## Layout

- Padding 154px horizontal, 65px vertical (8vw / 6vh), the most generous in the library. Gaps 54 / 32 / 16px.
- Content pages: `ChromeBar` on top, `Footer` at the bottom (mono label pairs on 1px ink rules); the body sits between (~150px top and bottom) in the middle 60–70% of the canvas.
- Cover, chapter, quote and closing pages drop `ChromeBar` and use `<Footer bare />`: one Jost 200 headline carries an otherwise nearly empty page.
- One surface: cream paper. A run of insight or timeline pages may switch to cream-warm as a group.
- Square corners everywhere except insight cards (16px) and true circles. Process flows use whitespace between steps, never arrows.

## Fixed components

### Title

```tsx
// Jost 200, mixed case. Hero 163 by default; chapter openers size={96}.
const Title = ({ children, size = 163 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Jost", system-ui, -apple-system, sans-serif', fontSize: size, fontWeight: 200, lineHeight: size > 120 ? 0.96 : 1.1, letterSpacing: size > 120 ? '-0.02em' : '-0.01em', margin: 0, color: '#1A1A16' }}>
    {children}
  </h1>
);

// Content-page headline.
const Heading = ({ children }: { children: React.ReactNode }) => (
  <h2 style={{ fontFamily: '"Jost", system-ui, sans-serif', fontSize: 61, fontWeight: 300, lineHeight: 1.2, margin: 0, color: '#1A1A16' }}>{children}</h2>
);

// Rare inline emphasis in body copy: switch to Lora italic, never bold or colour.
const Em = ({ children }: { children: React.ReactNode }) => <em style={{ fontFamily: '"Lora", Georgia, serif', fontStyle: 'italic', fontWeight: 400 }}>{children}</em>;
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Shared chrome voice: tracked uppercase mono in graphite light.
const MONO = { fontFamily: '"JetBrains Mono", ui-monospace, Menlo, monospace', fontSize: 22, fontWeight: 400, lineHeight: 1, letterSpacing: '0.14em', textTransform: 'uppercase', color: '#8A8A80' } as const;

// `label` is real deck content (title, section, date). `bare` drops the rule on declarative pages.
const Footer = ({ label, bare = false }: { label: string; bare?: boolean }) => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    <div style={{ ...MONO, position: 'absolute', left: 154, right: 154, bottom: 65, display: 'flex', justifyContent: 'space-between', paddingTop: 16, borderTop: bare ? 'none' : '1px solid #1A1A16' }}>
      <span>{label}</span>
      <span>{pad(current)} / {pad(total)}</span>
    </div>
  );
};

// Chrome header for content pages.
const ChromeBar = ({ left, right }: { left: string; right: string }) => (
  <div style={{ ...MONO, position: 'absolute', left: 154, right: 154, top: 65, display: 'flex', justifyContent: 'space-between', paddingBottom: 16, borderBottom: '1px solid #1A1A16' }}>
    <span>{left}</span>
    <span>{right}</span>
  </div>
);
```

### Eyebrow / accents

```tsx
// Kicker: barely there by design. Mono in sentence case does not exist here.
const Eyebrow = ({ children }: { children: React.ReactNode }) => <div style={MONO}>{children}</div>;

// Bordered tag for version numbers and status labels.
const Tag = ({ children }: { children: React.ReactNode }) => (
  <span style={{ ...MONO, display: 'inline-block', padding: '0.3em 0.8em', border: '1px solid #1A1A16', letterSpacing: '0.12em', color: '#1A1A16' }}>{children}</span>
);
```

## Motion

- Philosophy: subtle. Elements enter once per page visit, staggered 80–180ms: type fades up, rules reveal left to right, ~0.7s on a smooth ease-out. Nothing loops or bounces.

```css
@keyframes fadeUp { from { opacity: 0; transform: translateY(24px); } to { opacity: 1; transform: none; } }
@keyframes revealRight { from { clip-path: inset(0 100% 0 0); } to { clip-path: inset(0 0 0 0); } }
```

## Aesthetic

Black ink on ivory ledger paper, and nothing else: a hand-typeset research report or quiet monograph, closer to a printed journal than a presentation. Paper-thin Jost 200 carries every headline; Lora is the human voice (italic pull quotes, roman insight titles); tracked uppercase JetBrains Mono is the catalogue-card voice for every label and page number. Accent means darker ink, and depth is only 1px hairlines, the 36px short rule and whitespace. No colour, shadows, gradients, textures, bold emphasis, arrows or rounded corners outside the insight card.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#FAFADF', color: '#1A1A16', padding: '65px 154px', display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: 40 }}>
    <div style={{ display: 'flex', alignItems: 'center', gap: 24 }}>
      <Rule />
      <Eyebrow>Research Report · 2026</Eyebrow>
    </div>
    <Title>The Quiet Ledger</Title>
    <p style={{ fontFamily: '"Jost", system-ui, sans-serif', fontSize: 36, fontWeight: 300, lineHeight: 1.6, color: '#5E5E54', maxWidth: 1100, margin: 0 }}>
      One lead sentence that says what this report finds.
    </p>
    <Footer bare label="Author · September 2026" />
  </div>
);
```

## Signature elements

```tsx
// The 36px short rule: the system's punctuation. Beside a kicker, under a chapter label, above a stat.
const Rule = () => <div aria-hidden style={{ width: 36, height: 1, background: '#1A1A16', flexShrink: 0 }} />;

// Full-width divider for regions, compare panels and table rows. Never thicker, never grey.
const HAIRLINE = { borderTop: '1px solid #1A1A16' } as const;

// Em-dash bullet in graphite mono: the only list mark.
const Bullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ display: 'grid', gridTemplateColumns: '1.2em 1fr', listStyle: 'none', fontFamily: '"Jost", system-ui, sans-serif', fontSize: 36, fontWeight: 300, lineHeight: 1.6 }}>
    <span style={{ fontFamily: '"JetBrains Mono", monospace', color: '#8A8A80' }}>—</span>
    <span>{children}</span>
  </li>
);

// Pull quote: always Lora italic; mono attribution after a short rule.
const PullQuote = ({ children, cite }: { children: React.ReactNode; cite: string }) => (
  <figure style={{ margin: 0, maxWidth: 1400, display: 'flex', flexDirection: 'column', gap: 32 }}>
    <blockquote style={{ margin: 0, fontFamily: '"Lora", Georgia, serif', fontStyle: 'italic', fontSize: 61, fontWeight: 400, lineHeight: 1.35 }}>{children}</blockquote>
    <figcaption style={{ display: 'flex', alignItems: 'center', gap: 16 }}><Rule /><Eyebrow>{cite}</Eyebrow></figcaption>
  </figure>
);

// Insight card: cream-warm, 16px radius, Lora roman title, Jost body pushed to the bottom. Three in a row, gap 32.
const InsightCard = ({ title, children }: { title: string; children: React.ReactNode }) => (
  <div style={{ minHeight: 520, padding: '32px 48px', borderRadius: 16, background: '#F5F0E4', display: 'flex', flexDirection: 'column', justifyContent: 'space-between', gap: 54 }}>
    <div style={{ fontFamily: '"Lora", Georgia, serif', fontSize: 54, lineHeight: 1.15 }}>{title}</div>
    <p style={{ margin: 0, fontFamily: '"Jost", system-ui, sans-serif', fontSize: 32, fontWeight: 300, lineHeight: 1.6 }}>{children}</p>
  </div>
);

// Stat cell: rule on top, Jost 200 numeral, Jost label, mono source note. Three side by side.
const StatCell = ({ value, label, note }: { value: string; label: string; note: string }) => (
  <div style={{ ...HAIRLINE, padding: '32px 32px 32px 0', display: 'flex', flexDirection: 'column', gap: 16 }}>
    <div style={{ fontFamily: '"Jost", system-ui, sans-serif', fontSize: 106, fontWeight: 200, lineHeight: 1, letterSpacing: '-0.03em' }}>{value}</div>
    <div style={{ fontFamily: '"Jost", system-ui, sans-serif', fontSize: 32, fontWeight: 300, lineHeight: 1.4 }}>{label}</div>
    <Eyebrow>{note}</Eyebrow>
  </div>
);

// Timeline dot: 8px ink with a 2px ring in the page tone, so it floats on a 1px HAIRLINE track.
const TimelineDot = ({ ring = '#F5F0E4' }: { ring?: string }) => (
  <span aria-hidden style={{ display: 'block', width: 8, height: 8, borderRadius: '50%', background: '#1A1A16', border: `2px solid ${ring}` }} />
);

// Chart bar: graphite at 50%, solid ink for the one highlighted bar, on a 1px ink baseline and axis.
// Pyramid levels instead: 2px ink left edge, fill `color-mix(in srgb, #1A1A16 N%, #FAFADF)`, N 55 → 4 as width grows 36% → 100%.
const Bar = ({ pct, on = false }: { pct: number; on?: boolean }) => (
  <div style={{ flex: 1, height: `${pct}%`, background: on ? '#1A1A16' : '#8A8A80', opacity: on ? 1 : 0.5 }} />
);
```

## Do / Don't

- Do keep every page on cream paper; never white, never dark.
- Do let one Jost 200 headline carry a nearly empty page.
- Do set every label, tag, axis, date and page number in uppercase JetBrains Mono at 0.12em or more.
- Do reserve Lora for `PullQuote` bodies (italic), `InsightCard` titles (roman) and a rare `Em`.
- Do mark lists with the em-dash `Bullet`, and divide regions with 1px ink hairlines and the 36px `Rule`.
- Don't add any chromatic or semantic colour, grey borders, or rules thicker than 1px (the pyramid's 2px edge aside).
- Don't set a headline heavier than 300, uppercase Jost, bold body copy, or a quote in sans.
- Don't add shadows, gradients, textures, arrows between flow steps, or radius beyond the insight card and true circles.
