---
name: BlockFrame
description: "Neobrutalist deck with pastel-neon color blocks, chunky black borders and hard offset shadows."
mode: light
mood: [bold, playful, graphic, fresh]
tone: [confident, graphic, pop, design-led]
formality: medium
density: high
scheme: light
best_for: "Pop-graphic, design-led decks (SaaS launches, agency credentials, brand reviews), and a confident, contemporary pick for tech or finance."
avoid_for: "Contexts that need quiet institutional restraint or traditional weight, such as regulated disclosures or formal legal briefs."
source: bold:block-frame
---

# BlockFrame

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#FFFDF5` | warm off-white canvas |
| text | `#000000` | every border, shadow, headline and body |
| accent | `#F7CB46` | yellow: CTA tab, notch, list numbers, close shadow |
| muted | `rgba(0,0,0,0.6)` | step numerals only; no grey text |
| card | `#FFFFFF` | card, pill and counter fill |
| pink | `#FE90E8` | ground, star, 1st chart series |
| blue | `#C0F7FE` | ground, pill, 2nd series |
| green | `#99E885` | ground, stripes, 3rd series |
| cream | `#FFDC8B` | ground, pill, extra series |
| close | `#000000` | closing ground, white text |

Pastels are full grounds and card fills, not light accents, and carry no meaning.

## Typography

- Display: `"Inter", system-ui, -apple-system, sans-serif` — 900 hero, quotes, stats; 800 headlines; 700 card titles. Always uppercase, negative tracking.
- Body: Inter 500, sentence case, lh 1.6 (1.5 in cards).
- Label: `"Space Grotesk", ui-monospace, monospace` — 600 pills, 700 counter, 500 subtitle; uppercase, 0.05–0.1em (subtitles sentence case).
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Inter:wght@500;700;800;900&family=Space+Grotesk:wght@500;600;700&display=swap`
- Type scale (source caps at hero 96 / body 20; scaled to slide-authoring's range):
  - Hero 144px / 900 / lh 0.95 / -0.03em · close title 128px, same
  - Headline 88px / 800 / lh 1 / -0.02em · region title 56px / 700 / -0.01em
  - Quote 72px / 900 / lh 1.15, uppercase · stat 112px / 900 / lh 1
  - Card title 36px / 700 uppercase · step number 72px / 900, opacity 0.6
  - Body 32px · card body 28px · subtitle 32px Space Grotesk 500
  - Pill 22px / 600 / 0.08em · counter 22px / 700 / 0.1em
- CJK: `"Noto Sans SC"` for all roles, tracking 0, no uppercase, lh +20%.

## Layout

- Padding 120px (usable 1680 × 840); gaps 64 / 48 / 32 / 24; card padding 72 (hero, quote), 48 (feature), 40 (stat).
- Borders and shadows stay literal at 1920: ladder 4 / 3 / 2px, never 1px or 5px+.
- Every region: label pill → uppercase headline → content. Dense: 3–6 cards and at least one decoration; emptiness reads broken.
- Cards on grounds: pastel or off-white ground, white 4px card, 3px chrome inside.
- Cycle grounds: off-white cover → blue → off-white → green → pink → yellow → cream → black close.
- Decorations are absolute and come before content in the DOM, so the `position: relative` card paints over them. 120px bottom padding clears the counter.

## Fixed components

### Title

```tsx
// Cover scale. Page headlines: 88px, weight 800, '-0.02em', lineHeight 1.
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"Inter", system-ui, -apple-system, sans-serif', fontSize: 144, fontWeight: 900, lineHeight: 0.95, letterSpacing: '-0.03em', textTransform: 'uppercase', margin: 0, color: '#000000' }}>
    {children}
  </h1>
);
```

### Footer

The source's slide counter: a bordered pill, bottom-left.

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  const pad = (n: number) => String(n).padStart(2, '0');
  return (
    <div style={{ position: 'absolute', left: 120, bottom: 44, padding: '12px 22px', background: '#FFFFFF', border: '3px solid #000000', boxShadow: '4px 4px 0 #000000', fontFamily: '"Space Grotesk", ui-monospace, monospace', fontSize: 22, fontWeight: 700, lineHeight: 1, letterSpacing: '0.1em', color: '#000000' }}>
      {pad(current)} / {pad(total)}
    </div>
  );
};
```

### Eyebrow / accents

```tsx
// Label pill, opening every region. bg: white or any pastel.
const Eyebrow = ({ children, bg = '#FFFFFF' }: { children: React.ReactNode; bg?: string }) => (
  <span style={{ alignSelf: 'flex-start', padding: '10px 24px', background: bg, border: '3px solid #000000', boxShadow: '4px 4px 0 #000000', fontFamily: '"Space Grotesk", ui-monospace, monospace', fontSize: 22, fontWeight: 600, lineHeight: 1, letterSpacing: '0.08em', textTransform: 'uppercase', color: '#000000' }}>
    {children}
  </span>
);

// Yellow CTA tab, tilted -3deg, stapled to a card's top edge.
const Tab = ({ children }: { children: React.ReactNode }) => (
  <div style={{ position: 'absolute', top: -34, left: 72, transform: 'rotate(-3deg)', padding: '14px 32px', background: '#F7CB46', border: '3px solid #000000', boxShadow: '4px 4px 0 #000000', fontFamily: '"Inter", system-ui, sans-serif', fontSize: 26, fontWeight: 700, lineHeight: 1, textTransform: 'uppercase' }}>
    {children}
  </div>
);
```

## Motion

- Philosophy: static. The source cuts between slides; hard edges and tilts carry the energy.

## Aesthetic

Maximalist neobrutalism: zine layout, a 1990s sticker book, toy packaging. Five laws: every region has a black border, every raised thing a hard black offset shadow, every corner is square, every fill a saturated pastel, and every layout is a little crooked. Heavy uppercase Inter shouts; wide-tracked Space Grotesk reads as system chrome. Tilted stars, stripe blocks and badges puncture the grid on purpose while grounds cycle through candy colours. No blur, rounded corners, gradients, grey or timidity.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: '#FFFDF5', color: '#000000', padding: 120, display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
    <DotGrid style={{ top: 0, left: 0, width: 520, height: 320 }} />
    <StripeBlock style={{ top: 72, left: 1080, width: 280, height: 120, transform: 'rotate(4deg)' }} />
    <TiltBlock style={{ right: 260, bottom: 60, width: 320, height: 150, transform: 'rotate(-6deg)' }} />
    <Card>
      <Tab>October 2026</Tab>
      <StarBurst style={{ top: -84, right: -64 }} />
      <Eyebrow bg="#C0F7FE">Launch · 2026</Eyebrow>
      <Title>Make It Loud</Title>
      <p style={{ fontFamily: '"Space Grotesk", ui-monospace, monospace', fontSize: 32, fontWeight: 500, lineHeight: 1.5, margin: 0 }}>
        A short subtitle that explains what this deck is about.
      </p>
    </Card>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
type Deco = { style?: React.CSSProperties };

// Elevated card: 4px border + 8px shadow. small: 3px + 4px (stat, step, team cards).
const Card = ({ children, bg = '#FFFFFF', small = false, style }: Deco & { children: React.ReactNode; bg?: string; small?: boolean }) => (
  <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', gap: small ? 16 : 40, padding: small ? 40 : 72, background: bg, border: `${small ? 3 : 4}px solid #000000`, boxShadow: small ? '4px 4px 0 #000000' : '8px 8px 0 #000000', ...style }}>
    {children}
  </div>
);

// Tilted star burst on a card or page corner.
const StarBurst = ({ size = 180, fill = '#FE90E8', style }: Deco & { size?: number; fill?: string }) => (
  <svg aria-hidden viewBox="-6 -6 112 112" width={size} height={size} overflow="visible" style={{ position: 'absolute', transform: 'rotate(12deg)', ...style }}>
    <polygon points="50,0 61,35 98,35 68,57 79,91 50,70 21,91 32,57 2,35 39,35" fill={fill} stroke="#000000" strokeWidth={3} vectorEffect="non-scaling-stroke" />
  </svg>
);

// Tilted pastel block (±2–12deg); add a label for a badge.
const TiltBlock = ({ bg = '#FE90E8', style, children }: Deco & { bg?: string; children?: React.ReactNode }) => (
  <div style={{ position: 'absolute', background: bg, border: '3px solid #000000', boxShadow: '4px 4px 0 #000000', ...style }}>{children}</div>
);

// Black + pastel stripes, 4px on / 8px off.
const StripeBlock = ({ color = '#99E885', style }: Deco & { color?: string }) => (
  <div aria-hidden style={{ position: 'absolute', border: '3px solid #000000', background: `repeating-linear-gradient(45deg, #000000 0 4px, ${color} 4px 12px)`, ...style }} />
);

const DotGrid = ({ style }: Deco) => (
  <div aria-hidden style={{ position: 'absolute', opacity: 0.35, backgroundImage: 'radial-gradient(circle, #000000 1.5px, transparent 1.5px)', backgroundSize: '24px 24px', ...style }} />
);

// Corner brackets inside a card edge: frame within a frame.
const Brackets = () => {
  const s = { position: 'absolute', width: 32, height: 32 } as const;
  const b = '3px solid #000000';
  return (
    <>
      <span aria-hidden style={{ ...s, top: 16, left: 16, borderTop: b, borderLeft: b }} />
      <span aria-hidden style={{ ...s, bottom: 16, right: 16, borderBottom: b, borderRight: b }} />
    </>
  );
};

// Stat: tilt alternates -2 / 2deg (gap ≥ 32); the dot is the only circle in the system.
const Stat = ({ value, label, dot = '#FE90E8', tilt = -2 }: { value: string; label: string; dot?: string; tilt?: number }) => (
  <Card small style={{ transform: `rotate(${tilt}deg)` }}>
    <span aria-hidden style={{ position: 'absolute', top: 16, right: 16, width: 16, height: 16, borderRadius: '50%', background: dot, border: '2px solid #000000' }} />
    <div style={{ fontFamily: '"Inter", system-ui, sans-serif', fontSize: 112, fontWeight: 900, lineHeight: 1, letterSpacing: '-0.02em' }}>{value}</div>
    <div style={{ fontFamily: '"Space Grotesk", ui-monospace, monospace', fontSize: 22, fontWeight: 600, letterSpacing: '0.08em', textTransform: 'uppercase' }}>{label}</div>
  </Card>
);

// Yellow notch breaking a feature card's top edge.
const NOTCH = { position: 'absolute', top: -16, right: 32, width: 56, height: 56, background: '#F7CB46', border: '3px solid #000000' } as const;
// Closing page on '#000000': the only coloured shadow.
const CLOSE_FRAME = { position: 'relative', padding: 72, border: '4px solid #FFFFFF', boxShadow: '12px 12px 0 #F7CB46', color: '#FFFFFF' } as const;
// Also square with 3px borders: list numbers (48px yellow), icon squares (88px pastel, one
// letter), avatars (96px pastel, initials). Timeline steps join with a 40 × 4px black bar.
```

## Do / Don't

- Do pair 4px borders with 8px shadows and 3px with 4px: black, zero blur, bottom-right.
- Do open every region with the label pill, then an uppercase headline.
- Do cycle grounds through the pastels and end on the black close.
- Do tilt at least one decoration per page (star, stripes, dots, brackets, block).
- Do use yellow for the CTA; chart series run pink → blue → green → yellow → cream.
- Don't round corners (only the stat dot), blur shadows or colour borders.
- Don't add a sixth pastel, grey text, italics or a third typeface.
- Don't set Inter display in sentence case or default tracking.
- If a page is noisy, drop a decoration, never a border or shadow.
