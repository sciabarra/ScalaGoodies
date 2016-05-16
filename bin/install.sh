#!/bin/bash
OLDPWD="$(pwd)"
cd $(dirname $0)
for i in install-*.sh 
do echo ">>> $i" 
   bash $i
   echo "<<< $i"
done
cd "$OLDPWD"
