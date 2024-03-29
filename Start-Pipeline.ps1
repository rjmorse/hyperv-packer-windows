[CmdletBinding()]
param (
    [switch]$Build2012r2,
    [switch]$Build2016,
    [switch]$Build2019
)

$timer = [system.diagnostics.stopwatch]::StartNew()
Write-Output $("Starting at {0}" -f (Get-date))
Write-Output "Generating unattend ISOs for 2016"
.\make_unattend_iso.ps1

Write-Output "Running validation of 2012r2, 2016 and 2019 Packer config files"
$errors = 0

Write-Output $("Time now: {0}" -f (Get-date))
Write-Output "Validating 2012r2"
packer validate .\windows_2012r2_uefi.json
if(-not $?){$errors += 1}

Write-Output $("Time now: {0}" -f (Get-date))
Write-Output "Validating 2016"
packer validate .\windows_2016_uefi.json
if(-not $?){$errors += 1}

Write-Output $("Time now: {0}" -f (Get-date))
Write-Output "Validating 2019"
packer validate .\windows_2019_uefi.json
if(-not $?){$errors += 1}

Write-Output $("Time now: {0}" -f (Get-date))
if($errors -gt 0){Write-Error "Errors found in validating packer configs. Please fix to continue."; return}
Write-Output "Validation complete"

if($Build2012r2){
    Write-Output "Starting Packer build for 2012r2"
    Write-Output $("Time now: {0}" -f (Get-date))
    packer build .\windows_2012r2_uefi.json
    Write-Output $("Time now: {0}" -f (Get-date))
}

if($Build2016){
    Write-Output "Starting Packer build for 2016"
    Write-Output $("Time now: {0}" -f (Get-date))
    packer build .\windows_2016_uefi.json
    Write-Output $("Time now: {0}" -f (Get-date))
}

if($Build2019){
    Write-Output "Starting Packer build for 2019"
    Write-Output $("Time now: {0}" -f (Get-date))
    packer build .\windows_2019_uefi.json
    Write-Output $("Time now: {0}" -f (Get-date))
}

Write-Output $("Job ran in {0}" -f $timer.Elapsed.ToString())