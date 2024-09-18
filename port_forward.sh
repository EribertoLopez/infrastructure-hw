#!/bin/bash

# Array of namespaces
namespaces=("default" "dev" "prod")

# Local ports to forward to
local_ports=(8001 8002 8003)

# Function to port-forward services
port_forward() {
    for i in "${!namespaces[@]}"; do
        namespace=${namespaces[$i]}
        local_port=${local_ports[$i]}
        echo "Port-forwarding consumer-service in namespace $namespace to local port $local_port"
        kubectl port-forward service/consumer-service -n "$namespace" "$local_port":80 &
        # Save the PID of the port-forward process
        echo $! >> port_forward_pids.txt
    done
}

# Create or clear the PID file
> port_forward_pids.txt

# Start port-forwarding
port_forward

echo "Port-forwarding started. PIDs saved in port_forward_pids.txt"