#!/bin/bash
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE=$(dirname $PWD)
ERR=""
which atom || ERR="$ERR No suitable Atom in path found." 
which pip  || ERR="$ERR No suitable Python in path found"
export ATOM_HOME=$BASE/project/atom
mkdir -p $ATOM_HOME
if test -n "$ERR"
then echo "$ERR"
else 
  sudo pip install jupyter 
  curl -L -o jupyter-scala-2.10 https://git.io/vzhR7 && chmod +x jupyter-scala-2.10 && ./jupyter-scala-2.10 ; rm -f jupyter-scala-2.10
  curl -L -o jupyter-scala https://git.io/vzhRi && chmod +x jupyter-scala && ./jupyter-scala ; rm -f jupyter-scala
  test -e $BASE/project/atom/config.json || echo '"*":' >$BASE/project/atom/config.cson
  if apm install hydrogen
  then cat >>$BASE/project/atom/config.cson <<EOF
  Hydrogen:
    kernelMappings: "{\"scala\": \"Scala 2.11\"}" 
EOF
  else echo "Cannot install Hydrogen! If this is Windows, it is normal."
  fi
fi
