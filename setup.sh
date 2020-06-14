#!/bin/bash

echo "##################enabling minikube docker env"
eval $(minikube docker-env)

echo "##################building node js app"
cd nodejsapp
docker build -t node-web-app:1.0.0 .

echo "##################creating kube secrets"
cd ..
echo -n "mypwd" > mysql-password
echo -n "mysupersecret" > mysql-root-password
kubectl create secret generic db-passwords --from-file=./mysql-root-password --from-file=./mysql-password
rm mysql-password mysql-root-password

echo "##################installing db manifest"
helm install -f env/prod/db.yaml db stable/mysql

echo "##################installing node app manifest"
helm install -f env/prod/app.yaml myappchart ./appchart

helm list

kubectl get pods
kubectl get service

echo "When pods are available, run: curl $(minikube service node-js-app --url)"