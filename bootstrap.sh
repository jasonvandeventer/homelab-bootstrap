#!/bin/bash
set -e

echo "🚀 Homelab Bootstrap v0.1"
echo "Phase 1: Base Setup"

./scripts/01-system-update.sh
./scripts/02-docker-install.sh
./scripts/03-storage-setup.sh

echo "✅ Phase 1 base setup complete!"
