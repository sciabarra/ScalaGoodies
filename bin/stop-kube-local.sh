#!/usr/bin/env bash
KUBE_IDS="$(docker ps | grep gcr.io/google_containers | awk '{ print $1}')"
if test -n "$KUBE_IDS" ; then
  docker stop $KUBE_IDS
  docker rm $KUBE_IDS
fi
TUNNELS=$(ps auwwx | grep docker-machine | grep 8080:localhost:8080 | awk '{ print $2}' )
if test -n "$TUNNELS"
then kill -9 $TUNNELS
fi
