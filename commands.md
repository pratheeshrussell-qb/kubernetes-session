# kubectl and kind commands
This doc is a quick reference for kind + kubectl

## Manage local Clusters with kind

### Create
This uses the [kindest/node](https://hub.docker.com/r/kindest/node/) image. Which will be pulled when you run the command

```sh
kind create cluster --name test-cluster
```
you can also specify the image if you have it downloaded already or using a custom image

```sh
kind create cluster --name test-cluster --image kindest/node:v1.31.2
```

### List
```sh
kind get clusters
```
get kubectl context
```sh
kubectl cluster-info --context test-cluster
```

### Delete
```sh
kind delete cluster --name test-cluster
```

### Load images in the Cluster

```sh
kind load image-1 image-2 --name test-cluster
```

### Export Kind Cluster Kubeconfig
```sh
kind get kubeconfig --name my-cluster > kubeconfig.yaml
```

### Kind Ingress
- [Setting Up An Ingress Controller](https://kind.sigs.k8s.io/docs/user/ingress/)

**TBD**


## Kubectl Commands
You can specify namespace by adding the parameter `-n test-name` to commands dealing with resources that are namespaced    
You can specify cluster by adding the parameter `--context test-cluster` to most of the below commands   

### List Contexts
```sh
kubectl config get-contexts

kubectl config current-context

# to set a default context
kubectl config use-context <context-name>

# to set a default namespace for a specific context
kubectl config set-context <context-name> --namespace=<namespace>
# to set a default namespace for the current context
kubectl config set-context --current --namespace=my-namespace
```

### Get Resources
```sh
kubectl get pods
kubectl get services
kubectl get deployments
kubectl get namespaces
kubectl get pvc
kubectl get pv

....
```
to get all resources
```sh
kubectl get all
```
to get resources from all namespaces pass the parameter `--all-namespaces`
```sh
kubectl get pods --all-namespaces
kubectl get all --all-namespaces
```

### Describe Resources
```sh
kubectl describe pod <pod-name>
kubectl describe deployment <deployment-name>
```

### Create Resources
```sh
kubectl apply -f my-manifest.yaml
kubectl create deployment my-app --image=my-image:tag
```

To add all resources from a folder
```sh
kubectl apply -f ./k8s/
```

## kustomize commands
To build resources from kustomize overlays
```sh
kubectl kustomize ./k8s/overlays/dev 

# or
kubectl apply -k ./overlays/dev --dry-run=client -o yaml
```

To apply and delete resources from kustomize overlays
```sh
# create or update
kubectl apply -k ./k8s/overlays/dev

# delete
kubectl delete -k ./k8s/overlays/dev
```

Check diff
```sh
kubectl diff -k ./k8s/overlays/dev
```

### Edit Resources
```sh
kubectl edit pod <name>
```

### Patch Resources
```sh
kubectl patch deployment my-app -p '{"spec":{"replicas":3}}'
```
NOTE: You can get the current spec in json format using
```sh
kubectl get deployment my-app -o json
```

### Deployment Rollout
> [!TIP]  
> use the annotation `kubernetes.io/change-cause`

```sh
kubectl rollout status deployment/my-app

kubectl rollout history deployment/my-app

kubectl rollout undo deployment/my-app
kubectl rollout undo deployment/my-app --to-revision=1
```
it is also possible to pause and resume a deployment
```sh
kubectl rollout pause deployment/my-app
kubectl rollout resume deployment/my-app
```

### Create temp pods for debugging

```sh
kubectl run -i --tty --rm debug-pgsql --image=postgres:latest --restart=Never --command -- bin/sh
```

### debug command

```sh
# to create a debugging container in an existing pod
kubectl debug -it mypod --image=nicolaka/netshoot

# to create a copy of an existing pod with debugging tools
kubectl debug mypod -it --image=nicolaka/netshoot --copy-to=debug-mypod --share-processes
```

To debug a node
```sh
kubectl debug node/<node-name> -it --image=nicolaka/netshoot
```

### Delete Resources
```sh
kubectl delete pod <pod-name>
kubectl delete deployment <deployment-name>
kubectl delete -f my-manifest.yaml
```
To delete all resources from a folder
```sh
kubectl delete -f ./k8s/
```

### Copy Files
```sh
kubectl cp <pod-name>:<src-path> <destination-path>
```

### Logs and Debugging
```sh
kubectl logs <pod-name>
kubectl logs <pod-name> -c <container-name> # in case of multiple containers in pod
kubectl logs <pod-name> -f   # Follow logs
# If pod had crashed and restarted
kubectl logs <pod-name> --previous
```
To exec into a pod
```sh
kubectl exec -it <pod-name> -- /bin/sh  # Open shell inside pod
```
To specify cluster
```sh
kubectl exec -it <pod-name> --context test-cluster -- /bin/sh
```

### Port Forwarding
```sh
kubectl port-forward <pod-name> 8080:80
```

### Expose a Service
```sh
kubectl expose deployment my-app --type=NodePort --port=80
```

### Scale a Deployment
```sh
kubectl scale deployment my-app --replicas=3
```

## Namespace Operations
```sh
kubectl create namespace my-namespace
kubectl get namespaces
kubectl delete namespace my-namespace
```

### Explain Structure of Resources
```sh
kubectl explain pods
kubectl explain services
```

### Get Cluster Information
```sh
kubectl cluster-info
kubectl get nodes
```

## Get Events
```sh
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get events --field-selector involvedObject.kind=pod,involvedObject.name=mypod
``` 

## Metrics

If metrics is enabled. To get resource usage (CPU/Memory) of pods and nodes
```sh
kubectl top pod
kubectl top node
```