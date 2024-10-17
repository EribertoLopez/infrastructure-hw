#!/bin/bash

# Function to install Minikube
install_minikube() {
    echo "Installing Minikube..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo install minikube /usr/local/bin/
        rm minikube
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install minikube
    elif [[ "$OSTYPE" == "msys" ]]; then
        choco install minikube
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

# Function to install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        rm kubectl
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install kubectl
    elif [[ "$OSTYPE" == "msys" ]]; then
        choco install kubernetes-cli
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

# Function to install Helm
install_helm() {
    echo "Installing Helm..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        chmod 700 get_helm.sh
        ./get_helm.sh
        rm get_helm.sh
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install helm
    elif [[ "$OSTYPE" == "msys" ]]; then
        choco install kubernetes-helm
    else
        echo "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

# Main script
echo "Starting installation of Minikube, kubectl, and Helm..."

install_minikube
install_kubectl
install_helm

echo "Installation completed successfully."