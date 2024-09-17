#!/bin/zsh

minikube start

eval $(minikube docker-env)
docker build -t producer:latest -f ./hello-world/Dockerfile.producer .
docker build -t consumer:latest -f ./hello-world/Dockerfile.consumer .

minikube image ls | grep 'producer\|consumer'

kubectl create namespace kafka
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
kubectl apply -f https://strimzi.io/examples/latest/kafka/kraft/kafka-single-node.yaml -n kafka 
kubectl wait kafka/my-cluster --for=condition=Ready --timeout=300s -n kafka 

helm install hello-world ./helm