#!/bin/bash
cd $(dirname $0)
BASE=$(dirname $PWD)
ERR=""
which java || ERR="$ERR No suitable Java in path found." 
which atom || ERR="$ERR No suitable Atom in path found." 
export ATOM_HOME=$BASE/project/atom
mkdir -p $ATOM_HOME
if test -n "$ERR"
then echo "$ERR"
else 
  test -e $BASE/project/atom/config.cson || echo '"*":' >$BASE/project/atom/config.cson
  if apm install ensime 
  then cat >>$BASE/project/atom/config.cson <<EOF
  Ensime:
    "$BASE/bin/esbt.sh"
EOF
  # remove useless .ensime
  find $BASE/project/atom -name .ensime | xargs rm  
  else echo "I cannot install Ensime!"
  fi
  if ! apm install terminal-plus
  then echo "I cannot install terminal-plus"
  fi
fi
