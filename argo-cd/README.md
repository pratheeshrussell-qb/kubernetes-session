# Argo CD

Install Argo CD
```
kubectl create namespace argocd


kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```