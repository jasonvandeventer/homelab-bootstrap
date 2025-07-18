#!/bin/bash
set -e

STACK_DIR="/srv/homelab/media"
COMPOSE_FILE="${STACK_DIR}/docker-compose.yml"

echo "♻️  RESETTING MEDIA STACK..."

# 1. Teardown existing stack
if [ -f ./teardown.sh ]; then
  ./teardown.sh
else
  echo "⚠️  No teardown.sh found, skipping teardown step"
fi

# 2. Deploy fresh containers
echo "🚀 Deploying fresh containers..."
docker compose -f "$COMPOSE_FILE" up -d

# 3. Check status after restart
echo "🔍 Verifying container health..."
if [ -f ./scripts/status-check.sh ]; then
  ./scripts/status-check.sh
else
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
fi

echo "✅ Reset complete!"
