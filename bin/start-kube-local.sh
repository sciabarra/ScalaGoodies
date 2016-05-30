#!/usr/bin/env bash
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $HERE/install-kube.sh
if ! $HERE/kubectl get nodes 2>/dev/null >/dev/null 
then docker run -d -p 5000:5000 \
    --restart=always --name registry registry:2
     docker run -d \
    --volume=/:/rootfs:ro \
    --volume=/sys:/sys:rw \
    --volume=/var/lib/docker/:/var/lib/docker:rw \
    --volume=/var/lib/kubelet/:/var/lib/kubelet:rw \
    --volume=/var/run:/var/run:rw \
    --net=host \
    --pid=host \
    --privileged \
    gcr.io/google_containers/hyperkube-${ARCH}:${K8S_VERSION} \
    /hyperkube kubelet \
        --containerized \
        --hostname-override=127.0.0.1 \
        --api-servers=http://localhost:8080 \
        --config=/etc/kubernetes/manifests \
        --cluster-dns=8.8.8.8 \
        --cluster-domain=loc \
        --allow-privileged --v=2
   if docker-machine active 2>&1 >/dev/null  
   then docker-machine ssh `docker-machine active` -N -L 8080:localhost:8080 &
   fi
fi
