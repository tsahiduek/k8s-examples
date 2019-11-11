# get all nodes
kn -Lbeta.kubernetes.io/instance-type -Lfailure-domain.beta.kubernetes.io/zone

# deploy pod with nodeSelector
k apply -f nodeselector-instance-type.yaml

# deploy pod with nodeAffinity
k apply -f nodeselector-in-nodeaffinity.yaml

# deploy 2 pods in the same host
k apply -f pod-affinity.yaml
k get pods -lservice=core -o wide

# deploy 1 pod not with service=core
k apply -f pod-antiaffinity.yaml
k get pods -lservice=not-core -o wide

# deploy 1 pod per host
k apply -f deployment-ha-host.yaml
k get pods -lapp=antiaffinity-host -o wide

# deploy 1 pod per host spread AZ
k apply -f deployment-ha-host-zone.yaml
k get pods -lapp=pod-ha-host-zone -o wide


# cleanup
k delete -f nodeselector-instance-type.yaml
k delete -f nodeselector-in-nodeaffinity.yaml
k delete -f pod-affinity.yaml
k delete -f pod-antiaffinity.yaml
k delete -f deployment-ha-host.yaml
k delete -f deployment-ha-host-zone.yaml
