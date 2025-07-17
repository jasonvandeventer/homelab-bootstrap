#!/bin/bash
set -e
echo "🐳 Installing Docker & Compose..."
curl -fsSL https://get.docker.com | sh
apt install -y docker-compose-plugin
usermod -aG docker $USER
systemctl enable docker
echo "✅ Docker installed"
