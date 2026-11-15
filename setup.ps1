<#
  setup.ps1: connects every installed AI host on this machine to D:\Personal-Skills.
  Hosts: Claude, Codex, Copilot, Antigravity.
  - Creates a junction for every skill (any folder that holds a SKILL.md) in each host's skills folder.
  - Adds a line pointing to GLOBAL_RULES.md to each host's global rules file (only if that line is not already there).
  Skips hosts that are not installed, and never overwrites an existing file or folder.
  Run:  powershell -ExecutionPolicy Bypass -File D:\Personal-Skills\setup.ps1  [-All] [-WhatIf]
    -All     also set up hosts whose config folder does not exist yet
    -WhatIf  only show what would be done
#>
[CmdletBinding(SupportsShouldProcess)]
param([switch]$All)

$root  = $PSScriptRoot
$rules = Join-Path $root 'GLOBAL_RULES.md'
$U     = $env:USERPROFILE

# Host -> config folder, skills folder(s), global rules file, line to add
$hosts = @(
  @{ Name='Claude';  Home="$U\.claude";  Skills=@("$U\.claude\skills");  Rules="$U\.claude\CLAUDE.md";
     Line="@$($rules -replace '\\','/')" }
  @{ Name='Codex';   Home="$U\.codex";   Skills=@("$U\.codex\skills");   Rules="$U\.codex\AGENTS.md";
     Line="Read and follow the global rules in $rules." }
  @{ Name='Copilot'; Home="$U\.copilot"; Skills=@("$U\.copilot\skills"); Rules="$U\.copilot\copilot-instructions.md";
     Line="Read and follow the global rules in $rules." }
  # Antigravity: global rules live in ~/.gemini/GEMINI.md; the skills folder differs by version, so both paths are covered.
  @{ Name='Antigravity'; Home="$U\.gemini"; Skills=@("$U\.gemini\antigravity\skills", "$U\.gemini\config\skills");
     Rules="$U\.gemini\GEMINI.md"; Line="Read and follow the global rules in $rules." }
)

$skills = Get-ChildItem $root -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }
Write-Host "Skills found: $($skills.Name -join ', ')"

foreach ($h in $hosts) {
  if (-not $All -and -not (Test-Path $h.Home)) { Write-Host "[$($h.Name)] not installed ($($h.Home)), skipped"; continue }
  Write-Host "[$($h.Name)]"

  foreach ($dir in $h.Skills) {
    if (-not (Test-Path $dir) -and $PSCmdlet.ShouldProcess($dir, 'Create folder')) { New-Item -ItemType Directory -Force $dir | Out-Null }
    foreach ($s in $skills) {
      $link = Join-Path $dir $s.Name
      $item = Get-Item $link -Force -ErrorAction SilentlyContinue
      if ($item) {
        if ($item.LinkType -eq 'Junction' -and $item.Target -contains $s.FullName) { Write-Host "  ok    $link" }
        else { Write-Warning "  $link already exists and does not point to $($s.FullName); left unchanged" }
        continue
      }
      if ($PSCmdlet.ShouldProcess($link, "Junction -> $($s.FullName)")) {
        New-Item -ItemType Junction -Path $link -Target $s.FullName | Out-Null
        Write-Host "  link  $link"
      }
    }
  }

  $hasLine = (Test-Path $h.Rules) -and (Select-String -Path $h.Rules -SimpleMatch $rules, ($rules -replace '\\','/') -Quiet)
  if ($hasLine) { Write-Host "  ok    $($h.Rules) already points to GLOBAL_RULES.md" }
  elseif ($PSCmdlet.ShouldProcess($h.Rules, 'Add line pointing to GLOBAL_RULES.md')) {
    Add-Content -Path $h.Rules -Encoding utf8 -Value "`n# Global rules`n$($h.Line)"
    Write-Host "  rule  $($h.Rules)"
  }
}
Write-Host "Done. Word MCP (document-authoring) must still be installed by hand: see document-authoring\word-mcp."
