#!/bin/bash

eval $(minikube docker-env)
docker build -t producer:latest -f ./hello-world/Dockerfile.producer .
docker build -t consumer:latest -f ./hello-world/Dockerfile.consumer .