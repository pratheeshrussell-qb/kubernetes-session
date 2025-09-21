# Basic Kubernetes Cluster Setup For Local Dev

## Pre Requisites
- docker
- kubectl
- kind

## Build the images
```sh
cd app-code
./build-img.sh
```
## Create Kind Cluster

```sh
cd k8s
kind create cluster --config kind/config.yaml
```

## Load images

```sh
kind load docker-image quote-backend --name kube-lab-cluster

# optionally pull these images locally first or else it will pull these from dockerhub
kind load docker-image nginx:alpine dpage/pgadmin4 postgres:15 --name kube-lab-cluster
```

## Add Argocd
[Refer argocd.md](argo-cd/README.md)


## Deploy the apps
use argo cd to deploy the apps from the argocd UI or run the below command


## Cleanup 

```sh
cd k8s/overlays/local
kubectl delete -k . 

kind delete cluster --name kube-lab-cluster
```

## Access the apps
- Frontend: http://localhost:5025/frontend
- Backend: http://localhost:5025/backend/api/quotes/random
- PgAdmin: http://localhost:5025/pgadmin

