$ErrorActionPreference="Stop"

$binaries = "e:\binaries"
if (-not (Test-Path $binaries)) { mkdir $binaries }

Write-Host -ForegroundColor Green "Building containerd.exe (containerd/containerd)"
pushd e:\go\src\github.com\containerd\containerd\cmd\containerd
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\containerd.exe -PathType Leaf) { del $binaries\containerd.exe }
if (Test-Path c:\windows\system32\containerd.exe -PathType Leaf) { del $binaries\containerd.exe }
go build -v -o $binaries\containerd.exe
popd
echo `n

Write-Host -ForegroundColor Green "Building containerd-shim-runhcs-v1.exe (Microsoft/hcsshim)"
pushd E:\go\src\github.com\Microsoft\hcsshim\cmd\containerd-shim-runhcs-v1
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\containerd-shim-runhcs-v1.exe -PathType Leaf) { del $binaries\containerd-shim-runhcs-v1.exe }
if (Test-Path c:\windows\system32\containerd-shim-runhcs-v1.exe -PathType Leaf) { del c:\windows\system32\containerd.exe }
go build -v -o $binaries\containerd-shim-runhcs-v1.exe
popd
echo `n

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

Write-Host -ForegroundColor Green "Building docker.exe (docker/cli)"
pushd E:\go\src\github.com\docker\cli\cmd\docker
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\docker.exe -PathType Leaf) { del $binaries\docker.exe }
if (Test-Path c:\windows\system32\docker.exe -PathType Leaf) { del c:\windows\system32\docker.exe }
go build -v -o $binaries\docker.exe
popd
echo `n


Write-Host -ForegroundColor Green "Building docker-signal.exe (jhowardmsft/docker-signal)"
pushd E:\go\src\github.com\jhowardmsft\docker-signal
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\docker-signal.exe -PathType Leaf) { del $binaries\docker-signal.exe }
if (Test-Path c:\windows\system32\docker-signal.exe -PathType Leaf) { del c:\windows\system32\docker-signal.exe }
go build -v -o $binaries\docker-signal.exe
popd
echo `n

Write-Host -ForegroundColor Green "Building runhcs.exe (Microsoft/hcsshim)"
pushd E:\go\src\github.com\Microsoft\hcsshim\cmd\runhcs
$branch = git rev-parse --abbrev-ref HEAD
if (Test-Path $binaries\runhcs.exe -PathType Leaf) { del $binaries\runhcs.exe }
if (Test-Path c:\windows\system32\runhcs.exe -PathType Leaf) { del c:\windows\system32\runhcs.exe }
go build -v -o $binaries\runhcs.exe
popd
echo `n

Write-Host -ForegroundColor Green "Building tar2ext4.exe (Microsoft/hcsshim)"
pushd E:\go\src\github.com\Microsoft\hcsshim\cmd\tar2ext4
$branch = git rev-parse --abbrev-ref HEAD
if (Test-Path $binaries\tar2ext4.exe -PathType Leaf) { del $binaries\tar2ext4.exe }
if (Test-Path c:\windows\system32\tar2ext4.exe -PathType Leaf) { del c:\windows\system32\tar2ext4.exe }
go build -v -o $binaries\tar2ext4.exe
popd
echo `n

Write-Host -ForegroundColor Green "Building wclayer.exe (Microsoft/hcsshim)"
pushd E:\go\src\github.com\Microsoft\hcsshim\cmd\wclayer
$branch = git rev-parse --abbrev-ref HEAD
if (Test-Path $binaries\wclayer.exe -PathType Leaf) { del $binaries\wclayer.exe }
if (Test-Path c:\windows\system32\wclayer.exe -PathType Leaf) { del c:\windows\system32\wclayer.exe }
go build -v -o $binaries\wclayer.exe
popd
echo `n

Write-Host -ForegroundColor Green "Building uvmboot.exe (Microsoft/hcsshim)"
pushd E:\go\src\github.com\Microsoft\hcsshim\tools\uvmboot
$branch = git rev-parse --abbrev-ref HEAD
if (Test-Path $binaries\uvmboot.exe -PathType Leaf) { del $binaries\uvmboot.exe }
if (Test-Path c:\windows\system32\uvmboot.exe -PathType Leaf) { del c:\windows\system32\uvmboot.exe }
go build -v -o $binaries\uvmboot.exe
popd
echo `n

Write-Host -ForegroundColor Green "Building ctr.exe (containerd/containerd)"
pushd e:\go\src\github.com\containerd\containerd\cmd\ctr
$branch = git rev-parse --abbrev-ref HEAD
if ($branch -eq "master") { git pull } else { Write-Host -ForegroundColor Red " - Warn: Not on master ($branch)" }
if (Test-Path $binaries\ctr.exe -PathType Leaf) { del $binaries\ctr.exe }
if (Test-Path c:\windows\system32\ctr.exe -PathType Leaf) { del c:\windows\system32\ctr.exe }
go build -v -o $binaries\ctr.exe
popd
echo `n
