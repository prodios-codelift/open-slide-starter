---
name: Terminal Green
description: "GitHub-dark terminal with phosphor-green prompts, a blinking cursor, and faint CRT scan lines, set in monospace from top to bottom."
mode: dark
mood: [technical, focused, nocturnal, hackerish]
tone: [terse, direct, nerdy, precise]
formality: low
density: medium
scheme: dark
best_for: "Developer talks, engineering demos, devtool/API/CLI launches, architecture walkthroughs, and hackathon pitches where code on screen is part of the story."
avoid_for: "Executive, brand, or general-audience decks: all-monospace green-on-black reads as insider cosplay outside a technical room, and long prose in mono tires the eye."
source: preset
derived: true
---

# Terminal Green

## Palette

| Role | Value | Notes |
| --- | --- | --- |
| bg | `#0d1117` | GitHub dark canvas, the only page background |
| bg-alt | `#161b22` | code panels, terminal windows, cards |
| border | `#30363d` | panel borders, footer rule, hairlines |
| text | `#e6edf3` | primary copy and headlines |
| accent | `#39d353` | terminal green: prompt, cursor, key numbers, success |
| accent-dim | `#26a641` | fills, bars, secondary green; never small text |
| glow | `rgba(57,211,83,0.45)` | phosphor `textShadow` / `boxShadow`, green only |
| muted | `#8b949e` | secondary copy, code comments |
| subtle | `#6e7681` | line numbers, the `$` prompt, footer chrome |
| danger | `#f85149` | failures, diff removals, negative deltas |
| syn-keyword | `#ff7b72` | `const`, `if`, `return` |
| syn-string | `#a5d6ff` | string literals |
| syn-function | `#d2a8ff` | function and method names |
| syn-number | `#79c0ff` | numbers, constants |

## Typography

- One font for everything: `"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace`. Monospace only; hierarchy comes from size and weight (800 headlines, 500 labels, 400 body), never from a second family.
- Webfont stylesheet: `https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;800&display=swap`
- Mono glyphs run ~0.6em wide, so sizes sit below slide-authoring's defaults:
  - Hero title: 120px, weight 800, line-height 1.05, letter-spacing -0.02em. Only for cover titles of 20 characters or fewer (~23 chars fit per line); otherwise use the 96px Title.
  - Section heading / Title: 96px, weight 800, line-height 1.1, letter-spacing -0.02em (~29 chars per line)
  - Page heading: 64px, weight 800, line-height 1.15
  - Body: 32px, weight 400, line-height 1.6
  - Code: 28px, weight 400, line-height 1.6
  - Caption / label: 22px, weight 500, letter-spacing 0.04em

## Layout

- Content padding: 120px from every canvas edge (1920×1080). Footer sits at bottom 60.
- Alignment: left-aligned with a ragged right edge, like a terminal buffer. Never center.
- Measure in characters: at 32px a glyph is ~19px, so cap prose at `maxWidth: '60ch'`.
- Grid: single column by default. Code-plus-explanation pages split `gridTemplateColumns: '1fr 1fr'` at an 80px gap, with prose left and the code panel right.
- Rhythm: 24px between related lines (like consecutive output), 64px between blocks.

## Fixed components

### Title

```tsx
const Title = ({ children }: { children: React.ReactNode }) => (
  <h1
    style={{
      fontFamily: '"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace',
      fontSize: 96,
      fontWeight: 800,
      lineHeight: 1.1,
      letterSpacing: '-0.02em',
      margin: 0,
      color: '#e6edf3',
    }}
  >
    {children}
  </h1>
);
```

### Footer

A shell-prompt status line. Page number comes from `useSlidePageNumber()`.

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
        paddingTop: 16,
        borderTop: '1px solid #30363d',
        fontFamily: '"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace',
        fontSize: 22,
        fontWeight: 500,
        color: '#8b949e',
      }}
    >
      <span>
        <span style={{ color: '#39d353' }}>●</span> ~/deck <span style={{ color: '#6e7681' }}>on</span> main
      </span>
      <span>
        <span style={{ color: '#6e7681' }}>pg</span> {String(current).padStart(2, '0')}/{String(total).padStart(2, '0')}
      </span>
    </div>
  );
};
```

### Eyebrow / accents

A prompt line: dim `$`, green command text with phosphor glow.

```tsx
const Eyebrow = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      fontFamily: '"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace',
      fontSize: 26,
      fontWeight: 500,
      letterSpacing: '0.04em',
      color: '#39d353',
      textShadow: '0 0 12px rgba(57,211,83,0.45)',
    }}
  >
    <span style={{ color: '#6e7681', textShadow: 'none' }}>$</span> {children}
  </div>
);
```

## Motion

- Philosophy: subtle. The cursor blinks forever; output lines print in with hard cuts (never fades or slides), staggered by `animationDelay` in 120ms steps.
- Inject the keyframes once at module top level with the create-or-update `<style>` pattern from `slide-authoring/references/webfonts.md` (id `osd-styles-<slide-id>`):

```css
@keyframes tg-blink { 50% { opacity: 0; } }
@keyframes tg-print { from { opacity: 0; } to { opacity: 1; } }
```

- Print-in usage: `animation: 'tg-print 1ms steps(1, end) both', animationDelay: '240ms'`.

## Aesthetic

A developer's terminal at 2 a.m.: GitHub's dark canvas, JetBrains Mono for every glyph, and one phosphor green that only marks what's live: the prompt, the cursor, the number that matters. Faint CRT scan lines and a soft green glow add a retro-hardware warmth without tipping into Matrix parody. Code is a first-class citizen, shown in GitHub-dark syntax colours inside flat bordered panels with line numbers. Pages are short and line-oriented, like command output. No proportional fonts, no gradients beyond the scan-line texture, no illustrations, no emoji, and no rounded corners beyond GitHub's 6px panels.

## Example usage

```tsx
const Cover: Page = () => (
  <div
    style={{
      width: '100%',
      height: '100%',
      background: '#0d1117',
      color: '#e6edf3',
      fontFamily: '"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace',
      position: 'relative',
      padding: 120,
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'center',
    }}
  >
    <Eyebrow>cat ~/talks/q3-review.md</Eyebrow>
    <div style={{ marginTop: 40 }}>
      <Title>
        Ship It Faster<Cursor />
      </Title>
    </div>
    <p style={{ fontSize: 32, lineHeight: 1.6, color: '#8b949e', maxWidth: '60ch', margin: '40px 0 0' }}>
      <span style={{ color: '#6e7681' }}>// </span>How we cut deploy time from 40 minutes to 90 seconds.
    </p>
    <Footer />
    <ScanLines />
  </div>
);
```

## Signature elements

```tsx
// Blinking block cursor: end a headline or the last output line with it. Needs tg-blink.
const Cursor = () => (
  <span
    aria-hidden
    style={{
      display: 'inline-block',
      width: '0.55em',
      height: '0.9em',
      marginLeft: '0.15em',
      verticalAlign: '-0.1em',
      background: '#39d353',
      boxShadow: '0 0 16px rgba(57,211,83,0.6)',
      animation: 'tg-blink 1.1s step-end infinite',
    }}
  />
);

// CRT scan lines plus a faint green bloom. Render last so it sits over content.
const ScanLines = () => (
  <div
    aria-hidden
    style={{
      position: 'absolute',
      inset: 0,
      pointerEvents: 'none',
      backgroundImage:
        'repeating-linear-gradient(to bottom, rgba(255,255,255,0.035) 0px, rgba(255,255,255,0.035) 2px, transparent 2px, transparent 6px), radial-gradient(ellipse at 30% 40%, rgba(57,211,83,0.07), transparent 65%)',
    }}
  />
);

// GitHub-dark syntax colouring: one <Line> per code line, tokens wrapped in <Tok>.
const SYNTAX = { kw: '#ff7b72', str: '#a5d6ff', fn: '#d2a8ff', num: '#79c0ff', cmt: '#8b949e', ok: '#39d353' } as const;

const Tok = ({ k, children }: { k: keyof typeof SYNTAX; children: React.ReactNode }) => (
  <span style={{ color: SYNTAX[k] }}>{children}</span>
);

const Line = ({ n, children }: { n: number; children?: React.ReactNode }) => (
  <div style={{ display: 'flex', gap: 32, whiteSpace: 'pre' }}>
    <span style={{ width: '2ch', flexShrink: 0, textAlign: 'right', color: '#6e7681' }}>{n}</span>
    <span>{children}</span>
  </div>
);

const CodeBlock = ({ children }: { children: React.ReactNode }) => (
  <div
    style={{
      background: '#161b22',
      border: '1px solid #30363d',
      borderRadius: 6,
      padding: '32px 40px',
      fontFamily: '"JetBrains Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace',
      fontSize: 28,
      lineHeight: 1.6,
      color: '#e6edf3',
    }}
  >
    {children}
  </div>
);

// <CodeBlock>
//   <Line n={1}><Tok k="kw">const</Tok> p95 = <Tok k="fn">measure</Tok>(<Tok k="str">'deploy'</Tok>);</Line>
//   <Line n={2}><Tok k="cmt">// 40m → 90s</Tok></Line>
// </CodeBlock>
```

## Do / Don't

- Do end the one line that matters on each page with the blinking `<Cursor />`, and only one.
- Do keep green for live things: prompt text, cursor, the key number, success states. Body copy stays `#e6edf3`.
- Do write kickers as commands or paths (`$ cat roadmap.md`) and subtitles as `// comments`.
- Do show real code in `<CodeBlock>` with syntax colours and line numbers. Pair `+` green with `-` `#f85149` for deltas.
- Do render `<ScanLines />` last on every page.
- Don't use a proportional font anywhere, including numbers and captions.
- Don't set body copy or paragraphs in green, and don't add glow to non-green text.
- Don't use gradients, drop shadows, or rounding beyond the 6px code panel. Scan lines and the green glow are the only effects.
- Don't write prose past ~60 characters a line; split long paragraphs into short output-style lines.
