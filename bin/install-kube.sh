#!/usr/bin/env bash
export K8S_VERSION=v1.2.4
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
which docker >/dev/null || ( echo "you need docker in path" ; exit 1)
which curl >/dev/null || ( echo "you need wget in path" ; exit 1)
export ARCH=$(uname -m) ; if test "$ARCH" = "x86_64" ; then export ARCH=amd64; fi
if [ "$(uname)" == "Darwin" ]; then
    export GOOS=darwin
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export GOOS=linux
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    export GOOS=windows  ; exit 1
fi
if ! test -e $HERE/kubectl ; then
  URL=http://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/${GOOS}/${ARCH}/kubectl
  echo "Downloading $URL"
  curl "$URL" >$HERE/kubectl
  chmod +x $HERE/kubectl
fi
test -x "$HERE/kubectl" || ( echo "Cannot download kubectl"; exit 1)
