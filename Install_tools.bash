#!/bin/bash

set -e

# Update system
sudo apt-get update -y

# ---------------- Docker ----------------
if command -v docker &> /dev/null; then
    echo "Docker is already installed: $(docker --version)"
    read -p "Do you want to reinstall Docker? (y/n): "docker_choice"
	user_input_lower=$(echo "$docker_choice" | tr '[:upper:]' '[:lower:]')
    if [[ "$user_input" == "y" || "$user_input" == "yes" ]]; then
      	echo "Installing Docker..."
        sudo apt-get remove docker docker-engine docker.io containerd runc -y
        sudo apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update -y
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        echo "Docker installed: $(docker --version)"
    else
        echo "Skipping Docker."
    fi
else
    echo "Docker is not installed."
    read -p "Do you want to install Docker? (y/n): "docker_choice"
    user_input_lower=$(echo "$docker_choice" | tr '[:upper:]' '[:lower:]')
    if [[ "$user_input" == "y" || "$user_input" == "yes" ]]; then
      	echo "Installing Docker..."
        sudo apt-get remove docker docker-engine docker.io containerd runc -y
        sudo apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update -y
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        echo "Docker installed: $(docker --version)"
    else
        echo "Skipping Docker."
    fi
fi

# ---------------- Podman ----------------
if command -v podman &> /dev/null; then
    echo "Podman is already installed: $(podman --version)"
    read -p "Do you want to reinstall Podman? (y/n): "podman_choice"
	user_input=$(echo "$podman_choice" | tr '[:upper:]' '[:lower:]')
    if [[ "$user_input" == "y" || "$user_input" == "yes" ]]; then
        echo "Installing Podman..."
        sudo apt-get install -y podman
        echo "Podman installed: $(podman --version)"
    else
        echo "Skipping Podman."
    fi
else
    echo "Podman is not installed."
    read -p "Do you want to install Podman? (y/n): "podman_choice"
    user_input=$(echo "$podman_choice" | tr '[:upper:]' '[:lower:]')
    if [[ "$user_input" == "y" || "$user_input" == "yes" ]]; then
        echo "Installing Podman..."
        sudo apt-get install -y podman
        echo "Podman installed: $(podman --version)"
    else
        echo "Skipping Podman."
    fi
fi

# ---------------- Kubernetes ----------------
if command -v kubectl &> /dev/null; then
    echo "Kubernetes is already installed: $(kubectl version --client --short)"
    read -p "Do you want to reinstall Kubernetes? (y/n): "kubectl_choice"
	user_input=$(echo "$kubectl_choice" | tr '[:upper:]' '[:lower:]')
    if [[ "$user_input" == "y" || "$user_input" == "yes" ]]; then
        echo "Installing Kubernetes..."
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        echo "Kubernetes is installed: $(kubectl version --client --short)"
    else
		echo "Skipping Kubernetes."
    fi
else
    echo "Kubernetes is not installed."
    read -p "Do you want to install Kubernetes? (y/n): " kubectl_choice
	user_input=$(echo "$kubectl_choice" | tr '[:upper:]' '[:lower:]')
    if [[ "$user_input" == "y" || "$user_input" == "yes" ]]; then
        echo "Installing Kubernetes..."
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        echo "Kubernetes is installed: $(kubectl version --client --short)"
    else
        echo "Skipping Kubernetes."
    fi
fi

echo "All selected tools have been installed."