#!/bin/bash

# Update packages and install system dependencies
yum update -y
yum install -y python3 git unzip

# Install pip and Ansible
python3 -m ensurepip --upgrade
pip3 install --upgrade pip
pip3 install ansible boto3 botocore

# Install AWS CLI v2 (if not already available)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install

# Clone your Ansible repo (replace with your actual repo URL)
git clone https://github.com/Abubakar-Meigag/server-cloud-Module.git /opt/ansible
cd /opt/ansible/ansible-server-migration

# Run the playbook against localhost
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i "localhost," -c local site.yml
