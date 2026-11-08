---
name: presentation-from-reference
description: Create or revise an editable PowerPoint presentation using a user-provided PPTX as a visual reference and verified local project materials as content. Use when the user asks for slides based on an existing deck, or to revise a versioned deck; content is reviewed in Markdown before rendering.
---

# Presentation From Reference

> **Mandatory:** follow the `structured-workspace` layout (scaffold it first if missing). Every delivered deck gets a version `vX.Y.Z` in `versions/presentations/<topic>/v<X.Y.Z>/`; no unversioned deliverables (section 7).

## 1. Read the reference

Read the reference PPTX before drafting: slide count, size, repeated layouts, colors, type sizes, images and section rhythm. Keep the source file unchanged. Treat it as a visual reference unless the user asks to modify that exact deck.

For the user's FPGA/OneKiwi Gateway decks, also read [fpga-onekiwi.md](references/fpga-onekiwi.md).

No reference deck given for an academic report/defense deck: use the approved template
[mau-kem-xanh-ngoc.md](references/mau-kem-xanh-ngoc.md) (about 10 dense slides, claude.ai Slides).

## 2. Content and accuracy

- Build a short outline from the user's topic and local source material. Verify technical claims against actual project files or reports.
- Distinguish built, simulated and physically tested results. Do not imply that sample data, radio icons or placeholders are live telemetry. Describe an architecture as an architecture, not as an unverified deployment result.
- Give each slide a distinct purpose; do not repeat the same diagram on consecutive slides.

## 3. Content review before rendering

- Deliver a saved Markdown content file for review before creating or substantially revising a deck: proposed slide titles, audience-facing content, planned figures/diagrams, and any overlap or missing topics.
- Put internal verification notes in a separate section from the proposed visible slide text.
- Wait for content approval before rendering. A previous approval does not cover a newly restructured outline. Routine formatting fixes within approved content can proceed when requested.

## 4. Visible slide text

- Keep visible text audience-facing and on topic. Do not embed authoring commentary, code-audit notes, implementation caveats or reminders (e.g. “sketch C3 đối chiếu mới xuất USB terminal, chưa xác nhận Cloud”, “cần chuẩn hóa nhãn”). Put them in the companion Markdown or speaker notes.
- Show status/limitations on a visible slide only when the user asks for that content.
- Footers hold project identity, slide number or necessary source attribution only.
- Avoid tiny or faint corner annotations and module footnotes; use legible, high-contrast text.

## 5. Diagrams

- For technical architecture, prefer an editable block diagram with clear data-flow arrows over a dense module/port table. Use plain-language functional block names on overview slides; keep implementation identifiers in documents or speaker notes unless requested.
- After removing detail, reflow the layout, center remaining content in its blocks and use freed space for readable text. Explain necessary abbreviations or bus notation in readable labels.
- Move exhaustive signal lists, bit ranges and pin mappings to companion documents or speaker notes. Show a full pinout only when the topic is wiring or the user requests it.
- Arrows: visibly substantial (about 3–3.5 pt with matching arrowheads at 13.33-inch slide width) and connected to the correct blocks. Reserve clear routing lanes; keep connectors and branch points off borders, divider lines and text; never stack connectors on decorative lines. Check branch topology and arrowhead clearance in the export.

## 6. Building the PPTX

- Keep it editable: text, shapes, connectors and tables for content; bitmaps only for photographs or actual UI captures.
- Use the PowerPoint MCP when it fits the edit; `python-pptx` is acceptable for detailed layout work, via a reproducible build script.
- Remove unused title/body placeholders. Check the PPTX in editing mode as well as rendered: an empty placeholder can show “Click to add title” over a custom heading even when absent in exports.

## 7. Versions and files

- Draft, edit and preview-render in `sandbox/presentations/<topic>/`. On delivery, copy to a new `versions/presentations/<topic>/v<MAJOR.MINOR.PATCH>/`; never edit inside `versions/` or overwrite delivered files.
- Start at `1.0.0`, comparing with the last delivered version: PATCH for small formatting/fix changes; MINOR (reset PATCH) for medium changes to part of the content/layout; MAJOR (reset both) for changes to the purpose or whole narrative. Preview re-renders are not versions. Preserve historical unversioned files; do not number them retroactively.
- Each version contains `<topic>_v<version>.pptx`, `NOI_DUNG.md` and `KICH_BAN_THUYET_TRINH.md`, all matching that version, plus `scripts/` (build scripts) and `images/` (previews/crops) when needed. Record predecessor and changes in `NOI_DUNG.md`. The speaking script explains mechanisms, design rationale, calculations, assumptions, limitations and technical-defense questions.
- Original references stay in `documents/sources/<topic>/`; technical reports in `documents/verification/`.

## 8. Verify before delivery

- Render every final slide with PowerPoint or a compatible renderer; inspect for text clipping, overlaps, missing media and inconsistent spacing.
- Reopen the PPTX after saving; confirm slide count and core content.
- Report the output path and what remains unverified (e.g. on physical hardware).

## Tools on this machine

PowerPoint MCP is configured as `ppt` in both Codex and Claude (tools `mcp__ppt__*`) and runs from `D:\Tools\Office-PowerPoint-MCP-Server-main\.venv`. It requires MCP SDK 1.x (`mcp[cli]>=1.8,<2`); SDK 2.x removes the `FastMCP` import it uses.
