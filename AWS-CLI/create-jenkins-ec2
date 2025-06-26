Great! Here's a step-by-step guide to **create an EC2 instance via AWS CLI** with:

* Ubuntu 24.04
* Instance type: `t2.medium` / `t3.medium` / `t2.large`
* 25 GB volume
* Security group allowing all traffic
* SSH access
* Fully documented and copy-paste ready ⚡

---

## 🚀 Step-by-Step: Create EC2 Instance via AWS CLI

---

### ✅ 1. Prerequisites

```bash
aws configure
```

Enter:

* Access Key
* Secret Key
* Region (e.g., `ap-south-1`)
* Output format: `json`

---

### 🔍 2. Find Ubuntu 24.04 AMI ID

For example (Mumbai region):

```bash
aws ec2 describe-images \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*" \
            "Name=architecture,Values=x86_64" \
            "Name=root-device-type,Values=ebs" \
            "Name=virtualization-type,Values=hvm" \
            "Name=owner-alias,Values=amazon" \
  --query 'Images[*].[ImageId,Name]' --output table --region ap-south-1
```

Pick the latest one (e.g., `ami-0123456789abcdef0`).

---

### 🛡️ 3. Create Security Group (Allow ALL Traffic)

```bash
aws ec2 create-security-group \
  --group-name allow-all-traffic \
  --description "Allow all traffic" \
  --vpc-id $(aws ec2 describe-vpcs --query 'Vpcs[0].VpcId' --output text)
```

Then allow all traffic:

```bash
aws ec2 authorize-security-group-ingress \
  --group-name allow-all-traffic \
  --protocol all \
  --port all \
  --cidr 0.0.0.0/0
```

---

### 🔐 4. Create Key Pair (for SSH)

```bash
aws ec2 create-key-pair --key-name my-key \
  --query 'KeyMaterial' --output text > my-key.pem
chmod 400 my-key.pem
```

---

### 🖥️ 5. Launch EC2 Instance

Replace:

* `ami-xxxxxx` → with actual Ubuntu 24.04 AMI ID
* `t2.medium` → or `t2.large`, `t3.medium`

```bash
aws ec2 run-instances \
  --image-id ami-0f918f7e67a3323f0 \
  --instance-type t2.medium \
  --key-name MINI \
  --security-groups "ALL TRAFFIC" \
  --block-device-mappings '[{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":25}}]' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=jenkins-server}]' \
  --count 1
```

---

### 🌐 6. Get Public IP

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=jenkins-server" \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output text
```

---

### 🔧 7. SSH Into the Instance

```bash
ssh -i my-key.pem ubuntu@<PUBLIC-IP>
```

---

### 🔄 8. Post-Launch Setup (Docker + Java + Jenkins)

Run the following after connecting via SSH:

```bash
# Docker
sudo apt update && sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu
newgrp docker

# Java 17
sudo apt install -y openjdk-17-jdk

# Jenkins

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins
```

Then visit:

```
http://<EC2-PUBLIC-IP>:8080
```
* `ALLOW 8080 ` → Make sure allow inbound rules.

---

To terminate an EC2 instance via AWS CLI, follow these steps carefully:

---

## 🔥 Terminate EC2 Instance (AWS CLI)

### ✅ Step 1: Get the Instance ID

If you don’t know it yet:

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=jenkins-server" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text
```

📌 Output (example):

```
i-0123456789abcdef0
```

---

### 🧨 Step 2: Terminate the Instance

Replace with your actual Instance ID:

```bash
aws ec2 terminate-instances --instance-ids i-0123456789abcdef0
```

📌 Output:

```json
{
  "TerminatingInstances": [
    {
      "InstanceId": "i-0123456789abcdef0",
      "CurrentState": {
        "Code": 32,
        "Name": "shutting-down"
      },
      "PreviousState": {
        "Code": 16,
        "Name": "running"
      }
    }
  ]
}
```

---

### 🔍 Optional: Verify Termination

```bash
aws ec2 describe-instances --instance-ids i-0123456789abcdef0 \
  --query "Reservations[*].Instances[*].State.Name" \
  --output text
```

You’ll see:

```
shutting-down → terminated
```

---

Let me know if you want to:

* Delete associated security group or key pair too
* Automate EC2 create → configure → terminate in one script


#If Your are using bash script to install docker and jenkins

<!-- Setup-jenkins.sh  -->


#!/bin/bash

set -e

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

echo "👥 Adding 'ubuntu' and 'jenkins' to docker group..."
sudo usermod -aG docker ubuntu
# 'jenkins' user is created by Jenkins package during installation

echo "☕ Installing Java 17..."
sudo apt install -y openjdk-17-jdk
java -version

echo "🔧 Installing Jenkins..."

# Add Jenkins GPG key and repo
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt update
sudo apt install -y jenkins

# Now that Jenkins user exists, add to docker group
sudo usermod -aG docker jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "✅ Setup complete!"
echo "🌐 Visit Jenkins at: http://<your-ec2-ip>:8080"
echo "🔑 Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

<!-- To Run the script -->

chmod +x setup-jenkins.sh
./setup-jenkins.sh

<!-- After Script -->

newgrp docker

