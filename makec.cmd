pushd e:\go\src\github.com\docker\cli
sh -c make binary
cp build\docker \go\src\github.com\docker\docker\bundles\docker.exe
popd