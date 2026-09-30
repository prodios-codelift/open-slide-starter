---
name: Long Table
description: "One rust-terracotta ink on buttery cream paper: uppercase Bricolage headlines, italic Fraunces body, outlined pills — a supper-club programme."
mode: light
mood: [warm, intimate, small-batch, hospitality]
tone: [warm, playful, considered, modern-editorial]
formality: medium
density: medium
scheme: light
best_for: "Warm, intimate hospitality and community brands: supper clubs, dinner series, small restaurants, studio events, membership pitches, lifestyle and wine brands."
avoid_for: "Decks needing corporate polish, technical density, or a cold minimalist register — the rust ink and bold serif mix are intentionally warm and people-facing."
source: bold:long-table
---

# Long Table

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#FAF1E2` | paper: the only background |
| text | `#B53D2A` | ink: every glyph, border, rule, pill |
| accent | `#B53D2A` | same ink — no second hue; emphasise by scale, italic, opacity |
| muted | `rgba(181,61,42,0.78)` | ink 78% (≈ `#C46553`): metadata, footer label |
| rule-soft | `rgba(181,61,42,0.32)` | ink 32%: 1px internal dividers |
| dot | `rgba(181,61,42,0.5)` | paper-texture dots (layer at 10%) |
| ink-deep | `#8E2D1F` | deeper rust, rare emphasis |
| paper-d | `#F2E5CF` | darker cream, sparing |
| paper-vd | `#E8D7B6` | deepest cream, reserved |

## Typography

- Display font: `"Bricolage Grotesque", "Arial Narrow", system-ui, sans-serif` — 800 (700 for quotes, row names, tracked labels), always UPPERCASE with -0.005 to -0.012em tracking.
- Body font: `"Fraunces", Georgia, "Times New Roman", serif` — 400 **italic by default**; 600 for bold; roman only for card bodies and info keys. `opsz` axes apply automatically.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,700;12..96,800&family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;1,9..144,400;1,9..144,600&display=swap`
- Type scale (source `clamp()` at 1920×1080; small sizes raised to slide-authoring minimums):
  - Jumbo numeral: 400px Fraunces italic 400, lh 0.86, -0.02em
  - Hero (cover): 160px Bricolage 800, lh 0.92 (`Title` default)
  - Section opener 140px · featured title 112px · page headline 108px · menu title 90px — 800, lh 0.92
  - Quote: 80px Bricolage 700, lh 0.95 · card title 48px 800 · row name / info value 36px 700
  - Lede 40px italic lh 1.45 · body 32px italic lh 1.5 · card body 28px roman lh 1.45
  - Tagline 36px italic · edition label 32px italic · pill text 26px italic
  - Meta tag / info key 22px · page number 24px italic · tracked label 22px Bricolage 700, 0.18em

## Layout

- Content padding: 108px top (96 on covers), 120px sides, 128px bottom. Menu/quote pages: 240px sides; featured/calendar: 144px.
- Gaps: 48px between sections, 32px between blocks, 24px between rows, 16px tight.
- Cover: `1fr 440px` grid — hero stack left, `JumboNumeral` right in place of an illustration.
- Content pages: `Topbar`, then 2–4 groups — three `Card`s or 4–6 `Row`s.
- Radii: 999px pills, 50% badges, 0 on everything else. Borders: 1.5px solid ink (structural), 1px ink-32 solid or dashed (internal). No fills, no shadows.
- Layer order: `PaperTexture` first, content `position: 'relative'`, `Footer` last.

## Fixed components

### Title

```tsx
const Title = ({ children, size = 160 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"Bricolage Grotesque", "Arial Narrow", system-ui, sans-serif', fontSize: size, fontWeight: 800, lineHeight: 0.92, letterSpacing: '-0.012em', textTransform: 'uppercase', margin: 0, color: '#B53D2A' }}>
    {children}
  </h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Italic page number on every page: the system's spine.
const Footer = ({ label }: { label: string }) => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 120, right: 120, bottom: 52, display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 24, lineHeight: 1, letterSpacing: '0.02em', color: '#B53D2A' }}>
      <span style={{ opacity: 0.78 }}>{label}</span>
      <span>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Edition marker: badge + italic label are one unit.
const EdBadge = ({ n }: { n: string }) => (
  <span style={{ width: 56, height: 56, flexShrink: 0, borderRadius: '50%', border: '1.5px solid #B53D2A', display: 'inline-flex', alignItems: 'center', justifyContent: 'center', fontSize: 30, lineHeight: 1 }}>{n}</span>
);

const Eyebrow = ({ n, children }: { n?: string; children: React.ReactNode }) => (
  <div style={{ display: 'flex', alignItems: 'center', gap: 18, fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 32, lineHeight: 1, color: '#B53D2A' }}>
    {n && <EdBadge n={n} />}
    <span>{children}</span>
  </div>
);

// Pill = action, RectTag = metadata / status. Outline only, never filled.
const Pill = ({ children }: { children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', border: '1.5px solid #B53D2A', borderRadius: 999, padding: '14px 32px', fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 26, lineHeight: 1, whiteSpace: 'nowrap', color: '#B53D2A' }}>{children}</span>
);
const PillDot = () => <span style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 26, opacity: 0.7 }}>·</span>;
const RectTag = ({ children }: { children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', border: '1.5px solid #B53D2A', padding: '10px 22px', fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 22, lineHeight: 1, whiteSpace: 'nowrap', color: '#B53D2A' }}>{children}</span>
);
```

## Motion

- Philosophy: subtle. Pages cross-fade over 280ms ease; nothing inside a page moves — it is printed paper.

```css
@keyframes ltFade {
  from { opacity: 0; }
  to   { opacity: 1; }
}
```

## Aesthetic

A supper-club poster, Risograph zine or small-press dinner programme: one warm rust ink soaked into cream stock, with a dot grain that reads as paper up close. Uppercase Bricolage shouts the headlines like hand-lettered bills; italic Fraunces carries every paragraph, pill and page number. Structure is only 1.5px ink outlines — pills, edition badges, sharp tags, cards — and faint solid/dashed rules. Covers anchor on a giant italic numeral, not an illustration. Rich but curated. No second colour, fills, shadows, gradients or rounded cards.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#FAF1E2', color: '#B53D2A', padding: '96px 120px 128px', display: 'grid', gridTemplateColumns: '1fr 440px', columnGap: 64, alignItems: 'center' }}>
    <PaperTexture />
    <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', alignItems: 'flex-start', gap: 40 }}>
      <Eyebrow n="3">EDITION 3 · AUTUMN 2026</Eyebrow>
      <Title>The Long Table</Title>
      <p style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 36, lineHeight: 1.35, maxWidth: 1000, margin: 0 }}>A short subtitle that explains what this deck is about.</p>
      <div style={{ display: 'flex', alignItems: 'center', gap: 20 }}>
        <Pill>Reserve a seat</Pill>
        <PillDot />
        <Pill>See the menu</Pill>
      </div>
    </div>
    <JumboNumeral n="3" label="Third edition" meta="48 seats · 6 cities · 1 table" />
    <Footer label="Company · 2026" />
  </div>
);
```

## Signature elements

```tsx
// Risograph paper grain: 4px radial-dot tile at 10% opacity. On EVERY page.
const PaperTexture = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', opacity: 0.1, backgroundImage: 'radial-gradient(circle at 1px 1px, rgba(181,61,42,0.5) 0.5px, transparent 1px)', backgroundSize: '4px 4px' }} />
);

// Cover hero anchor: giant italic numeral + tracked label + italic meta.
const JumboNumeral = ({ n, label, meta }: { n: string; label: string; meta: string }) => (
  <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: 20 }}>
    <div style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 400, fontWeight: 400, lineHeight: 0.86, letterSpacing: '-0.02em' }}>{n}</div>
    <div style={{ borderTop: '1.5px solid #B53D2A', paddingTop: 16, fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 22, fontWeight: 700, letterSpacing: '0.18em', textTransform: 'uppercase' }}>{label}</div>
    <div style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 28, lineHeight: 1.4, opacity: 0.78 }}>{meta}</div>
  </div>
);

// Section opener: headline left, italic label right, 1.5px ink rule beneath.
const Topbar = ({ title, label }: { title: string; label: string }) => (
  <div style={{ position: 'relative', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', gap: 48, paddingBottom: 28, borderBottom: '1.5px solid #B53D2A' }}>
    <Title size={108}>{title}</Title>
    <span style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 26, whiteSpace: 'nowrap' }}>{label}</span>
  </div>
);

// Outlined card: solid rule under meta, dashed above foot — the card rhythm.
const Card = ({ meta, title, foot, children }: { meta: string; title: string; foot: string; children: React.ReactNode }) => (
  <div style={{ border: '1.5px solid #B53D2A', padding: '32px 30px', display: 'flex', flexDirection: 'column', gap: 20 }}>
    <div style={{ borderBottom: '1px solid rgba(181,61,42,0.32)', paddingBottom: 16, fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 22 }}>{meta}</div>
    <h3 style={{ margin: 0, fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 48, fontWeight: 800, lineHeight: 0.95, letterSpacing: '-0.008em', textTransform: 'uppercase' }}>{title}</h3>
    <p style={{ margin: 0, fontFamily: '"Fraunces", Georgia, serif', fontSize: 28, lineHeight: 1.45 }}>{children}</p>
    <div style={{ marginTop: 'auto', borderTop: '1px dashed rgba(181,61,42,0.32)', paddingTop: 16, fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 22, opacity: 0.78 }}>{foot}</div>
  </div>
);

// Menu / ledger row. Stack 4–6.
const Row = ({ num, name, note, tag }: { num: string; name: string; note: string; tag: string }) => (
  <div style={{ display: 'grid', gridTemplateColumns: '88px 1fr auto', alignItems: 'baseline', gap: 32, padding: '18px 0', borderBottom: '1px solid rgba(181,61,42,0.32)' }}>
    <span style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 26 }}>{num}</span>
    <div>
      <div style={{ fontFamily: '"Bricolage Grotesque", system-ui, sans-serif', fontSize: 36, fontWeight: 700, lineHeight: 1.05, letterSpacing: '-0.005em', textTransform: 'uppercase' }}>{name}</div>
      <div style={{ fontFamily: '"Fraunces", Georgia, serif', fontStyle: 'italic', fontSize: 28, lineHeight: 1.4, opacity: 0.78, marginTop: 6 }}>{note}</div>
    </div>
    <RectTag>{tag}</RectTag>
  </div>
);
```

## Do / Don't

- Do render every mark in the one ink; vary only opacity (100 / 78 / 32 / 10%).
- Do put `PaperTexture` and the `Footer` page number on every page.
- Do set body in italic Fraunces; roman only for card bodies and info keys; bold = 600.
- Do anchor covers with `JumboNumeral`; pair every `EdBadge` with its label.
- Do use `Pill` for actions, `RectTag` for metadata — never swap them.
- Don't add a second hue, fill a shape, or use shadows, gradients or blur.
- Don't exceed 1.5px borders or use radii other than 999px, 50%, 0.
- Don't set Bricolage in sentence case or Fraunces roman by default.
- Don't crowd: one display moment + 2–4 groups; a lone headline reads unfinished.
- CJK: lead both stacks with Noto Serif SC (700 / 400), upright, tracking 0, no uppercase, looser line-height.
