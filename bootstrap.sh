#!/bin/bash


for ns in blue green red; do
	echo "Deploiement dans NS $ns.."
	kubectl create ns ${ns}
	kubectl apply -f webdemo.yml -n ${ns}
done

## ARGO-CD

helm repo add argo https://argoproj.github.io/argo-helm

helm install myargo argo/argo-cd -f helm-argocd-values.yaml --create-namespace --namespace=argocd

kubectl wait --for=condition=Ready pod/myargo-argocd-server -n argocd

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

kubectl wait --for=condition=Ready pod/$DEBUGPODNAME -n $NSDEBUG
kubectl port-forward service/myargo-argocd-server -n argocd 8080:443
