$ErrorActionPreference="Stop"

$binaries = "e:\binaries"
if (-not (Test-Path $binaries)) { mkdir $binaries }

Write-Host -ForegroundColor Green "Building containerd-shim-runhcs-v1.exe (Microsoft/hcsshim)"
pushd E:\go\src\github.com\Microsoft\hcsshim\cmd\containerd-shim-runhcs-v1
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\containerd-shim-runhcs-v1.exe -PathType Leaf) { del $binaries\containerd-shim-runhcs-v1.exe }
if (Test-Path c:\windows\system32\containerd-shim-runhcs-v1.exe -PathType Leaf) { del c:\windows\system32\containerd.exe }
go build -v -o $binaries\containerd-shim-runhcs-v1.exe
popd
echo `n
