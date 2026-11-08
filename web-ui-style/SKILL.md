---
name: web-ui-style
description: Use when building or restyling any web UI for the user — dashboards (ThingsBoard or other IoT), web pages, admin panels, HTML artifacts. Applies the user's chosen look: minimal monochrome (black/white/grey) with hairline gradient borders and viewfinder corners, state shown by border style and brightness instead of colour.
---

# Web UI style — minimal monochrome, "premium" borders

The user tried a colourful version first and rejected it ("hối hận"). Default to this
style for every web UI unless the user asks otherwise in that task.

> **Mandatory:** follow the `structured-workspace` layout. Web UI / dashboard code lives in `source-code/<project>/` and is versioned by its source-code rule (one version number + `CHANGELOG.md`, start `0.1.0`); each delivered build or dashboard export goes to a new `versions/source-code/<project>/v<X.Y.Z>/`. Drafts and style experiments stay in `sandbox/`.

## Palette (dark)

| Token | Value | Use |
|---|---|---|
| `--bg` | `#050505` | page / dashboard background |
| `--card` | `#0c0c0c` | cards, widgets |
| `--text` | `#ededed` | main text |
| `--strong` | `#ffffff` | values, active state |
| `--mid` | `#a3a3a3` | secondary values |
| `--muted` | `#6b6b6b` | labels, off/inactive state |
| `--line` | `rgba(255,255,255,.10)` | hairlines, grid |

No hue. If a light theme is needed, invert (white surfaces, near-black text, same rules).

## Borders — the signature

- Cards: 1px **gradient border**, bright at the top-left, fading through the middle,
  slightly bright again bottom-right; radius 16px; very soft glow below.

  ```css
  border: 1px solid transparent; border-radius: 16px;
  background:
    linear-gradient(var(--card), var(--card)) padding-box,
    linear-gradient(135deg, rgba(255,255,255,.55) 0%, rgba(255,255,255,.06) 35%,
                    rgba(255,255,255,.06) 70%, rgba(255,255,255,.30) 100%) border-box;
  box-shadow: 0 18px 40px -24px rgba(255,255,255,.18);
  ```

- Hero/banner: same idea, plus a faint radial light in the top-left corner and a 1px
  centred highlight line along the bottom edge (`::after`, gradient transparent→white→transparent).
- KPI tiles: thin `--line` border with **viewfinder corners** — 10px white L-shapes on
  the top-left and bottom-right (`::before` / `::after`). Highlight a tile that needs
  attention by brightening its border, not by colouring it.

## Typography

- Titles: uppercase, letter-spacing .18–.32em, light weight (200–300) with one bold word
  (e.g. **HYBRID**·LORA).
- Numbers: thin (200), large, `font-variant-numeric: tabular-nums`; measurements in
  monospace.
- No emoji in titles.

## Showing state without colour

| Meaning | Treatment |
|---|---|
| on / active / good | white text, 1px **solid** pill border |
| warning / weak / test mode | white text, 1px **dashed** pill border |
| critical / very weak | grey text, 1px **dotted** border |
| off / none | `--muted` text, no border |
| level (signal, battery…) | text bar `▮▮▮▮▯▯▯▯▯▯` + number |
| strength in a number column | brightness: white → grey → muted |

Status words in caps with a dot: `● ONLINE`, `○ OFFLINE`.

## Charts

Grey grid (`#1c1c1c`), grey axis text (`#8a8a8a`), series in shades of grey/white.
ThingsBoard's legacy `system.charts.basic_timeseries` auto-colours each entity when one
alias resolves to many devices and ignores a grey palette — use the 4.x "Time series
chart" widget (per-series colours) or one small white chart per device if strict
monochrome matters.

## ThingsBoard specifics (learned on Cloud 4.4)

- Generate dashboards from a script (e.g. `scripts/make_dashboard.py`) and keep the JSON
  in the repo per firmware version; never hand-edit the export.
- Entities table title comes from `settings.entitiesTitle`, not `config.title`.
- Markdown/HTML card: `markdownTextFunction(data)` receives one row per entity
  (`{entityName, <key>: value}`) in 4.x; support the older raw datasource shape too.
- Cell look: `useCellContentFunction` + `cellContentFunction` for text,
  `useCellStyleFunction` + `cellStyleFunction` returning a CSS object for borders.
- Per-row buttons: action cell button, type custom,
  `widgetContext.deviceService.sendTwoWayRpcCommand(entityId.id, {method, params, timeout})`.

## Previewing

- To show the UI before hardware exists, create clearly labelled demo devices
  (label `DEMO - dữ liệu thử`) with fake telemetry, and tell the user to delete them
  before real devices with the same names report in.
- Replacing a dashboard: import the new one, then delete the old one **by its explicit
  id** after listing it — never delete by search result.
- Screenshot every state/tab and give the user the saved paths.
