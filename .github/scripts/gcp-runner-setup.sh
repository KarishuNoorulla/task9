#!/bin/bash

# Install dependencies
sudo apt-get update && sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    docker.io \
    jq \
    unzip \
    git

# Install gcloud CLI
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl

# Install GitHub Runner
mkdir -p actions-runner && cd actions-runner
RUNNER_VERSION="2.328.0"
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Configure runner
./config.sh --url https://github.com/KarishuNoorulla/task9 --token ${RUNNER_TOKEN} --name gcp-runner --unattended --work _work

# Install and start service
sudo ./svc.sh install
sudo ./svc.sh start