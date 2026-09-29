---
name: Split Pastel
description: "Peach and lavender halves, Outfit at 800, and ink-outlined pastel badge pills over a soft grid."
mode: light
mood: [playful, friendly, fresh, creative]
tone: [warm, approachable, upbeat, casual]
formality: low
density: low
scheme: light
best_for: "Workshops, onboarding, product walkthroughs, creative pitches, and community or education talks that should feel warm, approachable, and a little playful."
avoid_for: "Board reports, financial reviews, or anything that must read as severe. The candy pastels undercut gravity, and the split halves leave little room for dense tables."
source: preset
derived: true
---

# Split Pastel

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#F5E6DC` | peach, the left panel and primary surface |
| bg-alt | `#E4DFF0` | lavender, the right panel, always carrying the grid |
| text | `#1A1A1A` | near-black ink, all text on both panels |
| accent | `#1A1A1A` | ink fill for the CTA and badge icon discs; colour comes from badges |
| muted | `#5A5560` | leads, captions, secondary copy on both panels |
| badge-mint | `#C8F0D8` | default badge and eyebrow fill |
| badge-yellow | `#F0F0C8` | badge fill |
| badge-pink | `#F0D4E0` | badge fill |
| grid-line | `#D5CEE8` | 2px grid lines on the lavender panel |
| border | `#1A1A1A` | 2px ink outline on every pill |

## Typography

- Display font: `"Outfit", system-ui, -apple-system, "Segoe UI", sans-serif`, weight 800 for titles, 700 for headings and the CTA, tight tracking.
- Body font: the same Outfit stack, weight 400 for body and leads, 500 for badges and labels.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;700;800&display=swap`
- Type scale:
  - Title (cover and section): 120px, weight 800, line-height 1, letter-spacing -0.03em. Below the 140–200px hero range on purpose: it lives in a 744px half panel.
  - Page heading: 72px, weight 700, line-height 1.08, letter-spacing -0.02em
  - Big number (right panel): 160px, weight 800, line-height 1, letter-spacing -0.04em
  - Lead: 36px, weight 400, line-height 1.4, muted
  - Body: 32px, weight 400, line-height 1.5
  - CTA: 28px, weight 700
  - Badge: 30px, weight 500
  - Label (eyebrow, footer): 22px, weight 500, uppercase, letter-spacing 0.1em

## Layout

- Every page splits in half at a hard seam at x = 960, with no divider line, only the colour change.
- The peach left panel holds the words (eyebrow, title, lead, CTA). The lavender right panel holds the proof: a badge cluster, a big number, three or four bullets, or a small chart.
- Padding is 120px from the canvas edges and 96px each side of the seam, so both columns are 744px wide (x 120–864 and 1056–1800). The Footer sits 60px from the bottom.
- Covers and section openers centre both columns vertically. Content pages top-align both at y = 120.
- Text never crosses the seam. One idea per side, at most four items on the right.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"Outfit", system-ui, sans-serif',
      fontSize: 120,
      fontWeight: 800,
      lineHeight: 1,
      letterSpacing: '-0.03em',
      margin: 0,
      color: '#1A1A1A',
    }}
  >
    {children}
  </h1>
);
```

### Footer

Wordmark on peach, page-number pill on lavender (filled, so the grid doesn't cross the numerals).

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
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
        fontFamily: '"Outfit", system-ui, sans-serif',
        fontSize: 22,
        fontWeight: 500,
        letterSpacing: '0.1em',
        textTransform: 'uppercase',
        color: '#1A1A1A',
      }}
    >
      <span>SPLIT PASTEL</span>
      <span style={{ padding: '6px 20px', borderRadius: 999, border: '2px solid #1A1A1A', background: '#E4DFF0' }}>
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
      display: 'inline-flex', alignItems: 'center', alignSelf: 'flex-start', gap: 12,
      padding: '10px 24px',
      borderRadius: 999,
      border: '2px solid #1A1A1A',
      background: '#C8F0D8',
      fontFamily: '"Outfit", system-ui, sans-serif',
      fontSize: 22,
      fontWeight: 500,
      letterSpacing: '0.1em',
      textTransform: 'uppercase',
      color: '#1A1A1A',
    }}
  >
    <span aria-hidden>✦</span>
    {children}
  </div>
);
```

## Motion

- Philosophy: subtle. Text fades up (400ms ease-out); badges pop in with a slight overshoot, 80ms apart, on `cubic-bezier(0.34, 1.4, 0.64, 1)`. Panels and grid never move.

```css
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(24px); }
  to   { opacity: 1; transform: translateY(0); }
}
@keyframes popIn {
  from { opacity: 0; transform: scale(0.9); }
  to   { opacity: 1; transform: scale(1); }
}
```

Badge tilt uses the separate `rotate` property, so `popIn` on `transform` doesn't flatten it.

## Aesthetic

The friendly register of a modern product landing page or a studio workshop deck. Two soft halves, warm peach against cool lavender, with a quiet graph-paper grid on the lavender side. Outfit's round geometric forms carry every word, and hierarchy comes from weight (800 against 400), not a second typeface. Colour comes from candy-pastel badge pills in mint, yellow, and pink, each with a 2px ink outline and an ink icon disc so they read as stickers instead of dissolving into the pastel ground. Pills, discs, and the CTA are fully rounded. Ink is the only strong colour: no gradients, shadows, saturated accents, or illustrations.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', fontFamily: '"Outfit", system-ui, sans-serif', color: '#1A1A1A' }}>
    <SplitPanels />
    <div style={{ position: 'absolute', left: 120, top: 120, bottom: 120, width: 744, display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: 40 }}>
      <Eyebrow>Chapter 01</Eyebrow>
      <Title>The Big Idea</Title>
      <p style={{ margin: 0, fontSize: 36, lineHeight: 1.4, color: '#5A5560' }}>
        A short subtitle that explains what this deck is about.
      </p>
      <CTA>Let's begin</CTA>
    </div>
    <div style={{ position: 'absolute', left: 1056, right: 120, top: 120, bottom: 120, display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', gap: 48 }}>
      <Badge tone="mint" icon="✦" tilt={-3} style={{ marginRight: 160 }}>Fresh ideas</Badge>
      <Badge tone="yellow" icon="★" tilt={2} style={{ marginLeft: 200 }}>Quick wins</Badge>
      <Badge tone="pink" icon="✓" tilt={-2} style={{ marginRight: 40 }}>Made together</Badge>
    </div>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// The split: peach left, lavender right, hard seam at x = 960. The lavender half always
// carries the graph-paper grid. Render it first inside a position: relative page root.
const SplitPanels = () => (
  <>
    <div aria-hidden style={{ position: 'absolute', top: 0, bottom: 0, left: 0, width: 960, background: '#F5E6DC' }} />
    <div
      aria-hidden
      style={{
        position: 'absolute', top: 0, bottom: 0, left: 960, right: 0,
        background: '#E4DFF0',
        backgroundImage: 'linear-gradient(#D5CEE8 2px, transparent 2px), linear-gradient(90deg, #D5CEE8 2px, transparent 2px)',
        backgroundSize: '60px 60px',
      }}
    />
  </>
);

// Playful badge pill with an icon: pastel fill, 2px ink outline, and an ink disc holding
// a glyph (✦ ✓ ★ ● →) or a 20px inline SVG. Tilt ±2–4° in clusters, never in lists.
const BADGE = { mint: '#C8F0D8', yellow: '#F0F0C8', pink: '#F0D4E0' } as const;
type BadgeProps = { children: React.ReactNode; icon?: React.ReactNode; tone?: keyof typeof BADGE; tilt?: number; style?: React.CSSProperties };
const Badge = ({ children, icon = '✦', tone = 'mint', tilt = 0, style }: BadgeProps) => (
  <div
    style={{
      display: 'inline-flex', alignItems: 'center', gap: 16,
      padding: '12px 32px 12px 12px',
      borderRadius: 999,
      border: '2px solid #1A1A1A',
      background: BADGE[tone],
      fontFamily: '"Outfit", system-ui, sans-serif',
      fontSize: 30,
      fontWeight: 500,
      color: '#1A1A1A',
      whiteSpace: 'nowrap',
      rotate: `${tilt}deg`,
      ...style,
    }}
  >
    <span aria-hidden style={{ width: 52, height: 52, borderRadius: '50%', background: '#1A1A1A', color: BADGE[tone], display: 'inline-flex', alignItems: 'center', justifyContent: 'center', fontSize: 26 }}>
      {icon}
    </span>
    {children}
  </div>
);

// Rounded CTA button: ink pill, peach text, arrow. One per deck, on the cover or closer.
const CTA = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      display: 'inline-flex', alignItems: 'center', alignSelf: 'flex-start', gap: 16,
      padding: '22px 44px',
      borderRadius: 999,
      background: '#1A1A1A',
      color: '#F5E6DC',
      fontFamily: '"Outfit", system-ui, sans-serif',
      fontSize: 28,
      fontWeight: 700,
    }}
  >
    {children}
    <span aria-hidden>→</span>
  </div>
);
```

## Do / Don't

- Do split every page at x = 960: words on peach, proof on lavender.
- Do keep the grid on the lavender half only; the peach half stays plain.
- Do outline every pill (eyebrow, badge, page number) in 2px ink, or pastel fills vanish against the pastel panels.
- Do tilt clustered badges a few degrees and cycle the three tones. Badges in a list stay straight.
- Don't set text in a pastel colour. Pastels are fills; text is ink or muted.
- Don't add a saturated accent, gradients beyond the grid, or drop shadows.
- Don't use sharp-cornered boxes for UI elements; use pills and circles.
- Don't run text across the seam, and don't add illustrations or emoji.
