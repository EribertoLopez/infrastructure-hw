#!/bin/bash

kubectl create namespace dev
kubectl create namespace prod
helm install hello-world-dev ./helm --values ./helm/values.yaml -f ./helm/values-dev.yaml --namespace dev
helm install hello-world-prod ./helm --values ./helm/values.yaml -f ./helm/values-prod.yaml --namespace prod

