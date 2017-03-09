#!sh
export DOCKER_CLIENTONLY=1
export DOCKER_HOST=tcp://jhoward-ubuntu:2375
export DOCKER_TEST_HOST=tcp://jhoward-ubuntu:2375
cd /e/repos/docker-master/src/github.com/docker/docker
export GOPATH=/e/repos/docker-master/src/github.com/docker/docker/vendor:/e/repos/docker-master
TESTFLAGS="-check.vv -check.f $1" hack/make.sh binary test-integration-cli
