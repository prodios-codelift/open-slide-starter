---
name: Retro Windows
description: "Windows 95/98 desktop chrome: beveled gray windows, navy gradient title bars, MS Sans Serif, CRT scanlines."
mode: light
mood: [nostalgic, retro, geeky, playful]
tone: [winking, nostalgic, geeky, fun]
formality: low
density: medium
scheme: light
best_for: "Anything that should feel knowingly nostalgic — retro gaming, Y2K-aesthetic brands, 90s-vibe creator portfolios, tech-history talks, and deliberately tongue-in-cheek decks."
avoid_for: "Decks that need to read as modern, elegant, or institutionally credible — the Win95 chrome will always read as a costume."
source: bold:retro-windows
---

# Retro Windows

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#c0c0c0` | desktop fill behind every window |
| text | `#222222` | body copy inside window/sunken content |
| accent | `#000080` | navy — headlines, title bars, chart primary |
| muted | `#555555` | secondary/caption text |
| bg-light | `#d4d0c8` | window chrome / raised panel fill |
| bg-dark | `#808080` | inactive title-bar start |
| white | `#ffffff` | sunken wells (inputs, progress track) |
| black | `#000000` | deepest bevel shadow / border |
| blue-bright | `#0000a0` | title-bar gradient end |
| blue-light | `#1084d0` | tertiary chart data |
| green-retro | `#008000` | status OK |
| red-retro | `#800000` | status error |
| yellow-retro | `#808000` | status moderate |
| cyan-retro | `#008080` | status tertiary |

## Typography

- Display/body font: `"MS Sans Serif", "Segoe UI", Tahoma, Geneva, Verdana, sans-serif` — the OS system stack; weight 700 headlines, 400 body. Never substitute a custom display sans — the fallback chain *is* the joke.
- Accent fonts, 1–2 moments per deck only: `"Press Start 2P", cursive` (pixel splash titles), `"VT323", monospace` (terminal/nav-hint text).
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=Press+Start+2P&family=VT323&display=swap`
- Type scale (source's integer-px system, scaled ~2x for the 1920×1080 stage; stays deliberately modest — dense windows, not one giant hero, is correct here): headline (window-body h1) 68px/700/navy; section/group-box heading 46px/700; body 34–38px/400; caption/status/cell 26–30px; title-bar filename 26px/700/uppercase; pixel splash accent (rare) 44–48px; terminal/nav-hint 30–32px.

## Layout

- Canvas: full-bleed `#c0c0c0` desktop; one `WinWindow` (or a few stacked) centered, `max-width: 1320px` — the gray margin around it is part of the look, never fill edge to edge.
- Window body: padding `36px 44px 44px 44px`, children stacked in a column, 22px gaps. Group-box padding: `36px 32px 28px 32px` (extra top clears the notched title).
- No rounded corners; depth is bevel borders only (2px two-tone raised/sunken), never a blurred shadow. CRT scanline overlay sits above everything, 3px-period, 3% black.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1 style={{ fontFamily: '"MS Sans Serif", "Segoe UI", Tahoma, sans-serif', fontSize: 68, fontWeight: 700, lineHeight: 1.15, margin: 0, color: '#000080' }}>{children}</h1>
);
```

### Footer

```tsx
import { useSlidePageNumber } from '@open-slide/core';

const Footer = () => {
  const { current, total } = useSlidePageNumber();
  return (
    <div style={{ position: 'absolute', left: 44, right: 44, bottom: 28, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
      <span style={{ fontFamily: '"VT323", monospace', fontSize: 30, color: '#555555' }}>{'<-- ARROW KEYS to navigate -->'}</span>
      <span style={{ fontFamily: '"MS Sans Serif", "Segoe UI", Tahoma, sans-serif', fontSize: 22, background: '#ffffff', borderWidth: 2, borderStyle: 'solid', borderColor: '#404040 #ffffff #ffffff #404040', padding: '4px 14px', color: '#222222' }}>{String(current).padStart(2, '0')} / {String(total).padStart(2, '0')}</span>
    </div>
  );
};
```

### Eyebrow / accents

```tsx
const Eyebrow = ({ children, glyph = 'F' }: { children: React.ReactNode; glyph?: string }) => (
  <div style={{ display: 'inline-flex', alignItems: 'center', gap: 10, padding: '7px 14px', background: 'linear-gradient(90deg, #000080, #0000a0)' }}>
    <span style={{ width: 30, height: 30, background: '#ffffff', border: '1px solid #000000', color: '#000080', fontFamily: '"MS Sans Serif", sans-serif', fontWeight: 700, fontSize: 16, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>{glyph}</span>
    <span style={{ fontFamily: '"MS Sans Serif", "Segoe UI", Tahoma, sans-serif', fontWeight: 700, fontSize: 24, letterSpacing: '0.5px', color: '#ffffff', textTransform: 'uppercase' }}>{children}</span>
  </div>
);
```

## Motion

- Philosophy: static. Windows 95 predates hover/transition affordances — content snaps into place, never eases. The only permitted motion is a `ProgressBar` fill width-transition or a marquee scroll, used rarely.

## Aesthetic

Every slide is software running on a 1995 desktop: a beveled `WinWindow` with a navy-gradient title bar, a filename-style caption (`README.DOC`, `METRICS.LOG`), and a dense application body — group boxes, sunken panels, status footers — packed the way real Win9x UI was packed. Depth comes only from two-tone bevel borders (raised: white top/left, black bottom/right; sunken: the inverse), never blurred shadows or rounded corners. The palette is button-face gray and navy, with four status accents (green/red/yellow/cyan) carrying fixed meaning, not decoration. A faint CRT scanline overlay ties every surface to a 1995 monitor. Sparse, centered, one-big-headline compositions read as broken here — this system wants density.

## Example usage

```tsx
const Cover: Page = () => (
  <div style={{ width: '100%', height: '100%', background: '#c0c0c0', position: 'relative', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
    <CrtOverlay />
    <WinWindow title="AGENDA.TXT" glyph="A" style={{ width: 1320 }}>
      <Eyebrow>FINANCE · Q3 2026</Eyebrow>
      <Title>Quarterly Business Review</Title>
      <p style={{ fontFamily: '"MS Sans Serif", "Segoe UI", Tahoma, sans-serif', fontSize: 34, color: '#222222', maxWidth: 1000, margin: 0 }}>A status readout for the quarter, rendered as a desktop application.</p>
      <GroupBox title="STATUS">
        <ProgressBar pct={72} />
      </GroupBox>
    </WinWindow>
    <Footer />
  </div>
);
```

## Signature elements

```tsx
// The framing primitive — every slide is at least one of these.
const WinBtn = ({ children }: { children: React.ReactNode }) => (
  <span style={{ width: 32, height: 28, background: '#d4d0c8', borderWidth: 2, borderStyle: 'solid', borderColor: '#ffffff #000000 #000000 #ffffff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 15, fontWeight: 700, color: '#222222' }}>{children}</span>
);

const WinWindow = ({ title, glyph = 'P', active = true, children, style }: { title: string; glyph?: string; active?: boolean; children: React.ReactNode; style?: React.CSSProperties }) => (
  <div style={{ background: '#d4d0c8', borderWidth: 2, borderStyle: 'solid', borderColor: '#ffffff #000000 #000000 #ffffff', boxShadow: 'inset 1px 1px 0 #ffffff, inset -1px -1px 0 #404040', ...style }}>
    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '7px 14px', background: active ? 'linear-gradient(90deg, #000080, #0000a0)' : 'linear-gradient(90deg, #808080, #a0a0a0)' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
        <span style={{ width: 32, height: 32, background: '#ffffff', border: '1px solid #000000', color: '#000080', fontFamily: '"MS Sans Serif", sans-serif', fontWeight: 700, fontSize: 18, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>{glyph}</span>
        <span style={{ fontFamily: '"MS Sans Serif", "Segoe UI", Tahoma, sans-serif', fontWeight: 700, fontSize: 26, letterSpacing: '0.5px', color: '#ffffff', textTransform: 'uppercase' }}>{title}</span>
      </div>
      <div style={{ display: 'flex', gap: 6 }}>
        <WinBtn>_</WinBtn>
        <WinBtn>▢</WinBtn>
        <WinBtn>✕</WinBtn>
      </div>
    </div>
    <div style={{ padding: '36px 44px 44px 44px', display: 'flex', flexDirection: 'column', gap: 22 }}>{children}</div>
  </div>
);

// Fixed, full-viewport scanline overlay at 3% black — the CRT-monitor texture.
const CrtOverlay = () => (
  <div aria-hidden style={{ position: 'absolute', inset: 0, pointerEvents: 'none', zIndex: 50, backgroundImage: 'repeating-linear-gradient(0deg, rgba(0,0,0,0.03) 0px, rgba(0,0,0,0.03) 1px, transparent 1px, transparent 3px)' }} />
);

// Sunken container with a notch-mounted title — the fieldset/legend of this system.
const GroupBox = ({ title, children }: { title: string; children: React.ReactNode }) => (
  <div style={{ position: 'relative', borderWidth: 2, borderStyle: 'solid', borderColor: '#404040 #ffffff #ffffff #404040', background: '#d4d0c8', padding: '36px 32px 28px 32px' }}>
    <span style={{ position: 'absolute', top: -16, left: 20, background: '#d4d0c8', padding: '0 14px', fontFamily: '"MS Sans Serif", sans-serif', fontWeight: 700, fontSize: 24, color: '#222222' }}>{title}</span>
    {children}
  </div>
);

// Sunken white well with a solid navy fill — no gradient, no animation beyond width.
const ProgressBar = ({ pct }: { pct: number }) => (
  <div style={{ width: '100%', height: 40, background: '#ffffff', borderWidth: 2, borderStyle: 'solid', borderColor: '#404040 #ffffff #ffffff #404040', padding: 3 }}>
    <div style={{ width: `${pct}%`, height: '100%', background: '#000080' }} />
  </div>
);

// Chevron bullet — replaces native list markers everywhere in this system.
const RetroBullet = ({ children }: { children: React.ReactNode }) => (
  <li style={{ display: 'flex', gap: 10, listStyle: 'none' }}><span style={{ color: '#000080', fontWeight: 700 }}>{'>'}</span><span>{children}</span></li>
);
```

## Do / Don't

- Do wrap every slide in a `WinWindow` with an uppercase filename title (`METRICS.LOG`, `AGENDA.TXT`) and the three-button cluster — even decorative, it must always be present.
- Do set primary headlines in navy weight 700; navy is the application-title voice, not black.
- Do use the status colors semantically only: green OK, red error, yellow moderate, cyan tertiary data — never as decoration.
- Do pack each window body densely — group boxes, panels, a status footer; empty space reads as broken here.
- Don't round any corner or use a blurred `box-shadow` — depth is bevel borders only.
- Don't put color on borders (no navy/green borders) — bevels are always white/black or darkgray/white.
- Don't use Press Start 2P or VT323 for body text; they're nostalgic accents for one or two moments per deck.
