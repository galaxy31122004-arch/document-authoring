<#
  get-pc-wifi.ps1 - read the WiFi network this PC is using (SSID + saved password)
  and turn it into networks an ESP32 can join (5 GHz -> 2.4 GHz sibling when visible).

  Run:  powershell -ExecutionPolicy Bypass -File get-pc-wifi.ps1 [-Save] [-ShowPassword] [-Allow5GHz] [-Json]
    -Save          add the usable result to the credentials file (default D:\Secrets\wifi-credentials.json)
    -ShowPassword  print passwords in clear (default: masked)
    -Allow5GHz     accept a 5 GHz network as is (only for ESP32-C5)
    -Json          machine-readable output (passwords masked unless -ShowPassword)
  Exit codes: 0 ok, 2 no usable network found.
#>
param(
  [string]$CredentialsPath = 'D:\Secrets\wifi-credentials.json',
  [switch]$Save, [switch]$ShowPassword, [switch]$Allow5GHz, [switch]$Json
)
. (Join-Path $PSScriptRoot 'wifi-common.ps1')

$r = Get-PcWifiCandidates -Allow5GHz:$Allow5GHz
$shown = @($r.Candidates | ForEach-Object {
  [pscustomobject]@{ ssid = $_.Ssid; password = $(if ($ShowPassword) { $_.Password } else { Hide-Password $_.Password }); band = $_.Band; note = $_.Note }
})

$saved = @()
if ($Save -and $r.Candidates) {
  $cred = Read-Credentials $CredentialsPath
  foreach ($c in $r.Candidates) {
    $st = Set-CredentialEntry $cred $c.Ssid $c.Password 'pc' $c.Band $c.Note
    $saved += "$st $($c.Ssid)"
  }
  Write-Credentials $cred $CredentialsPath
}

if ($Json) {
  [pscustomobject]@{
    pcConnection = $r.Connection; candidates = $shown; problem = $r.Problem; saved = $saved; credentialsPath = $CredentialsPath
  } | ConvertTo-Json -Depth 5
} else {
  if ($r.Connection) { Write-Host "PC connected to: $($r.Connection.Ssid)  [$($r.Connection.Band), $($r.Connection.Auth)]" }
  if ($shown) { Write-Host 'Usable for ESP32:'; $shown | Format-Table -AutoSize | Out-String | Write-Host }
  if ($r.Problem) { Write-Warning $r.Problem }
  foreach ($s in $saved) { Write-Host "Credentials file: $s" }
}
if (-not $r.Candidates) { exit 2 }
exit 0
