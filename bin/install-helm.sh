#!/usr/bin/env bash
export HELMC_VERSION="0.8.0+f3cafbc"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
which docker >/dev/null || ( echo "you need docker in path" ; exit 1)
which curl >/dev/null || ( echo "you need wget in path" ; exit 1)
which unzip >/dev/null || ( echo "you need unzip in path" ; exit 1)
which kubectl >/dev/null || ( echo "helmc is useless without kubernetes" ; exit 1)
export ARCH=$(uname -m) ; if test "$ARCH" = "x86_64" ; then export ARCH=amd64; fi
if [ "$(uname)" == "Darwin" ]; then
    export GOOS=darwin
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    export GOOS=linux
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Windows not  supported"  ; exit 1
fi
if ! test -e $HERE/helmc ; then 
  HELMZIP="helmc-$HELMC_VERSION-$GOOS-$ARCH.zip"
  URL="https://dl.bintray.com/deis/helm/$HELMZIP" 
  echo "Downloading $URL"
  curl -Ls "$URL" -O
  unzip "$HELMZIP" -d "$HERE" ; rm "$HELMZIP"
  chmod +x "$HERE/helmc"
  $HERE/helmc update
fi
test -x "$HERE/helmc" || ( echo "Cannot download helmc"; exit 1)
