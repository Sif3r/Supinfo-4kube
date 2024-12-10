#!/usr/bin/env bash

sudo apt update
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y containerd.io

# Configure containerd (using the default configuration file)
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1

# Enable systemd Cgroup driver (recommended for Docker)
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd
sudo apt install -y docker-ce docker-ce-cli docker-compose
