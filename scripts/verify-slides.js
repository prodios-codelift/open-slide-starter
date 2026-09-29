// Checks the open-slide page shown at /s/<id>?p=<n> for clipped text, content escaping
// the 1920×1080 canvas, and overlapping grid/flex panels. A page that failed to compile
// (Vite's error overlay) or shows no slide is reported instead of passing.
//
//   agent-browser open "http://localhost:3000/s/deck?p=1"
//   agent-browser eval "$(cat scripts/verify-slides.js)"
//
// Resolves to { page, issues: [{ type, element, detail }] }. `issues` must be empty.
// Exemptions: [data-bleed] allows intentional off-canvas decoration; [data-verify-ignore] skips a subtree.
(async () => {
  const TOLERANCE = 1;
  const CANVAS_WIDTH = 1920;
  const page = new URLSearchParams(location.search).get('p') ?? '1';
  const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
  const nextFrame = () =>
    new Promise((resolve) => requestAnimationFrame(() => requestAnimationFrame(resolve)));

  const describe = (el) => {
    let out = el.tagName.toLowerCase();
    if (el.id) out += `#${el.id}`;
    const text = (el.textContent || '').trim().replace(/\s+/g, ' ').slice(0, 40);
    return text ? `${out} "${text}"` : out;
  };
  const isRendered = (el) => {
    const style = getComputedStyle(el);
    return style.display !== 'none' && style.visibility !== 'hidden' && el.getClientRects().length > 0;
  };
  const clipsContent = (style) =>
    [style.overflowX, style.overflowY].some((value) => ['hidden', 'clip', 'scroll', 'auto'].includes(value));
  const overlapArea = (a, b) =>
    Math.max(0, Math.min(a.right, b.right) - Math.max(a.left, b.left)) *
    Math.max(0, Math.min(a.bottom, b.bottom) - Math.max(a.top, b.top));

  // The page canvas is the largest [data-osd-canvas]; the thumbnail rail renders small ones.
  const mainCanvas = () => {
    let best = null;
    let bestArea = 0;
    for (const el of document.querySelectorAll('[data-osd-canvas]')) {
      const rect = el.getBoundingClientRect();
      if (rect.width * rect.height > bestArea) {
        best = el;
        bestArea = rect.width * rect.height;
      }
    }
    return best;
  };
  const errorOverlay = () => document.querySelector('vite-error-overlay');

  for (let waited = 0; waited < 5000 && !mainCanvas() && !errorOverlay(); waited += 100) {
    await sleep(100);
  }

  const overlay = errorOverlay();
  if (overlay) {
    const root = overlay.shadowRoot ?? overlay;
    const text = (root.querySelector('.message-body')?.textContent || root.textContent || '')
      .replace(/\s+/g, ' ')
      .trim()
      .slice(0, 400);
    return { page, issues: [{ type: 'build-error', element: 'Vite error overlay', detail: text }] };
  }

  const canvas = mainCanvas();
  if (!canvas) {
    return {
      page,
      issues: [
        { type: 'no-deck', element: '', detail: 'no slide canvas on this page (wrong id, or the slide exports no pages)' },
      ],
    };
  }

  // Reveal every <Step> and stop transitions so layout is final while measuring.
  const override = document.createElement('style');
  override.textContent = `
    [data-osd-step] { visibility: visible !important; opacity: 1 !important; }
    [data-osd-canvas] * { transition: none !important; }
  `;
  document.head.appendChild(override);
  await nextFrame();
  for (const animation of canvas.getAnimations({ subtree: true })) {
    try {
      animation.finish();
    } catch {
      // Infinite animations cannot finish; they don't affect layout checks.
    }
  }

  const bounds = canvas.getBoundingClientRect();
  const scale = bounds.width / CANVAS_WIDTH;
  const issues = [];

  for (const el of canvas.querySelectorAll('*')) {
    if (el.closest('[data-verify-ignore]') || !isRendered(el)) continue;
    const style = getComputedStyle(el);
    const rect = el.getBoundingClientRect();

    // The framework's own per-page host div (canvas's direct child) is always
    // overflow-hidden and always "overflows" whenever any descendant escapes the
    // canvas — including one under [data-bleed]. Skip it; a real clipped bug is
    // still caught one level down, on the element that actually owns the overflow.
    if (
      el.parentElement !== canvas &&
      clipsContent(style) &&
      (el.scrollHeight > el.clientHeight + TOLERANCE || el.scrollWidth > el.clientWidth + TOLERANCE)
    ) {
      issues.push({
        type: 'clipped',
        element: describe(el),
        detail: `content ${el.scrollWidth}×${el.scrollHeight} in a ${el.clientWidth}×${el.clientHeight} box`,
      });
    }

    if (
      !el.closest('[data-bleed]') &&
      (rect.left < bounds.left - TOLERANCE ||
        rect.top < bounds.top - TOLERANCE ||
        rect.right > bounds.right + TOLERANCE ||
        rect.bottom > bounds.bottom + TOLERANCE)
    ) {
      issues.push({ type: 'out-of-bounds', element: describe(el), detail: 'extends past the 1920×1080 canvas' });
    }

    if (['grid', 'inline-grid', 'flex', 'inline-flex'].includes(style.display)) {
      const panels = [...el.children].filter(
        (child) => isRendered(child) && !['absolute', 'fixed'].includes(getComputedStyle(child).position),
      );
      for (let i = 0; i < panels.length; i++) {
        for (let j = i + 1; j < panels.length; j++) {
          const area = overlapArea(panels[i].getBoundingClientRect(), panels[j].getBoundingClientRect());
          if (area > TOLERANCE) {
            issues.push({
              type: 'overlap',
              element: `${describe(panels[i])} × ${describe(panels[j])}`,
              detail: `${Math.round(area / (scale * scale))}px² overlap (canvas px)`,
            });
          }
        }
      }
    }
  }

  override.remove();
  return { page, issues };
})();
