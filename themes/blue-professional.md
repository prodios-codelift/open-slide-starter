---
name: Blue Professional
description: "Warm cream paper with a single electric cobalt accent, Space Grotesk headlines and soft tinted cards; clean, modern, consulting-grade."
mode: light
mood: [professional, modern, calm, trustworthy]
tone: [clean, considered, polished, neutral]
formality: high
density: medium
scheme: light
best_for: "B2B SaaS pitches, consulting deliverables, advisory updates, investor reports and research syntheses that should feel modern, considered and lightly authoritative without going stiff."
avoid_for: "Decks that should feel hot, playful or intentionally informal, where the cool electric-blue restraint reads as overly polished."
source: bold:blue-professional
---

# Blue Professional

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#FDFAE7` | warm cream on every page; never white or grey |
| text | `#111111` | near-black: headlines, labels |
| accent | `#1E2BFA` | electric cobalt, the only accent |
| muted | `#6B6B6B` | body copy, descriptions, counter |
| text-light | `#9A9A9A` | meta lines, stat context |
| accent-light | `rgba(30,43,250,0.08)` | tag pills, bar tracks, highlights, cover panel |
| accent-medium | `rgba(30,43,250,0.15)` | darker tint, sparingly |
| border | `rgba(30,43,250,0.2)` | every card border, divider, ring |
| card-bg | `rgba(30,43,250,0.04)` | universal card fill |
| positive | `#059669` | up-change text only |
| negative | `#DC2626` | down-change text only |

## Typography

- Display: `"Space Grotesk", system-ui, sans-serif`: 700 cover title and numerals, 600 headings and eyebrows, 500 sub-heads, tags, counters. Headings take -0.02em and stay near-black, never cobalt.
- Body: `"Inter", system-ui, -apple-system, sans-serif`: 400 in muted grey, line-height 1.6; 500–600 only for stat/metric labels in `#111111`.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap`
- Type scale (source caps at web sizes, h1 67px / body 17px at 1920, so all sizes scale ~2.1×):
  - Hero 144px / 700 / lh 1.1 · page heading 80px / 600 / lh 1.1 · sub-head 44px / 500 / lh 1.3
  - Metric 104px · stat 72px · agenda number 60px: 700, lh 1, cobalt
  - Quote 80px / 500 / lh 1.35 · quote mark 280px / 700, cobalt at 15% opacity
  - Lead 40px · body 34px Inter 400 lh 1.6 · metric label 36px Inter 600 · caption 28px
  - Eyebrow 26px / 600 / 0.08em uppercase cobalt · tag, counter, meta, cite 24px Space Grotesk
- CJK: Noto Sans SC for display roles, Noto Serif SC for body; tracking 0, no uppercase, line-height +20%.

## Layout

- Padding 120px sides and top, 160px bottom (usable 1680 × 800); the extra clears the counter and progress bar.
- Content pages: `SlideHeader` → 48px → `Heading` → 64px → one region: 3-column metric row (gap 48), 2×3 stat grid (gap 40), 1.05fr / 1fr split (gap 120, right column `borderLeft: '2px solid rgba(30,43,250,0.2)'`), or a 4-step timeline. Cover, quote and closing pages drop the header.
- Chrome scales 2× with the type: radii 20–28px, borders 2–3px, accent line 120×8.
- Density medium: 3–6 information cells per page. If a page feels sparse, add substance, not decoration.

## Fixed components

### Title

```tsx
// Cover and closing only. Content pages use Heading.
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 144, fontWeight: 700, lineHeight: 1.1, letterSpacing: '-0.02em', margin: 0, color: '#111111' }}>
    {children}
  </h1>
);

const Heading = ({ children }: { children: React.ReactNode }) => (
  <h2 style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 80, fontWeight: 600, lineHeight: 1.1, letterSpacing: '-0.02em', margin: 0, color: '#111111' }}>
    {children}
  </h2>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

// Counter bottom-left, meta bottom-right, 6px cobalt progress bar on the bottom edge.
const Footer = () => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    <>
      <div style={{ position: 'absolute', left: 120, right: 120, bottom: 56, display: 'flex', justifyContent: 'space-between', fontFamily: '"Space Grotesk", sans-serif', fontSize: 24, letterSpacing: '0.05em' }}>
        <span style={{ fontWeight: 500, color: '#6B6B6B' }}>{pad(current)} / {pad(total)}</span>
        <span style={{ color: '#9A9A9A' }}>Company · Confidential</span>
      </div>
      <div style={{ position: 'absolute', left: 0, bottom: 0, height: 6, width: `${(current / total) * 100}%`, background: '#1E2BFA' }} />
    </>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 26, fontWeight: 600, lineHeight: 1.1, letterSpacing: '0.08em', textTransform: 'uppercase', color: '#1E2BFA' }}>
    {children}
  </div>
);

const TagPill = ({ children }: { children: React.ReactNode }) => (
  <span style={{ padding: '12px 30px', borderRadius: 100, background: 'rgba(30,43,250,0.08)', fontFamily: '"Space Grotesk", sans-serif', fontSize: 24, fontWeight: 500, lineHeight: 1, color: '#1E2BFA' }}>
    {children}
  </span>
);

// Opens every content page: eyebrow left, tag pill right.
const SlideHeader = ({ eyebrow, tag }: { eyebrow: string; tag: string }) => (
  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 48 }}>
    <Eyebrow>{eyebrow}</Eyebrow>
    <TagPill>{tag}</TagPill>
  </div>
);

// Short cobalt rule above cover titles and between blocks on open pages.
const AccentLine = () => <div style={{ width: 120, height: 8, borderRadius: 4, background: '#1E2BFA' }} />;
```

## Motion

- Philosophy: subtle. Content eases in from a slight right offset and bar fills grow from zero (0.8s ease, `transformOrigin: 'left'`); nothing bounces. Inject with the `<style>` pattern in `webfonts.md`.

```css
@keyframes enter { from { opacity: 0; transform: translateX(12px); } to { opacity: 1; transform: translateX(0); } }
@keyframes barGrow { from { transform: scaleX(0); } to { transform: scaleX(1); } }
```

## Aesthetic

Consulting-grade restraint with one strong commitment: warm cream paper and a single saturated cobalt carrying every eyebrow, numeral, rule, bar and CTA, like an investment-research report or a board briefing. Space Grotesk speaks for headings and numbers; Inter explains in muted grey. Depth is soft and tinted: cards are 4% cobalt washes with 20% cobalt borders and rounded corners, never shadowed or outlined in solid colour. Pills and circles soften the chrome; a diagonal panel, dot grid and concentric rings appear only on cover, quote and closing pages. No second accent, no square corners, no italics or underlines.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#FDFAE7', padding: '120px 120px 160px', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <CoverDecoration />
    <CoverDots style={{ position: 'absolute', top: 120, right: 120 }} />
    <div style={{ position: 'relative', maxWidth: 1240, display: 'flex', flexDirection: 'column', gap: 40 }}>
      <AccentLine />
      <Eyebrow>Advisory · 2026</Eyebrow>
      <Title>The Big Idea</Title>
      <p style={{ fontFamily: '"Inter", sans-serif', fontSize: 40, lineHeight: 1.6, color: '#6B6B6B', maxWidth: 1000, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
      <div style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 24, letterSpacing: '0.05em', color: '#9A9A9A' }}>October 2026 · Confidential</div>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Diagonal cobalt-tint panel over the right 35% of cover and closing pages.
const CoverDecoration = () => (
  <div aria-hidden style={{ position: 'absolute', top: 0, right: 0, bottom: 0, width: '35%', background: 'rgba(30,43,250,0.08)', clipPath: 'polygon(30% 0, 100% 0, 100% 100%, 0% 100%)' }} />
);

// 3×3 grid of 12px cobalt dots at 24px gaps, 25% opacity. Open-space pages only.
const CoverDots = ({ style }: { style?: React.CSSProperties }) => (
  <div aria-hidden style={{ width: 108, height: 108, opacity: 0.25, backgroundImage: 'radial-gradient(circle, #1E2BFA 6px, transparent 6.5px)', backgroundSize: '36px 36px', ...style }} />
);

// Closing pages: <Ring size={1000} opacity={0.4} /> and <Ring size={720} opacity={0.3} />.
const Ring = ({ size, opacity }: { size: number; opacity: number }) => (
  <div aria-hidden style={{ position: 'absolute', top: '50%', left: '50%', width: size, height: size, transform: 'translate(-50%, -50%)', borderRadius: '50%', border: '2px solid rgba(30,43,250,0.2)', opacity }} />
);

// Universal card: 4% fill, 20% border, soft radius (stat cells: 2px border, 24px radius).
// Holds a cobalt Space Grotesk numeral, an Inter 600 label, then <Change>.
const Card = ({ children }: { children: React.ReactNode }) => (
  <div style={{ background: 'rgba(30,43,250,0.04)', border: '3px solid rgba(30,43,250,0.2)', borderRadius: 28, padding: '48px 52px' }}>{children}</div>
);

// Directional chip: text colour only, no fill or border.
const Change = ({ children, up = true }: { children: React.ReactNode; up?: boolean }) => (
  <span style={{ fontFamily: '"Space Grotesk", sans-serif', fontSize: 26, fontWeight: 600, color: up ? '#059669' : '#DC2626' }}>{up ? '↑' : '↓'} {children}</span>
);

// Bar: solid cobalt on an 8% track. Label Inter 500 32px; value cobalt Space Grotesk 600.
const Bar = ({ pct }: { pct: number }) => (
  <div style={{ height: 56, borderRadius: 12, background: 'rgba(30,43,250,0.08)' }}>
    <div style={{ width: `${pct}%`, height: '100%', borderRadius: 12, background: '#1E2BFA' }} />
  </div>
);

// Timeline marker; fade future steps 1 → 0.85 → 0.7 → 0.55.
const StepCircle = ({ n, opacity = 1 }: { n: number; opacity?: number }) => (
  <div style={{ width: 112, height: 112, borderRadius: '50%', background: '#1E2BFA', opacity, display: 'grid', placeItems: 'center', fontFamily: '"Space Grotesk", sans-serif', fontSize: 44, fontWeight: 700, color: '#FDFAE7' }}>{n}</div>
);

// Pull-quote in a split: 8% tint, 8px cobalt left rule; follow with a 24px uppercase cite.
const Highlight = ({ children }: { children: React.ReactNode }) => (
  <div style={{ background: 'rgba(30,43,250,0.08)', borderLeft: '8px solid #1E2BFA', borderRadius: 24, padding: '40px 48px', fontFamily: '"Space Grotesk", sans-serif', fontSize: 44, fontWeight: 500, lineHeight: 1.4, color: '#111111' }}>{children}</div>
);

// The only solid element: one cobalt pill CTA per closing page.
const Cta = ({ children }: { children: React.ReactNode }) => (
  <span style={{ display: 'inline-block', padding: '28px 72px', borderRadius: 100, background: '#1E2BFA', color: '#FDFAE7', fontFamily: '"Space Grotesk", sans-serif', fontSize: 32, fontWeight: 600 }}>{children}</span>
);
```

## Do / Don't

- Do keep cream on every page and cobalt as the only accent.
- Do open every content page with `SlideHeader`, then one `Heading`.
- Do set every numeral in cobalt Space Grotesk 600–700, list counters ("01", "02") and bar values included.
- Do build depth from tint, soft border and radius; pills for tags and CTAs.
- Don't set headlines in cobalt, or body in black or uppercase.
- Don't add a second accent; separate chart series by position and label.
- Don't use drop shadows, square corners (progress bar excepted) or solid cobalt borders.
- Don't substitute Space Grotesk or Inter, or swap their roles.
- Don't put the panel, dots or rings on dense content pages.
