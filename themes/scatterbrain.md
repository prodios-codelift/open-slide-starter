---
name: Scatterbrain
description: "A Post-it-and-cork-board system: pastel sticky notes, red thumbtacks, and a three-voice Shrikhand/Zilla Slab/Caveat type stack."
mode: light
mood: [playful, creative, warm, workshop]
tone: [informal, warm, expressive, human]
formality: low
density: high
scheme: light
best_for: "Brainstorms, workshops, creative-agency credentials, and design-thinking sessions that want to read as in-progress thinking rather than a polished conclusion."
avoid_for: "Contexts that demand institutional precision — the sticky-note aesthetic intentionally reads as warm and unfinished."
source: bold:scatterbrain
---

# Scatterbrain

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#f7f5f0` | paper — base surface behind every background variant |
| bg-cream | `#faf8f3` | lightest paper tone, used inside the warm/paper gradients |
| text | `#2d2a26` | ink — headlines, body, borders, doodle strokes |
| muted | `#5c5750` | ink-light — secondary copy, captions, footer |
| accent | `#ffd43b` | yellow-deep — the default sticky color and eyebrow fills |
| yellow | `#ffe066` → `#ffd43b` | default sticky; the system's most common note |
| blue | `#a5d8ff` → `#74c0fc` | secondary sticky |
| pink | `#ffc9c9` → `#ff9f9f` | warm-accent sticky |
| green | `#b2f2bb` → `#8ce99a` | cool-accent sticky |
| orange | `#ffcc80` | flat-fill tertiary sticky (no gradient) |
| purple | `#d0bfff` | flat-fill tertiary sticky (no gradient) |
| white-note | `#ffffff` | bordered "plain" sticky — always pair with a 2px ink border |
| shadow | `rgba(45,42,38,0.15)` | soft outer drop shadow on every note |
| shadow-deep | `rgba(45,42,38,0.25)` | inner contact-shadow layer |

Sticky colors are **categorical, not semantic** — yellow isn't "warning," green isn't "success." Cycle through them for variety.

## Typography

- Display font: `"Shrikhand", cursive` — weight 400 (only weight available). Every headline, title, feature glyph, stat value. Chunky, hand-lettered, the system's primary voice.
- Body font: `"Zilla Slab", serif` — weight 400 body, 300 light captions, 500–700 emphasis.
- Hand-script font: `"Caveat", cursive` — weight 400 casual notes, 500–700 emphasis. Personal asides, eyebrows, quips.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Shrikhand&family=Zilla+Slab:wght@300;400;500;600;700&family=Caveat:wght@400;500;600;700&display=swap`
- Type scale (converted from the source's rem/clamp system at 1920px wide). Sizes read smaller than slide-authoring's hero defaults on purpose — Scatterbrain headlines live inside padded post-it cards, not full-bleed, and the system is deliberately high-density (1–4 notes per slide):
  - Display hero (cover/closer headline): 72px, Shrikhand 400, line-height 1.1, letter-spacing 0.02em
  - Statement: 56px, Shrikhand 400
  - Headline (primary note headline): 48px, Shrikhand 400
  - Title (small card title): 29px, Shrikhand 400
  - Caption-subtitle: 21px, Zilla Slab 400
  - Body: 20px, Zilla Slab 400, line-height 1.7
  - List item: 18px, Zilla Slab 400
  - Handwritten: 26px, Caveat 400
  - Handwritten-lg: 32px, Caveat 600
  - Stat value: 29px, Shrikhand 400
  - Label-script (eyebrow): 20px, Caveat, uppercase, 0.15em tracking

## Layout

- Content padding: 96px slide edge; post-it interior padding 40px 56px (hero notes), 40px (standard), 24px (small accents), at 1920×1080.
- Composition: 1–4 sticky notes plus 0–2 small accent notes or doodles per slide. Never crowd overlapping notes — negative space is what keeps the whiteboard readable.
- Every note carries a small rotation: ±1–3° for hero/statement notes, ±5–15° for floating accents. Alternate rotation direction between neighbors so nothing looks grid-snapped.
- Backgrounds: pick one of three textured surfaces per slide (cork / paper / warm-gradient, see Signature elements) for tactile variety across the deck.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: "'Shrikhand', cursive", fontSize: 72, fontWeight: 400, lineHeight: 1.1, letterSpacing: '0.02em', margin: 0, color: '#2d2a26' }}>{children}</h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 96, right: 96, bottom: 48, display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontFamily: "'Zilla Slab', serif", fontSize: 18, color: '#5c5750' }}>
      <span>SCATTERBRAIN</span>
      <span style={{ fontFamily: "'Caveat', cursive", fontWeight: 600, fontSize: 26, color: '#2d2a26' }}>{current} / {total}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div style={{ fontFamily: "'Caveat', cursive", fontWeight: 400, fontSize: 20, letterSpacing: '0.15em', textTransform: 'uppercase', color: '#2d2a26' }}>{children}</div>
);
```

## Motion

- Philosophy: subtle. A note settles in with a tiny fade + rotation-correct (0.3–0.4s ease-out) — never flashy or bouncy; the tactile shadow does the heavy lifting.

```css
@keyframes settle {
  from { opacity: 0; transform: translateY(10px) rotate(-6deg); }
  to   { opacity: 1; transform: translateY(0) rotate(var(--rot, -2deg)); }
}
```

## Aesthetic

A creative-workshop wall: every content block is a colored sticky note pinned or taped onto cork, desk paper, or morning-light gradient, dusted with a faint paper-grain overlay. Shrikhand shouts every headline in chunky marker-pen voice; Zilla Slab carries the steady body copy; Caveat scribbles the personal asides. Depth comes from soft blurred drop shadows and small hand-placed rotations, never sharp edges. Warm, tactile, in-progress — a thinker's desk, not a boardroom.

## Example usage

```tsx
const Cover: Page = () => (
  <Surface variant="warm">
    <Doodle style={{ top: 64, right: 96 }} />
    <div style={{ width: '100%', height: '100%', display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 96 }}>
      <PostIt color="yellow" rotate={-2} tape style={{ maxWidth: 1000 }}>
        <Eyebrow>Finance · Q3 2026</Eyebrow>
        <Title>Quarterly Business Review</Title>
        <p style={{ fontFamily: "'Caveat', cursive", fontSize: 28, color: '#5c5750', marginTop: 16 }}>Jot it down before you forget!</p>
      </PostIt>
    </div>
    <Footer />
  </Surface>
);
```

## Signature elements

```tsx
// Three textured background variants — pick one per slide.
const SURFACES: Record<'cork' | 'paper' | 'warm', string> = {
  cork: 'linear-gradient(160deg, #c9a876, #a67c52), repeating-linear-gradient(45deg, rgba(0,0,0,0.05) 0 2px, transparent 2px 24px)',
  paper: 'repeating-linear-gradient(0deg, rgba(45,42,38,0.08) 0 1px, transparent 1px 40px), repeating-linear-gradient(90deg, rgba(45,42,38,0.08) 0 1px, transparent 1px 40px), #f7f5f0',
  warm: 'radial-gradient(ellipse 50% 40% at 15% 20%, rgba(255,224,102,0.35), transparent), radial-gradient(ellipse 45% 40% at 85% 15%, rgba(165,216,255,0.3), transparent), radial-gradient(ellipse 45% 45% at 50% 90%, rgba(255,201,201,0.25), transparent), #faf8f3',
};
const Surface = ({ variant = 'warm', children }: { variant?: keyof typeof SURFACES; children: React.ReactNode }) => (
  <div style={{ width: '100%', height: '100%', position: 'relative', background: SURFACES[variant] }}>{children}</div>
);

// Colored sticky note — the system's core unit. Soft shadow + rotation always; pin/tape optional.
const POST_IT_BG: Record<string, string> = { yellow: 'linear-gradient(135deg, #ffe066, #ffd43b)', blue: 'linear-gradient(135deg, #a5d8ff, #74c0fc)', pink: 'linear-gradient(135deg, #ffc9c9, #ff9f9f)', green: 'linear-gradient(135deg, #b2f2bb, #8ce99a)', orange: '#ffcc80', purple: '#d0bfff', white: '#fff' };
const PostIt = ({ color = 'yellow', rotate = -2, pin = true, tape = false, style, children }: { color?: keyof typeof POST_IT_BG; rotate?: number; pin?: boolean; tape?: boolean; style?: React.CSSProperties; children: React.ReactNode }) => (
  <div style={{ position: 'relative', background: POST_IT_BG[color], border: color === 'white' ? '2px solid #2d2a26' : 'none', padding: '40px 56px', boxShadow: '2px 3px 15px rgba(45,42,38,0.15), 0 1px 3px rgba(45,42,38,0.25)', transform: `rotate(${rotate}deg)`, ...style }}>
    {pin && <span aria-hidden style={{ position: 'absolute', top: -12, left: '50%', marginLeft: -8, width: 16, height: 16, borderRadius: '50%', background: 'radial-gradient(circle at 30% 30%, #ff6b6b, #c92a2a)', boxShadow: '0 2px 4px rgba(45,42,38,0.25), inset -2px -2px 4px rgba(0,0,0,0.2)' }} />}
    {tape && <span aria-hidden style={{ position: 'absolute', top: -15, left: '50%', marginLeft: -40, width: 80, height: 25, background: 'rgba(255,255,255,0.4)', border: '1px solid rgba(255,255,255,0.3)', transform: 'rotate(-2deg)' }} />}
    {children}
  </div>
);

// Decorative corner doodle — 1–2 per slide, always faint.
const Doodle = ({ style }: { style?: React.CSSProperties }) => (
  <svg aria-hidden width={120} height={120} viewBox="0 0 120 120" style={{ position: 'absolute', opacity: 0.15, ...style }}>
    <path d="M20 60 Q40 20 60 60 T100 60" stroke="#2d2a26" strokeWidth={3} fill="none" />
  </svg>
);

// Full-viewport grain, 4% opacity, above all content. Add once at deck root, not per page.
const GrainOverlay = () => (
  <div aria-hidden style={{ position: 'fixed', inset: 0, opacity: 0.04, zIndex: 9999, pointerEvents: 'none', mixBlendMode: 'multiply', backgroundImage: 'radial-gradient(circle, #2d2a26 1px, transparent 1px)', backgroundSize: '3px 3px' }} />
);
```

## Do / Don't

- Do give every note a small rotation and alternate direction across neighbors — nothing aligns to a grid.
- Do pin every primary-headline note (`pin`); add `tape` on hero/statement notes for the "officially posted" treatment.
- Do cycle sticky colors (yellow → blue → pink → green → orange → purple) across multi-card layouts instead of repeating one.
- Do keep Shrikhand for every display moment and Zilla Slab for every paragraph — the pairing is locked.
- Don't substitute another display or script face; Shrikhand and Caveat are the system's identity.
- Don't crowd a slide with overlapping notes — 1–4 main notes plus 1–2 small accents is the ceiling.
- Don't use white as a note fill without its 2px ink border; it disappears into the paper background.
- Don't rotate a note past ±15° — beyond that, hand-placed reads as wonky.
