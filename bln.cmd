@echo off

echo Compiling libnetwork

rem go build -v -a -gcflags "-N -l" %1
REM set LNVENDOR=%GITROOT%\src\github.com\docker\libnetworkvendor

rem rmdir /s %LNVENDOR%
rem git clone https://github.com/sirupsen/logrus %LNVENDOR%/src/github.com/sirupsen/logrus
rem git clone https://github.com/godbus/dbus %LNVENDOR%/src/github.com/godbus/dbus
rem git clone https://github.com/vishvananda/netlink %LNVENDOR%/src/github.com/vishvananda/netlink

set GOPATH=%GOPATH%;%LNVENDOR%;
go build -v -a %1

rem go build v -a -gcflags "-N -l"
