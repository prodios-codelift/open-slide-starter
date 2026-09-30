---
name: Broadside
description: "Protest-poster editorial: ink-black and fire-orange pages, massive lowercase Barlow 900, mono chrome and 1px hairlines."
mode: light
mood: [editorial, dramatic, loud, newspaper]
tone: [graphic, punchy, literary, considered]
formality: medium
density: medium
scheme: dark
best_for: "Brand manifestos, magazine and cultural pitches, design talks, founder vision statements and bilingual EN/CN decks that should land like a broadside headline."
avoid_for: "Decks that need to feel quiet, warm, or institutionally traditional — the ink-black canvas and fire-orange accent commit to drama."
source: bold:broadside
---

# Broadside

## Palette

| Role      | Value                 | Notes                                                                 |
| --------- | --------------------- | --------------------------------------------------------------------- |
| bg        | `#111111`             | ink black: content pages (dark register), and the ink on orange       |
| bg-alt    | `#1A1A18`             | a slightly raised dark region, still flat                             |
| bg-orange | `#E85D26`             | fire orange as environment: cover, chapter, statement payoff, end     |
| text      | `#F0ECE5`             | warm cream: all copy on dark, never on orange                         |
| accent    | `#E85D26`             | fire orange, the only accent on dark: kickers, rule, `/`, lead bar    |
| muted     | `#888880`             | cream-muted: secondary copy on dark                                   |
| hint      | `#505048`             | cream-hint: chrome, catalogue number, axis labels, non-accent bars    |
| border    | `#282826`             | 1px hairline on dark                                                  |
| ink-75    | `rgba(17,17,17,0.75)` | body on orange                                                        |
| ink-55    | `rgba(17,17,17,0.55)` | kicker on orange                                                      |
| ink-45    | `rgba(17,17,17,0.45)` | chrome, catalogue number, `/` on orange                               |
| ink-20    | `rgba(17,17,17,0.20)` | 1px hairline on orange                                                |

## Typography

- Display and body: `Barlow, "Noto Sans SC", system-ui, sans-serif` — 900 display, 800 chapter, 700 headline, 600 sub-head, 400 body. The only text face; range comes from weight and size.
- Chrome: `"IBM Plex Mono", ui-monospace, monospace` — 500, always uppercase, 0.1–0.14em tracking. Kickers, labels, tags, numbers, `/` markers only.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Barlow:wght@400;600;700;800;900&family=IBM+Plex+Mono:wght@500;700&display=swap`
- Type scale (source `vw` at 1920 wide; display sizes are deliberately oversized, small sizes lifted to slide-authoring's floor):
  - Display 250px / 900 / lh 0.88 / -0.04em — cover and statement; three lines max (660px)
  - Fadelist title 202px · quote mark 192px / lh 0.6 · chapter 144px / 800 / lh 0.9 / -0.03em
  - Stat 106px / 900 / lh 1 / -0.04em · headline 86px / 700 / lh 1.1 / -0.02em · quote 73px / 700 / lh 1.15 / -0.02em
  - Sub-head 54px / 600 / lh 1.2 · lead 36px / lh 1.5 · body 32px / lh 1.6 · caption 24px
  - Mono label 22px / 500 / 0.14em uppercase
- CJK: letter-spacing 0, line-height +20% (display ≥ 1.0), no uppercase on CJK runs; load Noto Sans SC only when the deck has Chinese.

## Layout

- Padding 106px horizontal, 59px vertical at 1920×1080 — tighter than usual on purpose: the type should crowd the frame. Gaps 38 / 22 / 11px.
- Content pages: `ChromeBar` on top, body, `Footer` at the bottom (reserve ~130px bottom padding). Left-aligned.
- Declarative pages (cover, chapter, statement, quote, end) drop the `ChromeBar`: a `CatalogueNum` top-left, a corner label top-right, the type anchored low, and the `Footer` as the author/date line.
- One display moment per page; most of the canvas stays empty.

## Fixed components

Every component takes `onOrange` for the orange register; the default is the ink-black register.

### Title

```tsx
// Write copy lowercase (proper nouns keep capitals); never uppercase.
const Title = ({ children, onOrange = false }: { children: React.ReactNode; onOrange?: boolean }) => (
  <h1 style={{ fontFamily: 'Barlow, "Noto Sans SC", system-ui, sans-serif', fontSize: 250, fontWeight: 900, lineHeight: 0.88, letterSpacing: '-0.04em', margin: 0, maxWidth: 1620, color: onOrange ? '#111111' : '#F0ECE5' }}>
    {children}
  </h1>
);

// Chapter openers: fontSize 144, fontWeight 800, lineHeight 0.9, letterSpacing '-0.03em'.
const Heading = ({ children, onOrange = false }: { children: React.ReactNode; onOrange?: boolean }) => (
  <h2 style={{ fontFamily: 'Barlow, "Noto Sans SC", system-ui, sans-serif', fontSize: 86, fontWeight: 700, lineHeight: 1.1, letterSpacing: '-0.02em', margin: 0, color: onOrange ? '#111111' : '#F0ECE5' }}>
    {children}
  </h2>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// `label` is real deck content (author, date, section).
const Footer = ({ label, onOrange = false }: { label: string; onOrange?: boolean }) => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    <div style={{ position: 'absolute', left: 106, right: 106, bottom: 59, display: 'flex', justifyContent: 'space-between', paddingTop: 11, borderTop: `1px solid ${onOrange ? 'rgba(17,17,17,0.2)' : '#282826'}`, fontFamily: '"IBM Plex Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, lineHeight: 1, letterSpacing: '0.1em', textTransform: 'uppercase', color: onOrange ? 'rgba(17,17,17,0.45)' : '#505048' }}>
      <span>{label}</span>
      <span>{pad(current)} / {pad(total)}</span>
    </div>
  );
};

const ChromeBar = ({ left, right, onOrange = false }: { left: string; right: string; onOrange?: boolean }) => (
  <div style={{ display: 'flex', justifyContent: 'space-between', paddingBottom: 11, marginBottom: 22, borderBottom: `1px solid ${onOrange ? 'rgba(17,17,17,0.2)' : '#282826'}`, fontFamily: '"IBM Plex Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, lineHeight: 1, letterSpacing: '0.1em', textTransform: 'uppercase', color: onOrange ? 'rgba(17,17,17,0.45)' : '#505048' }}>
    <span>{left}</span>
    <span>{right}</span>
  </div>
);
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children, onOrange = false }: { children: React.ReactNode; onOrange?: boolean }) => (
  <div style={{ fontFamily: '"IBM Plex Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, lineHeight: 1, letterSpacing: '0.14em', textTransform: 'uppercase', color: onOrange ? 'rgba(17,17,17,0.55)' : '#E85D26' }}>
    {children}
  </div>
);

const Rule = ({ onOrange = false }: { onOrange?: boolean }) => (
  <div style={{ width: 36, height: 2, background: onOrange ? '#111111' : '#E85D26' }} />
);
```

## Motion

- Philosophy: subtle. Elements enter once, staggered ~80ms: type fades up 28px, rules and bars wipe in left to right, 0.5s `cubic-bezier(0.16, 1, 0.3, 1)`. Nothing loops.

```css
@keyframes fadeUp { from { opacity: 0; transform: translateY(28px); } to { opacity: 1; transform: none; } }
@keyframes revealRight { from { clip-path: inset(0 100% 0 0); } to { clip-path: inset(0 0 0 0); } }
```

## Aesthetic

Ink on fire: a protest poster crossed with a publication cover, after broadside printing, SPACE10 reports and Wim Crouwel grids. Type is so large it stops being text and becomes image — lowercase Barlow at 900, tracked tight, crowding the frame. There are exactly two surfaces: ink-black pages that document, with cream copy and fire orange as the single accent, and fire-orange pages that declare, with everything set in black ink. Structure comes only from weight, size, 1px hairlines and uppercase IBM Plex Mono chrome that reads like catalogue stamps. Entirely flat: no shadows, gradients, rounded corners, italics, serif or second accent.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#E85D26', color: '#111111', padding: '59px 106px 150px', display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
      <CatalogueNum onOrange />
      <Eyebrow onOrange>Section · 2026</Eyebrow>
    </div>
    <div style={{ display: 'flex', flexDirection: 'column', gap: 22 }}>
      <Title onOrange>the big idea</Title>
      <p style={{ fontFamily: 'Barlow, "Noto Sans SC", system-ui, sans-serif', fontSize: 36, lineHeight: 1.5, color: 'rgba(17,17,17,0.75)', maxWidth: 1000, margin: 0 }}>
        One line that says what this deck argues.
      </p>
    </div>
    <Footer onOrange label="Author · Context" />
  </div>
);
```

## Signature elements

```tsx
const CatalogueNum = ({ onOrange = false }: { onOrange?: boolean }) => {
  const { current } = useSlidePageNumber();
  return (
    <span style={{ fontFamily: '"IBM Plex Mono", ui-monospace, monospace', fontSize: 22, fontWeight: 500, lineHeight: 1, letterSpacing: '0.1em', color: onOrange ? 'rgba(17,17,17,0.45)' : '#505048' }}>
      {String(current).padStart(2, '0')}
    </span>
  );
};

const Bullet = ({ children, onOrange = false }: { children: React.ReactNode; onOrange?: boolean }) => (
  <li style={{ display: 'flex', gap: '0.6em', listStyle: 'none', fontFamily: 'Barlow, sans-serif', fontSize: 36, lineHeight: 1.5 }}>
    <span style={{ fontFamily: '"IBM Plex Mono", monospace', fontWeight: 700, color: onOrange ? 'rgba(17,17,17,0.45)' : '#E85D26' }}>/</span>
    <span>{children}</span>
  </li>
);

const StatCard = ({ value, label, note }: { value: string; label: string; note: string }) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: 11, padding: '22px 22px 22px 0', borderTop: '1px solid #282826' }}>
    <div style={{ fontFamily: 'Barlow, sans-serif', fontSize: 106, fontWeight: 900, lineHeight: 1, letterSpacing: '-0.04em', color: '#E85D26' }}>{value}</div>
    <div style={{ fontFamily: 'Barlow, sans-serif', fontSize: 32, lineHeight: 1.4, color: '#F0ECE5' }}>{label}</div>
    <div style={{ fontFamily: '"IBM Plex Mono", monospace', fontSize: 22, letterSpacing: '0.1em', textTransform: 'uppercase', color: '#505048' }}>{note}</div>
  </div>
);

const Tag = ({ children }: { children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', padding: '0.3em 0.8em', border: '1px solid #E85D26', color: '#E85D26', fontFamily: '"IBM Plex Mono", monospace', fontSize: 22, lineHeight: 1, letterSpacing: '0.14em', textTransform: 'uppercase' }}>
    {children}
  </span>
);

// Fadelist: three words stacked right, opacity 1 / 0.5 / 0.22, opposite a display title.
const FadeWord = ({ children, opacity }: { children: React.ReactNode; opacity: number }) => (
  <span style={{ fontFamily: 'Barlow, sans-serif', fontSize: 144, fontWeight: 900, lineHeight: 0.92, letterSpacing: '-0.03em', color: '#111111', opacity }}>{children}</span>
);

const QuoteMark = () => (
  <div aria-hidden style={{ fontFamily: 'Barlow, sans-serif', fontSize: 192, fontWeight: 900, lineHeight: 0.6, color: '#E85D26' }}>“</div>
);
```

## Do / Don't

- Do write every Barlow line in lowercase or sentence case; mono chrome is always uppercase.
- Do commit each page to one register: orange for cover, chapter, statement payoff and end; ink black for content.
- Do set everything on orange in black ink — headlines `#111111`, body at 75%, chrome at 45–55%.
- Do open content headlines with `Eyebrow` then `Rule`; on a dark statement page, set the punchline itself in orange.
- Do give each page one display moment and at most three `/` bullets.
- Don't uppercase Barlow, set a headline under 700, or drop the negative tracking.
- Don't add a second accent colour, a cream or white page, or cream text on orange.
- Don't use shadows, gradients, border-radius, italics or underline; hairlines and weight carry hierarchy.
- Don't set chrome in Barlow, copy in mono, or add a third typeface.
