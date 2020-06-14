#!/bin/bash

echo "deleting db chart"
helm delete db
echo "deleting app chart"
helm delete myappchart
echo "deleting kube secrets"
kubectl delete secret db-passwords
echo "deleting docker image"
eval $(minikube docker-env)
docker rmi node-web-app:1.0.0 

echo "helm charts"
helm list

echo "kube pods"
kubectl get pods