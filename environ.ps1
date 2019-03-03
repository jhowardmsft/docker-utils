param (
    [Parameter(Mandatory=$false)][string]$base,
    [Parameter(Mandatory=$false)][string]$repo
)

# -------------------------------------------------------------------------------------------------
# This is an environment script for Docker development
# John Howard, Feb 2015.
#
# It assumes you have a repo root such as e:\go. Under that you
# will need a directory structure such as below. The tree is important, even if annoying.
#
#   E:\docker\utils (where this file and others go)
#   <drive>:\src\github.com\docker\docker\...
#
# To clone initially you would do something like
#    git clone https://github.com/docker/docker       e:\go\src\github.com\docker\docker
#
# Prereq:
#    Should have C:\Program Files\Git\bin\ at the end of your path. Need for ssh-agent (will see PS error otherwise)
#    Should have git powershell installed.
#
# How to use: Have a shortcut to environ.cmd BASENAME repo. eg
#    environ docker docker
#    environ docker libnetwork
#    environ docker libcontainer
#    environ opencontainers runc
#    environ docker engine-api
#    environ opencontainers specs
#    environ containerd containerd
# -------------------------------------------------------------------------------------------------     


$repoDrive="e"
$repoRoot="$repoDrive`:\go"
$env:PATH="$repoDrive`:\docker\utils;$repoRoot\bin;C:\Program Files\Git\usr\bin;c:\gcc\bin;$env:PATH"

$gitRoot=$repoRoot
$env:GOARCH="amd64"
$env:GOOS="windows"
$env:GOEXE=".exe"
cd "$gitRoot\src\github.com\$base\$repo"

# -------- GOPATH Madness ------------

if ($repo -eq "docker") {
Write-Output ""
#$hcsshim="$repoRoot\src\github.com\Microsoft\hcsshim\"
#$containerd="$repoRoot\src\github.com\containerd\containerd"
$engine="$repoRoot\src\github.com\docker\docker"
#$cli="$repoRoot\src\github.com\docker\cli"

#$env:PATH="e:\binaries;$engine\hack;$env:PATH"
$env:PATH="e:\binaries;$env:PATH"
Get-Content "$repoDrive`:\docker\utils\docker.ascii"
Write-Output ""
    $env:GOPATH=$gitRoot
    Write-Output "To build docker, run make.ps1 -Binary"
	#$env:BUILD_WINDOWS_V2=1
	#Write-Output "Have set BUILD_WINDOWS_V2=1 for containerd compilation"

	$env:DOCKER_WINDOWS_CONTAINERD_RUNTIME=1
	Write-Output "Have set DOCKER_WINDOWS_CONTAINERD_RUNTIME=1 for containerd runtime."
	Write-Output "Need to add --containerd \\.\pipe\containerd-containerd as well"
	
	}
# On libnetwork we need the Godeps\_workspace directory
if ($repo -eq "libnetwork") {
Write-Output ""
Get-Content "$repoDrive`:\docker\utils\docker.ascii"
Write-Output ""
    #TODO set GOPATH=%GOPATH%;%GITROOT%\src\github.com\docker\libnetwork\Godeps\_workspace;%GITROOT%
    Write-Output   including libnetwork\Godeps\_workspace             [libnetwork]...
    Write-Output   godep go build -v -o .                             ^[To build libnetwork^]
}

# On containerd we need the vendor directory
if ($repo -eq "containerd") {
Write-Output ""
Get-Content "$repoDrive`:\docker\utils\containerd.ascii"
Write-Output ""
    $env:GOPATH=$gitRoot
    #TODO set GOPATH=%GITROOT%\src\github.com\containerd\containerd\vendor;%GITROOT%
    #Write-Output   including containerd\vendor                         [containerd]...
    #Write-Output   bcontainerd                                         ^[To build containerd^]
}

Write-Output ""
# -------- END GOPATH Madness --------

Write-Output ""

