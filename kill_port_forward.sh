#!/bin/bash

# Function to kill port-forward processes
kill_port_forward() {
    if [ -f port_forward_pids.txt ]; then
        while IFS= read -r pid; do
            echo "Killing port-forward process with PID $pid"
            kill "$pid"
        done < port_forward_pids.txt
        # Remove the PID file after killing the processes
        rm port_forward_pids.txt
        echo "All port-forward processes killed."
    else
        echo "No port-forward processes found."
    fi
}

# Kill port-forward processes
kill_port_forward