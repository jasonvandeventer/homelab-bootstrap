#!/bin/bash
set -e
echo "📦 Updating system packages..."
apt update && apt upgrade -y
echo "✅ System updated"
