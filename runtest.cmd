@echo off

setlocal 

if "%1" == "" goto usage:
if "%2" == "" goto usage:

if /I "%1" == "l" (
    set DOCKER_REMOTE_DAEMON=1
    set DOCKER_TEST_HOST=tcp://jhoward-ubuntu:2375
    set DOCKER_HOST=tcp://jhoward-ubuntu:2375
)

if /I "%1" == "w" (
    set DOCKER_REMOTE_DAEMON=
	set DOCKER_TEST_HOST=npipe:////./pipe/docker_engine
	set DOCKER_HOST=npipe:////./pipe/docker_engine
)

if /I "%1" == "wr" (
    if /I "%DOCKER_HOST%" == "" (
        echo You need to set your DOCKER_HOST to the remote Windows daemon eg tcp://ip:2375
        goto done:
    )
    set DOCKER_REMOTE_DAEMON=1
    set DOCKER_TEST_HOST=%DOCKER_HOST%
)

echo Running test %2
echo DOCKER_TEST_HOST=%DOCKER_TEST_HOST%
pushd \go\src\github.com\docker\docker\integration-cli

echo DOCKER_HOST=%DOCKER_HOST%
rem Optional -race....
go test --test.timeout=240m -test.v -check.v -check.f %2 github.com\docker\docker\integration-cli
popd

goto done:

:usage
echo Usage: runtest u|w testname 
echo        l=linux (remote) w=windows (local) wr=windows (remote)

:done
endlocal