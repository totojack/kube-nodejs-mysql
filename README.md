# kube-nodejs-mysql

## INSTRUCTIONS

1 - git clone
2 - run: bash setup.sh
3 - when pods are in status Running, run 'curl $(minikube service node-js-app --url)' to get the response
4 - if you want to see the response inside your web browser, run 'minikube service node-js-app --url' to get the url