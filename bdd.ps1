$ErrorActionPreference="Stop"

$binaries = "e:\binaries"
if (-not (Test-Path $binaries)) { mkdir $binaries }

Write-Host -ForegroundColor Green "Building dockerd.exe (docker/docker)"
pushd E:\go\src\github.com\docker\docker
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\dockerd.exe -PathType Leaf) { del $binaries\dockerd.exe }
if (Test-Path c:\windows\system32\dockerd.exe -PathType Leaf) { del c:\windows\system32\dockerd.exe }
hack\make.ps1
move bundles\dockerd.exe $binaries
popd
echo `n



