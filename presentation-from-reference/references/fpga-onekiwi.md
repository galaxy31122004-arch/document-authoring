# FPGA / OneKiwi presentation notes

Project-specific rules for the user's FPGA Gateway presentations. Load only when the deck covers this project.

## Scope

- Focus on the Gateway. External Nodes and Cloud provide context only; do not expand into their implementation unless requested.
- Give each slide a distinct purpose; avoid repeating the same UART–parser–UI architecture on consecutive slides.

## Block names and identifiers

- Overview blocks use plain-language functional names. Keep implementation identifiers such as `smartcity_uart_rx` in technical documents or speaker notes unless explicitly requested on a slide.
- Keep relevant interface standards, speeds, I/O banks and verified voltages visible when they help explain the architecture. Distinguish implementation bank IDs from board silkscreen voltage prefixes.
- Keep bank/pin details off the overview unless needed to explain it.

## OneKiwi board banks

- Verify bank claims against the board schematic and the actual board photo/revision, not only CST settings.
- On the user's photographed board, the prefixes `1-xx`, `2-xx`, `3-xx` denote voltage groups 1.8/2.5/3.3 V; they are not FPGA internal bank IDs.
- A PnR report identifies device banks; the board schematic identifies their supply wiring.
- State any revision mismatch or missing measurement in technical notes. Do not call a software constraint a hardware measurement.
