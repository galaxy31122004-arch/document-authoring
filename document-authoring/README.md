# Document Authoring

This repository contains the `document-authoring` Codex skill and its Word MCP
server in one checkout.

- `SKILL.md` and `references/`: skill instructions and reusable Word templates.
- `word-mcp/`: editable Word MCP server, including math notation tools and tests.

On a new machine, create a Python virtual environment, install the server with
`python -m pip install -e ./word-mcp`, and configure Codex's Word MCP command to
use that environment's `word_mcp_server` executable. Install the skill by
pointing the Codex `skills/document-authoring` directory at this repository
(a directory junction works on Windows).

Both components are edited here. Local MCP source changes take effect after
the server restarts; commit and push to `main` to share skill and MCP changes
together. The Word MCP code retains its upstream MIT license in
`word-mcp/LICENSE`.
