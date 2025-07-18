#!/bin/bash
echo "📋 Media Stack Status"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
