#!/bin/bash
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE=$(dirname $HERE)
export ATOM_HOME=$BASE/project/atom
cd $BASE
bin/esbt.sh ensimeConfig
atom .
