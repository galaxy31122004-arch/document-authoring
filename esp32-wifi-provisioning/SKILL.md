---
name: esp32-wifi-provisioning
description: Use whenever writing or changing ESP32 firmware that connects to WiFi (Arduino core / PlatformIO), or when the user gives a WiFi SSID and password for a board. Keeps the user's networks in a local file outside git, picks the ones in range, falls back to the network this PC is using, generates a gitignored wifi_secrets.h, and adds a multi-network NVS connection module with a setup portal. Never hardcode WiFi passwords in source.
---

# ESP32 WiFi provisioning

> **Mandatory:** follow the `structured-workspace` layout. The firmware project lives in `source-code/<project>/`; generated files go inside that project (see "Outputs"). Not for `D:\TMT\...` projects (GLOBAL_RULES): there, use the repo's own conventions.

## Rules

- **Never** write an SSID/password into `main.cpp`, `platformio.ini`, docs, logs, commit messages or chat replies. Passwords live only in:
  - `D:\Secrets\wifi-credentials.json`: the master list (outside every git repo), and
  - `<project>/include/wifi_secrets.h`: generated, gitignored.
- When the user gives a network in chat, save it at once and do not repeat the password back:
  `powershell -ExecutionPolicy Bypass -File D:\Personal-Skills\esp32-wifi-provisioning\scripts\add-wifi.ps1 -Ssid "<ssid>" -Password "<pass>"`
- If an existing project already has `WiFi.begin("ssid","pass")` hardcoded, move those credentials into the master list with `add-wifi.ps1`, then switch the code to `wifinvs`.

## Workflow (every ESP32 project that uses WiFi)

0. **A board is plugged in (user names a port, or before flashing a board that may already run `wifi_nvs`)**: pull the networks the user entered on the board first, so they are kept and go into the next build:
   `powershell -ExecutionPolicy Bypass -File D:\Personal-Skills\esp32-wifi-provisioning\scripts\pull-wifi-from-board.ps1 -Port COM<n>`
   - Sends `#wifi-list` over serial (does not reset the board, retries up to 40 s while the board is busy connecting) and saves only the networks with origin `portal`. Built-in ones are skipped (they came from this PC already, and an old firmware may hold an outdated password); `-All` takes them too.
   - Exit 3 = no answer: serial monitor still open, a different firmware, or `WIFI_NVS_SERIAL_CMDS 0`. Not an error to stop for; tell the user and continue.
   - Close any serial monitor first; the port can be opened by one program only.
1. **Generate secrets + copy the module**
   `powershell -ExecutionPolicy Bypass -File D:\Personal-Skills\esp32-wifi-provisioning\scripts\make-wifi-secrets.ps1 -Project <folder with platformio.ini>`
   - The script checks which saved networks the PC can see. If **none** is in range, it takes the PC's current network (`get-pc-wifi` logic), saves it to the master list, and uses it.
   - It writes `include/wifi_secrets.h` (in-range networks first, max 8), adds it to `.gitignore`, warns if git already tracks it, and copies `include/wifi_nvs.h` + `src/wifi_nvs.cpp` when missing (an existing copy is never overwritten).
   - It adds a "WiFi ESP32" section (rules + commands + list of WiFi projects) to the nearest `AGENTS.md` up the tree, i.e. the workspace root. Outside any workspace it creates `AGENTS.md` + `CLAUDE.md` (`@AGENTS.md`) in the project. Idempotent; `-NoAgentsNote` skips it. Do this for **every** new or existing ESP32 WiFi project so later sessions (any AI host) are pointed here.
   - `-Allow5GHz` only for ESP32-C5. `-NoPcFallback` to skip the PC network.
2. **Use it in code**
   ```cpp
   #include "wifi_nvs.h"
   void setup() { Serial.begin(115200); wifinvs::begin(); }
   void loop()  { wifinvs::loop(); /* app code; check wifinvs::isConnected() */ }
   ```
   Nothing to add to `platformio.ini` (WiFi, Preferences and WebServer come with the Arduino core).
3. **Report the script warnings to the user**, in plain words:
   - PC on **5 GHz** with no 2.4 GHz band visible: the ESP32 cannot use it. Ask the user for a 2.4 GHz network or a phone hotspot (2.4 GHz).
   - Password marked **ASSUMED** (2.4 GHz sibling of a 5 GHz network): the 5 GHz password was reused; fix it with `add-wifi.ps1` if connecting fails.
   - PC on **Ethernet** or an **Enterprise** network (WPA2-Enterprise): nothing usable to take.
   - No usable network in range: the firmware will open the setup portal.
4. **Order before every flash:** pull (step 0) → generate (step 1) → build → upload. If NVS must be wiped (`esptool erase_region 0x9000 0x5000`), do it **after** the upload: erasing resets the board, and the old firmware would write its networks back.
5. **Re-run step 1** whenever networks change, before building. Same list = same `WIFI_SECRETS_VERSION`, so the board does not rewrite flash.

Pull from a board: `scripts\pull-wifi-from-board.ps1 -Port COM<n> [-All]`. Only the PC network: `scripts\get-pc-wifi.ps1 [-Save] [-Json] [-Allow5GHz]` (exit 2 = nothing usable). List or remove saved networks: `add-wifi.ps1 -List`, `add-wifi.ps1 -Remove "<ssid>"`.

## How the firmware stores and picks networks (NVS)

- **NVS** (Non-Volatile Storage) is the key/value area of the ESP32 flash (`nvs` partition, about 20 KB). It survives reboot and re-flashing the app, and spreads writes across sectors (wear levelling). It is accessed via `Preferences`. Raw flash writes and SPIFFS are not used for credentials.
- Layout, namespace `wifi`: `ver` (hash of the built-in list), `n`, `s0..s7` / `p0..p7`, `o0..o7` (origin: 0 built-in, 1 entered on the board), `last` (last index that connected).
- Boot: NVS is synced **before** the WiFi driver starts. If `ver` differs from `WIFI_SECRETS_VERSION`, built-in entries are replaced by the new list (a network removed on the PC disappears from the board) and portal entries are kept → scan → try the last-good network first, then the others strongest first (10 s each). Nothing stored → straight to the portal.
- Serial: `wifinvs::loop()` answers `#wifi-list` with `#wifi-begin` / `#wifi {"ssid","pass","origin"}` / `#wifi-end`. It only takes input lines starting with `#`. If the app reads Serial itself, set `-DWIFI_NVS_SERIAL_CMDS=0` and pass each line to `wifinvs::handleSerialLine()`.
- ESP32-S3 on Arduino core 3.2.0 crashed ("Cache disabled but cached memory region accessed") when WiFi switched STA → AP_STA, or NVS was written, while the PHY was still starting (worst right after an NVS erase, when the PHY recalibrates). The template avoids both; keep that order if you edit it.
- No network works: AP `ESP32-Setup-XXXX` (password = `portalPassword` in the master file, also in `wifi_secrets.h`), page at `http://192.168.4.1` to pick an SSID and type the password → saved to NVS → restart. While the portal is open, known networks are retried every 5 min.
- After a drop-out of more than 60 s, the board rescans and can move to another known network.
- `WiFi.persistent(false)` stops the WiFi driver from writing its own copy to flash on every `begin()`.
- Limits: hidden SSIDs are not found (they are not in scan results); NVS is plain text unless flash/NVS encryption is enabled, so anyone with the board can read the passwords.

## ESP-IDF projects

There is no ready template yet. Reuse the same scripts (the header is plain C) and implement the same NVS layout with `nvs_open("wifi")`, `nvs_get_str`/`nvs_set_str` and `nvs_commit`, plus `esp_wifi_scan_start`. Ask the user before writing it.

## Outputs and versioning

| File | Where | Versioned? |
|---|---|---|
| `wifi_secrets.h` | `source-code/<project>/include/` | **No**: gitignored, regenerated, never copied into `versions/` |
| `wifi_nvs.h`, `wifi_nvs.cpp` | `source-code/<project>/include/`, `src/` | Yes: part of the project code, versioned with it |
| `wifi-credentials.json` | `D:\Secrets\` | No: personal data, outside every repo |

A built `firmware.bin` contains the passwords. A firmware stored in `versions/` is for the user only: before sharing it, rebuild with `-NoPcFallback` and an empty or customer-specific list.
