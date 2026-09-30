---
name: Pink Script (After Hours)
description: "Black canvas, hot pink accent, pearl-cream paper, DM Serif Display headlines: late-night editorial luxury."
mode: dark
mood: [nocturnal, moody, intentional, luxe, expressive]
tone: [literary, sultry, considered, magazine]
formality: high
density: low
scheme: dark
best_for: "Fashion, creator, after-hours/nightlife, and luxury product decks that want to feel nocturnal, intentional and a little luxe — also a striking unexpected pick for a keynote or pitch that wants magnetic confidence."
avoid_for: "Daytime corporate-professional and traditional B2B contexts where the dark canvas and hot-pink accent read as too styled or too expressive."
source: bold:pink-script
---

# Pink Script (After Hours)

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#060507` | ink-deep, base surface — always paired with the lit radial gradient (see Layout) |
| text | `#F5EDF1` | paper-blush, primary copy and editorial headlines |
| accent | `#ED3D8C` | hot fuchsia pink — the single chromatic accent, ever |
| muted | `rgba(245,237,241,0.55)` | mute-paper, secondary copy and metadata |
| bg-alt | `#0F0D11` | ink-violet, reserved alternate dark — rarely used |
| accent-light | `#FF66A8` | pink-light, reserved, not active in current components |
| accent-deep | `#B81D67` | pink-deep, reserved, not active in current components |
| line | `rgba(237,61,140,0.32)` | line-pink, table row dividers, chart axis lines |
| hairline | `rgba(245,237,241,0.14)` | hair-paper, interior frame, dim pill borders, muted dividers |

## Typography

- Display font: `"DM Serif Display", Georgia, serif` — weight 400 only (the face has one weight). Carries every script and editorial moment, 32px up to 600px. No second display face, ever.
- Body font: `"Inter", system-ui, sans-serif` — weight 300 for all prose; the ultra-light weight is the calm voice, never switch to 400+.
- Mono/label font: `"JetBrains Mono", monospace` — weight 400, always uppercase, 0.08em+ tracking. Carries every kicker, runner, footer, and page-number string.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=DM+Serif+Display&family=Inter:wght@300;400;500&family=JetBrains+Mono:wght@400;500&display=swap`
- Type scale:
  - Cover / hero script: 280px, DM Serif Display 400, line-height 1.02, letter-spacing -0.015em, color pink, halo glow
  - Section-divider mega numeral: 600px — divider slides only, deliberately oversized
  - Editorial headline (canonical Title size): 140px, DM Serif Display 400, line-height 1.06, color paper-blush
  - Body: 24px, Inter 300, line-height 1.55
  - Muted lead / description: 22px, Inter 300, line-height 1.5, mute-paper
  - Kicker / eyebrow: 22px, JetBrains Mono 400, uppercase, 0.14em tracking, pink
  - Runner / footer chrome: 24px, JetBrains Mono 400, uppercase, 0.14em tracking

## Layout

- Content area: `inset 140px 60px` (140px top/bottom reserve for runner + footer chrome, 60px side margins), 1920×1080.
- The 1px hairline interior frame sits at `inset: 36px` on every slide, unconditionally — the editorial border of the page.
- Rhythm: one hero moment (a pink script title) taking 60–70% of the canvas, the rest generous negative space holding 2–4 small fragments (kicker, one paragraph, chrome). Don't crowd multiple equal-weight regions — split the page instead.
- A top runner (brand name pink, left; section tag muted, right) and bottom footer bracket every page at 60px inset.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"DM Serif Display", Georgia, serif', fontSize: 140, fontWeight: 400, lineHeight: 1.06, margin: 0, paddingBottom: '0.1em', color: '#F5EDF1' }}>{children}</h1>
);

// Inline emphasis: wrap one word to switch it to pink. Font-style stays upright.
const Em = ({ children }: { children: React.ReactNode }) => (
  <em style={{ fontStyle: 'normal', color: '#ED3D8C' }}>{children}</em>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 60, right: 60, bottom: 60, display: 'flex', justifyContent: 'space-between', fontFamily: '"JetBrains Mono", monospace', fontSize: 24, letterSpacing: '0.14em', textTransform: 'uppercase', color: 'rgba(245,237,241,0.55)' }}>
      <span>AFTER HOURS</span>
      <span style={{ color: '#F5EDF1' }}><Em>{String(current).padStart(2, '0')}</Em> / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: '"JetBrains Mono", monospace', fontSize: 22, letterSpacing: '0.14em', textTransform: 'uppercase', color: '#ED3D8C' }}>{children}</div>
);
```

## Motion

- Philosophy: static. The atmosphere (grain, glow, gradient) does the work; titles and copy cut in with no entrance animation, matching the source's photographic stillness.

## Aesthetic

A nocturnal couture editorial system: a deep warm-black surface lit from the upper-left by a slightly warmer ellipse, fading to near-black across the lower-right, with a faint film-grain overlay and a hairline interior frame on every page. DM Serif Display in hot fuchsia carries every script moment; paper-blush carries editorial ink; Inter at weight 300 carries prose; JetBrains Mono uppercase carries chrome. No box-shadows, no rounded corners, no second chromatic accent — depth is atmospheric (gradient, grain, pink halo glow) rather than structural. Reads as a Maison's seasonal lookbook, not a startup deck.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: 'radial-gradient(ellipse 90% 70% at 30% 30%, #1A1218 0%, #0A0709 55%, #050306 100%)', color: '#F5EDF1', padding: '140px 60px', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <Atmosphere />
    <Eyebrow>FINANCE · Q3 2026</Eyebrow>
    <Title>
      Quarterly <Em>Business</Em> Review
    </Title>
    <p style={{ fontFamily: '"Inter", system-ui, sans-serif', fontSize: 22, fontWeight: 300, lineHeight: 1.5, color: 'rgba(245,237,241,0.55)', maxWidth: 1100, marginTop: 32 }}>
      A short subtitle that explains what this deck is about.
    </p>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// Non-optional on every slide: film grain + hairline interior frame. Pair with the
// slide-surface radial gradient set as the page's own background (see Example usage).
const Atmosphere = () => (
  <>
    <div aria-hidden style={{ position: 'absolute', inset: 0, opacity: 0.08, mixBlendMode: 'screen', pointerEvents: 'none', background: 'url("data:image/svg+xml,%3Csvg xmlns=%27http://www.w3.org/2000/svg%27%3E%3Cfilter id=%27n%27%3E%3CfeTurbulence type=%27fractalNoise%27 baseFrequency=%270.9%27 numOctaves=%272%27/%3E%3C/filter%3E%3Crect width=%27100%25%27 height=%27100%25%27 filter=%27url(%23n)%27/%3E%3C/svg%3E")' }} />
    <div aria-hidden style={{ position: 'absolute', inset: 36, border: '1px solid rgba(245,237,241,0.14)', pointerEvents: 'none' }} />
  </>
);

// The true "pink script" hero moment — 220px+, always pink, always glowing.
// Use in place of Title when a slide's whole purpose is the giant script word.
const HeroScript = ({ children, size = 280 }: { children: React.ReactNode; size?: number }) => (
  <h1 style={{ fontFamily: '"DM Serif Display", Georgia, serif', fontSize: size, fontWeight: 400, lineHeight: 1.02, letterSpacing: '-0.015em', margin: 0, paddingBottom: '0.12em', color: '#ED3D8C', textShadow: '0 0 80px rgba(237,61,140,0.18)' }}>{children}</h1>
);

// Top runner chrome — brand pink on the left, section tag muted on the right.
const Runner = ({ section }: { section: string }) => (
  <div style={{ position: 'absolute', top: 60, left: 60, right: 60, display: 'flex', justifyContent: 'space-between', fontFamily: '"JetBrains Mono", monospace', fontSize: 24, letterSpacing: '0.14em', textTransform: 'uppercase' }}>
    <span style={{ color: '#ED3D8C' }}>AFTER HOURS</span>
    <span style={{ color: 'rgba(245,237,241,0.55)' }}>{section}</span>
  </div>
);

// Hairline separators: pink for a soft section break, paper for a muted one.
const PinkRule = () => <div style={{ height: 1, background: '#ED3D8C', opacity: 0.45 }} />;
const HairRule = () => <div style={{ height: 1, background: '#F5EDF1', opacity: 0.25 }} />;

// Left-rule callout — anchors a stat or aside beside a chart or explanation.
const CalloutRail = ({ children }: { children: React.ReactNode }) => (
  <div style={{ borderLeft: '1px solid #ED3D8C', paddingLeft: 24 }}>{children}</div>
);
```

## Do / Don't

- Do apply `Atmosphere` (grain + hairline frame) plus the radial-gradient background to every slide — all three together, never fewer.
- Do keep pink as the only chromatic accent: script color, kicker, rule, `Em`, pill, halo. No second hue.
- Do use `Em` inside a paper-blush headline to switch one word to pink; keep it upright, never italic.
- Do add `paddingBottom: '0.1em'` (`.12em` for `HeroScript`) to every DM Serif Display headline to compensate its descenders.
- Do let one hero moment dominate 60–70% of the canvas; leave the rest as negative space.
- Don't put body copy in DM Serif Display, or a headline in Inter — the voices don't swap.
- Don't add box-shadows or rounded corners; depth is the gradient, the grain, and the pink glow only.
- Don't render pink text directly on the paper-blush surface — the contrast inverts and reads as a mistake.
- Don't crowd a slide with multiple equally-weighted regions; split it instead.
