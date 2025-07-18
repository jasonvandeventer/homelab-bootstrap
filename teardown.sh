#!/bin/bash
set -e

echo "💥 Homelab Media Stack Teardown"

STACK_DIR="/srv/homelab/media"
COMPOSE_FILE="${STACK_DIR}/docker-compose.yml"

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "❌ ERROR: Cannot find $COMPOSE_FILE"
  exit 1
fi

# Stop and remove containers
echo "🛑 Stopping containers..."
docker compose -f "$COMPOSE_FILE" down

# Clean up dangling networks/volumes
echo "🧹 Cleaning up unused Docker resources..."
docker system prune -f
docker volume prune -f
docker network prune -f

# Show what's still running
echo "✅ Teardown complete. Current containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
