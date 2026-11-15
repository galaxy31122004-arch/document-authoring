<#
  add-wifi.ps1 - manage the local WiFi credentials file (outside git).
  Run:
    add-wifi.ps1 -Ssid "Home" -Password "secret"     add or update a network
    add-wifi.ps1 -Remove "Home"                      remove a network
    add-wifi.ps1 -List                               list networks (passwords masked)
#>
param(
  [string]$Ssid, [string]$Password = '', [string]$Remove, [switch]$List,
  [string]$CredentialsPath = 'D:\Secrets\wifi-credentials.json'
)
. (Join-Path $PSScriptRoot 'wifi-common.ps1')
$cred = Read-Credentials $CredentialsPath

if ($Ssid) {
  if ($Password -and $Password.Length -lt 8) { Write-Warning 'WPA2 passwords are 8-63 characters; check this one.' }
  $st = Set-CredentialEntry $cred $Ssid $Password 'manual'
  Write-Credentials $cred $CredentialsPath
  Write-Host "$st $Ssid"
}
if ($Remove) {
  $before = @($cred.networks).Count
  $cred.networks = @($cred.networks | Where-Object { $_.ssid -cne $Remove })
  Write-Credentials $cred $CredentialsPath
  Write-Host "removed $($before - @($cred.networks).Count) entry: $Remove"
}
if ($List -or (-not $Ssid -and -not $Remove)) {
  Write-Host "File: $CredentialsPath"
  $cred.networks | ForEach-Object {
    [pscustomobject]@{ ssid = $_.ssid; password = (Hide-Password $_.password); band = $_.band; source = $_.source; added = $_.added }
  } | Format-Table -AutoSize | Out-String | Write-Host
}
