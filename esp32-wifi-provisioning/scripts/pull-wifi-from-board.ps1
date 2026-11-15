<#
  pull-wifi-from-board.ps1 - read the networks stored in a board running wifi_nvs firmware
  and save the ones entered ON THE BOARD (setup portal) into the local credentials file.

  Sends "#wifi-list" over serial and reads the "#wifi ..." reply. Retries for -TimeoutSec
  because the board may be busy connecting right after boot. Does not reset the board.

  Run:  powershell -ExecutionPolicy Bypass -File pull-wifi-from-board.ps1 -Port COM10 [-Baud 115200] [-All] [-TimeoutSec 40]
    -All   also take the built-in networks (normally skipped: they came from this PC already,
           and an old firmware could hold an outdated password)
  Exit codes: 0 ok, 3 no answer (port busy, other firmware, or WIFI_NVS_SERIAL_CMDS off).
#>
param(
  [Parameter(Mandatory)][string]$Port,
  [int]$Baud = 115200, [int]$TimeoutSec = 40, [switch]$All,
  [string]$CredentialsPath = 'D:\Secrets\wifi-credentials.json'
)
. (Join-Path $PSScriptRoot 'wifi-common.ps1')

$sp = New-Object System.IO.Ports.SerialPort $Port, $Baud
$sp.DtrEnable = $false; $sp.RtsEnable = $false   # do not reset the board
$sp.Encoding = [Text.Encoding]::UTF8
$sp.ReadTimeout = 500; $sp.NewLine = "`n"
try { $sp.Open() } catch { Write-Error "Cannot open ${Port}: $($_.Exception.Message) (close the serial monitor first)"; exit 3 }

$nets = @(); $done = $false
$deadline = (Get-Date).AddSeconds($TimeoutSec); $nextSend = Get-Date
try {
  while (-not $done -and (Get-Date) -lt $deadline) {
    if ((Get-Date) -ge $nextSend) { $sp.Write("#wifi-list`n"); $nextSend = (Get-Date).AddSeconds(3) }
    try { $line = $sp.ReadLine().Trim() } catch [TimeoutException] { continue }
    if ($line -like '#wifi-begin*') { $nets = @(); continue }
    if ($line -like '#wifi {*') { $nets += ($line.Substring(6) | ConvertFrom-Json); continue }
    if ($line -eq '#wifi-end') { $done = $true }
  }
} finally { $sp.Close() }

if (-not $done) { Write-Warning "No answer from the board on $Port within $TimeoutSec s."; exit 3 }

$cred = Read-Credentials $CredentialsPath
$rows = foreach ($n in $nets) {
  $take = $All -or $n.origin -eq 'portal'
  $st = if ($take) { Set-CredentialEntry $cred $n.ssid $n.pass 'board' } else { 'skipped (built-in)' }
  [pscustomobject]@{ ssid = $n.ssid; password = (Hide-Password $n.pass); origin = $n.origin; result = $st }
}
Write-Credentials $cred $CredentialsPath
Write-Host "Board on $Port holds $(@($nets).Count) network(s):"
$rows | Format-Table -AutoSize | Out-String | Write-Host
exit 0
