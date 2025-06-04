
# 🌐 Terraform Infrastructure for `server-cloud-Module`

## 📌 Overview

This directory contains Terraform code that automates the provisioning of AWS infrastructure for the `server-cloud-Module` backend application. It sets up networking, compute, IAM, and automation tooling via EC2 user data to bootstrap the instance with Ansible.

---

## 🗂️ Directory Structure

```
terraform/
├── main.tf             # Core infrastructure resources (VPC, EC2, SG, etc.)
├── variables.tf        # Input variable definitions
├── outputs.tf          # Exported resource information
├── provider.tf         # AWS provider settings
├── terraform.tfvars    # Custom values for variables
├── user-data.sh        # Bootstrap script to run on EC2 startup
└── README.md           # This documentation
```

---

## 🚀 Usage Instructions

### ⚙️ Prerequisites

* [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
* AWS credentials configured via `aws configure`
* Existing EC2 key pair
* IAM user or role with permissions to manage EC2, VPC, SSM, and IAM

---

### 📦 Deploy Infrastructure

1. **Initialize Terraform**

   ```bash
   terraform init
   ```

2. **Preview the Plan**

   ```bash
   terraform plan
   ```

3. **Apply the Configuration**

   ```bash
   terraform apply
   ```

4. **Destroy the Infrastructure**

   ```bash
   terraform destroy
   ```

---

## 🔐 user-data.sh – EC2 Bootstrap Script

This script is injected into the EC2 instance at launch via Terraform and runs automatically to prepare the server. Here's what it does:

```bash
#!/bin/bash

# Update packages and install system dependencies
yum update -y
yum install -y python3 git unzip

# Install pip and Ansible
python3 -m ensurepip --upgrade
pip3 install --upgrade pip
pip3 install ansible boto3 botocore

# Install AWS CLI 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install

# Clone your Ansible repo
git clone https://github.com/Abubakar-Meigag/server-cloud-Module.git /opt/ansible
cd /opt/ansible/ansible-server-migration

# Run the playbook against localhost
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i "localhost," -c local site.yml
```

### 🔍 Explanation of Key Steps

* **System setup**:

  * Updates packages
  * Installs Python, pip, and system tools (`git`, `unzip`)

* **Provisioning tooling**:

  * Installs Ansible (for configuration management)
  * Installs `boto3` and `botocore` (for AWS automation via Ansible)
  * Installs AWS CLI v2

* **App deployment**:

  * Clones your repository
  * Runs an Ansible playbook (`site.yml`) locally on the instance
  * The playbook likely installs your backend application and sets up the Docker container with necessary environment variables

> This makes your EC2 instance **self-configuring** on first boot — no manual setup needed.

---

## 📝 Input Variables

Defined in `variables.tf`, values assigned via `terraform.tfvars`:

| Variable               | Description                          |
| ---------------------- | ------------------------------------ |
| `region`               | AWS region to deploy to              |
| `vpc_cidr`             | CIDR block for the VPC               |
| `public_subnet_cidrs`  | List of CIDRs for public subnets     |
| `private_subnet_cidrs` | List of CIDRs for private subnets    |
| `instance_type`        | EC2 instance type (e.g., `t2.micro`) |
| `key_name`             | Name of SSH key pair                 |

---

## 📤 Outputs

After deployment, Terraform will return:

* `ec2_instance_id`
* `ec2_public_ip`
* `vpc_id`
* `subnet_ids`
* `security_group_id`

---

## 🔐 Security Notes

* **No secrets are hardcoded**; all sensitive data is expected to be managed securely (e.g., via SSM or inside the Ansible playbook).
* **Least privilege**: IAM roles should be scoped narrowly to what’s needed for provisioning and Ansible operations.
* **Port exposure**: Only required ports (e.g., SSH, app port) should be open via the security group.

