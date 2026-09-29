import type { OpenSlideConfig } from '@open-slide/core';

// Runs inside a Prodios Autopilot sandbox: the public hostname isn't known ahead
// of time, and the deck browser stays hidden (see patches/ — dev honours it).
const openSlideConfig: OpenSlideConfig = {
  port: 3000,
  allowedHosts: true,
  build: { showSlideBrowser: false },
};

export default openSlideConfig;
