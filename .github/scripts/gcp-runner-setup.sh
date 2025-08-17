#!/bin/bash

# Install dependencies
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    docker.io \
    jq \
    unzip

# Install gcloud CLI
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl

# Install Terraform
TERRAFORM_VER="1.5.7"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip
sudo unzip terraform_${TERRAFORM_VER}_linux_amd64.zip -d /usr/local/bin/

# Configure Docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install GitHub Runner
RUNNER_VER="2.309.0"
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-${RUNNER_VER}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VER}/actions-runner-linux-x64-${RUNNER_VER}.tar.gz
tar xzf ./actions-runner-linux-x64-${RUNNER_VER}.tar.gz

# Configure runner
./config.sh --url https://github.com/<YOUR_ORG>/<YOUR_REPO> --token <RUNNER_TOKEN> --name gcp-vm-runner --unattended

# Install service
sudo ./svc.sh install
sudo ./svc.sh start
