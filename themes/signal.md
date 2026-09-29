---
name: Signal
description: "Deep navy canvas with bone paper and a single muted-gold accent; institutional with quiet weight."
mode: dark
mood: [institutional, trustworthy, considered, weighty]
tone: [sober, polished, established, literary]
formality: high
density: high
scheme: mixed
best_for: "Investor decks, board presentations, consulting deliverables, legal/policy briefs, and advisory pitches that want quiet, credible authority."
avoid_for: "Contexts that should feel hot, fast, or intentionally playful — the navy and gold restraint commits to a sober voice."
source: bold:signal
---

# Signal

## Palette

| Role             | Value     | Notes                                              |
| ---------------- | --------- | --------------------------------------------------- |
| bg               | `#1C2644` | navy — primary dark surface                        |
| bg-alt           | `#232F55` | lifted navy for secondary dark panels               |
| bg-light         | `#F0ECE3` | cream — the alternating light surface               |
| bg-light-alt     | `#E6E0D4` | cooler cream for secondary light panels             |
| text             | `#E2DCD0` | warm off-white, primary text on navy                |
| text-muted       | `#8A96A8` | secondary text on navy                              |
| text-hint        | `#4E5A6E` | tertiary text on navy — captions, chrome            |
| text-light       | `#1A2030` | ink, primary text on cream                          |
| text-light-muted | `#5A6270` | secondary text on cream                             |
| accent           | `#C8A870` | antique gold — the only accent, ever                |
| muted            | `#8A96A8` | dividers, secondary chrome (= text-muted)           |
| border           | `#2E3D5C` | hairline on navy                                    |
| border-light     | `#CAC4B4` | hairline on cream                                   |

## Typography

- Display font: `"Source Serif 4", "Noto Serif SC", Georgia, serif` — weight 600–700 for headlines; the face's italic axis in gold is the system's signature "Signal moment."
- Body font: `"DM Sans", "Noto Sans SC", system-ui, sans-serif` — weight 400–500.
- Mono/label font: `"IBM Plex Mono", "JetBrains Mono", monospace` — weight 500, uppercase, 0.14em+ tracking. Carries every kicker, chrome bar, caption, and stat note — never body or headlines.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Source+Serif+4:ital,wght@0,600;0,700;1,600&family=DM+Sans:wght@400;500&family=IBM+Plex+Mono:wght@500&display=swap`
- Type scale (converted from the source's `vw` system at 1920px wide):
  - Display (cover hero): 182px, weight 700, line-height 0.96, letter-spacing -0.02em
  - H1 (chapter/statement): 100px, weight 600, line-height 1.08, letter-spacing -0.01em
  - H2 (primary headline): 58px, weight 600, line-height 1.18
  - H3 (sub-headline): 36px, weight 500, line-height 1.3
  - Stat value: 106px, weight 600, letter-spacing -0.02em, always in accent
  - Lead: 27px, weight 400, line-height 1.58
  - Body: 20px, weight 400, line-height 1.65 — deliberately smaller than slide-authoring's default range; Signal's high-density editorial register relies on it, use sparingly and never for a lone paragraph carrying the page.
  - Caption/label: 16px / 13px, mono, uppercase, 0.14em tracking

## Layout

- Content padding: 144px horizontal, 59px vertical at 1920×1080 (quote/statement pages may go to 1.1×/1.2× for extra breathing room).
- Grid: `grid-template-rows: auto 1fr auto` — a chrome bar and foot bar bracket the body on standard pages. Cover, chapter, statement, quote, and end pages drop the chrome entirely and let type breathe edge to edge.
- Gaps: 43px between major sections, 27px between related elements, 13px between tightly coupled elements.
- Density is medium-low and asymmetric — most of a Signal page is empty. A page that fills the canvas edge to edge reads as broken; split it instead.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Source Serif 4", "Noto Serif SC", Georgia, serif',
      fontSize: 100,
      fontWeight: 600,
      lineHeight: 1.08,
      letterSpacing: '-0.01em',
      margin: 0,
      color: '#E2DCD0',
    }}
  >
    {children}
  </h1>
);

// The "Signal moment": wrap one emphasized phrase per headline in <Em> for
// the roman-to-italic gold mid-sentence shift the system depends on.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'italic', color: '#C8A870' }}>{children}</em>
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
        left: 144,
        right: 144,
        bottom: 59,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingTop: 13,
        borderTop: '1px solid #2E3D5C',
        fontFamily: '"IBM Plex Mono", "JetBrains Mono", monospace',
        fontSize: 13,
        fontWeight: 500,
        letterSpacing: '0.14em',
        textTransform: 'uppercase',
        color: '#4E5A6E',
      }}
    >
      <span>SIGNAL</span>
      <span>
        {String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}
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
      fontFamily: '"IBM Plex Mono", "JetBrains Mono", monospace',
      fontSize: 13,
      fontWeight: 500,
      letterSpacing: '0.14em',
      textTransform: 'uppercase',
      color: '#C8A870',
    }}
  >
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Short, editorial entrances (0.5–0.85s) — never flashy, never bouncy.
- Reusable keyframes:

```css
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(24px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

## Aesthetic

Literary editorial — what a long-form intelligence briefing or a quarterly review from a serious magazine would look like as a deck. Source Serif 4 carries the voice with roman/italic gold mixed mid-sentence; DM Sans carries the substance; IBM Plex Mono carries every timestamp and label. Flat by design — no shadows, no rounded chrome, only hairline separation — with a near-invisible grid texture as the system's fingerprint on dark pages. Navy and cream alternate freely as first-class surfaces. Restraint is the register: one accent color, used sparingly, so that when gold appears it carries weight.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#1C2644',
      color: '#E2DCD0',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
      padding: '0 144px',
      position: 'relative',
    }}
  >
    <GridTexture />
    <Eyebrow>Quarterly Review · Q3 2026</Eyebrow>
    <div style={{ width: 36, height: 1, background: '#C8A870', margin: '20px 0' }} />
    <Title>
      The Big <Em>Idea</Em>
    </Title>
    <p style={{ fontFamily: '"DM Sans", sans-serif', fontSize: 27, color: '#8A96A8', maxWidth: 1200, marginTop: 27 }}>
      A short subtitle that explains what this deck is about.
    </p>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Short gold rule — sits between a kicker and a headline, or as a chapter mark.
const ShortRule = () => <div style={{ width: 36, height: 1, background: '#C8A870' }} />;

// Full hairline divider — section breaks, stat-tile edges, column boundaries.
const HairlineRule = ({ light = false }: { light?: boolean }) => (
  <div style={{ width: '100%', height: 1, background: light ? '#CAC4B4' : '#2E3D5C' }} />
);

// Em-dash bullet marker in mono gold — replaces the standard list dot.
const Bullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ display: 'flex', gap: '0.5em', listStyle: 'none' }}>
    <span
      style={{
        fontFamily: '"IBM Plex Mono", monospace',
        color: '#C8A870',
        flexShrink: 0,
      }}
    >
      —
    </span>
    <span>{children}</span>
  </li>
);

// Near-invisible 80px grid overlay — the system's fingerprint. Navy pages only.
const GridTexture = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      inset: 0,
      pointerEvents: 'none',
      backgroundImage:
        'linear-gradient(rgba(255,255,255,0.03) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.03) 1px, transparent 1px)',
      backgroundSize: '80px 80px',
    }}
  />
);

// Outlined gold tag — the "pill" version of a kicker.
const Tag = ({ children }: { children: React.ReactNode }) => (
  <span
    style={{
      display: 'inline-block',
      border: '1px solid #C8A870',
      color: '#C8A870',
      padding: '0.3em 0.8em',
      fontFamily: '"IBM Plex Mono", monospace',
      fontSize: 13,
      fontWeight: 500,
      letterSpacing: '0.14em',
      textTransform: 'uppercase',
    }}
  >
    {children}
  </span>
);
```

## Do / Don't

- Do mix roman and italic Source Serif 4 inside a headline via `<Em>` — this is the Signal moment; the system depends on it appearing throughout.
- Do use mono uppercase gold for every kicker, tag, and chrome label, with at least 0.14em tracking.
- Do color every statistical numeral in gold serif at -0.02em tracking.
- Do alternate navy and cream freely — neither is "the" background.
- Don't put gold on body text or fill a background with it. Gold marks rules, italic emphasis, and numerals only.
- Don't add drop shadows or rounded chrome. The system is flat plus hairline.
- Don't use serif for body or sans for headlines — the serif/sans/mono ladder is structural.
- Don't fill more than half a page. Signal reads as broken when crowded.
