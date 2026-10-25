#!/usr/bin/env bash
set -e

echo "=== openGym VPS Deployment Script ==="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    systemctl enable --now docker
fi

# Ensure docker compose is available
if ! docker compose version &> /dev/null; then
    echo "Installing Docker Compose plugin..."
    apt-get update && apt-get install -y docker-compose-plugin
fi

# Prepare .env if missing
if [ ! -f .env ]; then
    if [ -f .env.production.example ]; then
        cp .env.production.example .env
        echo "Created .env from .env.production.example."
        echo "Please edit .env with your domain name before continuing:"
        echo "nano .env"
        exit 1
    fi
fi

echo "Pulling latest images..."
docker compose -f docker-compose.prod.yml pull

echo "Starting openGym production stack..."
docker compose -f docker-compose.prod.yml up -d

echo ""
echo "=== Deployment Complete ==="
echo "Status:"
docker compose -f docker-compose.prod.yml ps
