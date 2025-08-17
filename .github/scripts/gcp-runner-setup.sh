#!/bin/bash

# Minimal dependency installation
sudo apt-get update && sudo apt-get install -y \
    docker.io \
    kubectl \
    google-cloud-sdk \
    unzip

# Install GitHub Actions Runner (minimal version)
RUNNER_VER="2.308.0"  # Lightweight stable version
mkdir -p actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-${RUNNER_VER}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VER}/actions-runner-linux-x64-${RUNNER_VER}.tar.gz
tar xzf actions-runner-linux-x64-${RUNNER_VER}.tar.gz

# Configure runner (unattended)
./config.sh --unattended --url https://github.com/KarishuNoorulla/task9 --token ${RUNNER_TOKEN} --name gcp-runner --replace

# Install as service
sudo ./svc.sh install
sudo ./svc.sh start