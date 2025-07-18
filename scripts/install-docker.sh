#!/bin/bash
set -e

echo "📦 Updating system packages..."
apt update && apt upgrade -y

echo "🐳 Installing Docker..."
curl -fsSL https://get.docker.com | sh

echo "🔧 Installing Docker Compose plugin..."
apt install -y docker-compose-plugin

echo "✅ Enabling and starting Docker..."
systemctl enable docker
systemctl start docker

echo "👤 Adding user to docker group..."
usermod -aG docker $USER

echo "✅ Docker installation complete!"
docker --version
docker compose version
