# wifi-common.ps1 - shared helpers, dot-sourced by the other scripts.
# Reads WiFi info from Windows (netsh) and reads/writes the local credentials file.
# The credentials file lives OUTSIDE every git repo (default D:\Secrets\wifi-credentials.json).

[Console]::OutputEncoding = [Text.Encoding]::UTF8   # keep non-ASCII SSIDs readable from netsh

$script:DefaultCredentialsPath = 'D:\Secrets\wifi-credentials.json'

function Get-NetshLines([string[]]$ArgList) {
  $out = & netsh @ArgList 2>$null
  if (-not $out) { return @() }
  return @($out)
}

# Current WiFi connection of this PC. Returns $null when not connected to WiFi (e.g. Ethernet only).
function Get-PcConnection {
  $cur = $null; $result = $null
  foreach ($line in (Get-NetshLines @('wlan', 'show', 'interfaces'))) {
    if ($line -match '^\s+Name\s+:\s(.*)$') {
      if ($cur -and $cur.State -eq 'connected' -and -not $result) { $result = $cur }
      $cur = @{ Name = $Matches[1].Trim() }
      continue
    }
    if ($cur -and $line -match '^\s+(State|SSID|Band|Authentication|Profile)\s+:\s(.*)$') {
      $cur[$Matches[1]] = $Matches[2].Trim()
    }
  }
  if ($cur -and $cur.State -eq 'connected' -and -not $result) { $result = $cur }
  if (-not $result -or -not $result.SSID) { return $null }
  return [pscustomobject]@{
    Ssid = $result.SSID; Band = $result.Band; Auth = $result.Authentication
    Profile = $(if ($result.Profile) { $result.Profile } else { $result.SSID })
  }
}

# Networks the PC can see right now: one object per SSID with the best signal per band.
function Get-VisibleNetworks {
  $nets = @{}; $ssid = $null; $auth = $null; $signal = 0
  foreach ($line in (Get-NetshLines @('wlan', 'show', 'networks', 'mode=bssid'))) {
    if ($line -match '^SSID \d+\s*:\s?(.*)$') { $ssid = $Matches[1].Trim(); $auth = $null; continue }
    if (-not $ssid) { continue }   # hidden network (empty SSID) or header
    if ($line -match '^\s+Authentication\s+:\s(.*)$') { $auth = $Matches[1].Trim(); continue }
    if ($line -match '^\s+Signal\s+:\s(\d+)%') { $signal = [int]$Matches[1]; continue }
    if ($line -match '^\s+Band\s+:\s(.*)$') {
      $band = $Matches[1].Trim()
      if (-not $nets.ContainsKey($ssid)) { $nets[$ssid] = [pscustomobject]@{ Ssid = $ssid; Auth = $auth; Bands = @{} } }
      $b = $nets[$ssid].Bands
      if (-not $b.ContainsKey($band) -or $b[$band] -lt $signal) { $b[$band] = $signal }
    }
  }
  return @($nets.Values)
}

function Test-Is24GHz($net) { return [bool]($net.Bands.Keys | Where-Object { $_ -like '2.4*' }) }
function Get-BestSignal($net, [switch]$Only24) {
  $keys = $net.Bands.Keys
  if ($Only24) { $keys = $keys | Where-Object { $_ -like '2.4*' } }
  $vals = @($keys | ForEach-Object { $net.Bands[$_] })
  if (-not $vals) { return -1 }
  return ($vals | Measure-Object -Maximum).Maximum
}

# Names of WiFi profiles saved on this PC.
function Get-SavedProfileNames {
  $names = @()
  foreach ($line in (Get-NetshLines @('wlan', 'show', 'profiles'))) {
    if ($line -match '^\s{4}\S.*?\s+:\s(.+)$') { $names += $Matches[1].Trim() }
  }
  return $names
}

# Password of a saved Windows WiFi profile, via a temporary XML export that is deleted at once.
function Get-ProfileKey([string]$ProfileName) {
  $tmpRoot = Join-Path (Split-Path $script:DefaultCredentialsPath) '.tmp'
  $tmp = Join-Path $tmpRoot ([guid]::NewGuid().ToString('N'))
  New-Item -ItemType Directory -Force $tmp | Out-Null
  try {
    & netsh wlan export profile "name=$ProfileName" key=clear "folder=$tmp" | Out-Null
    $f = Get-ChildItem $tmp -Filter *.xml | Select-Object -First 1
    if (-not $f) { return $null }
    [xml]$x = Get-Content $f.FullName -Raw -Encoding UTF8
    $sec = $x.WLANProfile.MSM.security
    if ($sec.authEncryption.authentication -match 'open') { return '' }
    return [string]$sec.sharedKey.keyMaterial
  } finally {
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    if (-not (Get-ChildItem $tmpRoot -Force -ErrorAction SilentlyContinue)) { Remove-Item $tmpRoot -Force -ErrorAction SilentlyContinue }
  }
}

# "My Cafe_5Ghz" -> "mycafe": used to find the 2.4 GHz sibling of a 5 GHz network.
function Get-BaseName([string]$Ssid) {
  $s = $Ssid.ToLowerInvariant()
  $s = $s -replace '[\s_\-\.]*(5|2\.?4)\s*g(hz)?\b', ''
  return ($s -replace '[\s_\-\.]', '')
}

function Read-Credentials([string]$Path = $script:DefaultCredentialsPath) {
  if (-not (Test-Path $Path)) { return [pscustomobject]@{ portalPassword = $null; networks = @() } }
  $c = Get-Content $Path -Raw -Encoding UTF8 | ConvertFrom-Json
  if (-not $c.PSObject.Properties['networks']) { $c | Add-Member networks @() }
  if (-not $c.PSObject.Properties['portalPassword']) { $c | Add-Member portalPassword $null }
  $c.networks = @($c.networks)
  return $c
}

function Write-Credentials($Cred, [string]$Path = $script:DefaultCredentialsPath) {
  $dir = Split-Path $Path
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  $json = $Cred | ConvertTo-Json -Depth 5
  [IO.File]::WriteAllText($Path, $json, (New-Object Text.UTF8Encoding $false))
}

# Add or update one network. Returns 'added', 'updated' or 'same'.
function Set-CredentialEntry($Cred, [string]$Ssid, [string]$Password, [string]$Source, [string]$Band = '', [string]$Note = '') {
  $today = Get-Date -Format 'yyyy-MM-dd'
  $hit = $Cred.networks | Where-Object { $_.ssid -ceq $Ssid } | Select-Object -First 1
  if ($hit) {
    if ($hit.password -ceq $Password) { return 'same' }
    $hit.password = $Password; $hit.source = $Source; $hit.added = $today
    return 'updated'
  }
  $Cred.networks = @($Cred.networks) + [pscustomobject]@{ ssid = $Ssid; password = $Password; band = $Band; source = $Source; added = $today; note = $Note }
  return 'added'
}

function Hide-Password([string]$p) {
  if ($null -eq $p -or $p -eq '') { return '(open)' }
  if ($p.Length -le 2) { return '**' }
  return $p.Substring(0, 1) + ('*' * ($p.Length - 2)) + $p.Substring($p.Length - 1)
}

# What the PC is connected to, turned into networks an ESP32 can use.
# A 5 GHz connection is replaced by its visible 2.4 GHz sibling when one exists.
function Get-PcWifiCandidates([switch]$Allow5GHz) {
  $conn = Get-PcConnection
  if (-not $conn) {
    return [pscustomobject]@{ Connection = $null; Candidates = @(); Problem = 'PC is not connected to WiFi (Ethernet only?). No SSID to take.' }
  }
  if ($conn.Auth -match 'Enterprise|802\.1X') {
    return [pscustomobject]@{ Connection = $conn; Candidates = @(); Problem = "PC network '$($conn.Ssid)' uses $($conn.Auth); a plain SSID + password will not work on the ESP32." }
  }
  $key = Get-ProfileKey $conn.Profile
  $is5 = $conn.Band -notlike '2.4*'
  $cands = @()
  if (-not $is5 -or $Allow5GHz) {
    $cands += [pscustomobject]@{ Ssid = $conn.Ssid; Password = $key; Band = $conn.Band; Note = 'PC current network' }
    return [pscustomobject]@{ Connection = $conn; Candidates = $cands; Problem = $null }
  }

  # 5 GHz: look for a 2.4 GHz band of the same router.
  $visible = Get-VisibleNetworks
  $profiles = Get-SavedProfileNames
  $base = Get-BaseName $conn.Ssid
  foreach ($n in $visible) {
    if (-not (Test-Is24GHz $n)) { continue }
    if ($n.Ssid -ceq $conn.Ssid) {
      $cands += [pscustomobject]@{ Ssid = $n.Ssid; Password = $key; Band = '2.4 GHz'; Note = 'same SSID also on 2.4 GHz' }
    } elseif ((Get-BaseName $n.Ssid) -eq $base) {
      if ($profiles -contains $n.Ssid) {
        $cands += [pscustomobject]@{ Ssid = $n.Ssid; Password = (Get-ProfileKey $n.Ssid); Band = '2.4 GHz'; Note = '2.4 GHz sibling, password from saved profile' }
      } else {
        $cands += [pscustomobject]@{ Ssid = $n.Ssid; Password = $key; Band = '2.4 GHz'; Note = '2.4 GHz sibling, ASSUMED same password as 5 GHz (unverified)' }
      }
    }
  }
  $problem = $null
  if (-not $cands) {
    $problem = "PC is on '$($conn.Ssid)' ($($conn.Band)) and no 2.4 GHz band of it is visible. Classic ESP32/S2/S3/C3/C6 only use 2.4 GHz (ESP32-C5 can use 5 GHz: pass -Allow5GHz)."
  }
  return [pscustomobject]@{ Connection = $conn; Candidates = $cands; Problem = $problem }
}
