#!/bin/zsh

echo "Starting Minikube..."
minikube start

echo "Creating application images and caching in minikube..."
eval $(minikube docker-env)
docker build -t producer:latest -f ./hello-world/Dockerfile.producer .
docker build -t consumer:latest -f ./hello-world/Dockerfile.consumer .

echo "Checking if images are cached in minikube..."
minikube image ls | grep 'producer\|consumer'

echo "Creating Kafka cluster..."
kubectl create namespace kafka
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
kubectl apply -f https://strimzi.io/examples/latest/kafka/kraft/kafka-single-node.yaml -n kafka 

echo "Waiting for Kafka cluster to be ready..."
kubectl wait kafka/my-cluster --for=condition=Ready --timeout=300s -n kafka 

echo "Creating Kafka topics..."
echo "Deploying hello-world producer and consumer..."
helm install hello-world ./helm

echo "Creating dev and prod environments..."
chmod +x ./create-envs.sh
./create-envs.sh