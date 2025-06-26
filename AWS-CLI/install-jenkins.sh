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
