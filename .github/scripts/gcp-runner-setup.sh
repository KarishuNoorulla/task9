#!/bin/bash

# Install dependencies
sudo apt-get update && sudo apt-get install -y \
    docker.io \
    jq \
    unzip \
    git

# Install gcloud CLI
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl

# Install GitHub Actions Runner
mkdir -p actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.328.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz
tar xzf actions-runner-linux-x64-2.328.0.tar.gz

# Configure runner
./config.sh --url https://github.com/KarishuNoorulla/task9 --token ${RUNNER_TOKEN} --name gcp-runner --unattended

# Install service
sudo ./svc.sh install
sudo ./svc.sh start