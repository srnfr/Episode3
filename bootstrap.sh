#!/bin/bash


for ns in blue green red; do
	echo "Deploiement dans NS $ns.."
	kubectl create ns ${ns}
	kubectl apply -f webdemo.yml -n ${ns}
done

## ARGO-CD

helm repo add argo https://argoproj.github.io/argo-helm

helm install -f helm-argocd-values.yaml myargo argo/argo-cd --create-namespace --namespace=argocd


 kubectl port-forward service/myargo-argocd-server -n argocd 8080:443
