#!/bin/bash
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SVC=${1:?service}
LPORT=${2:?local port}
if $HERE/kubectl get svc $SVC
then IP=$($HERE/kubectl get svc $SVC -o jsonpath={.spec.clusterIP})
     PORT=$($HERE/kubectl get svc $SVC -o jsonpath={.spec.ports[0].port})
     echo "Forwarding localhost:$LPORT to $IP:$PORT. Press ^c to end"
     docker-machine ssh `docker-machine active` -L $LPORT:$IP:$PORT -N
else echo "No such service"
fi
