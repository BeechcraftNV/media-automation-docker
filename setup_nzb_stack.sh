#!/bin/bash

# Base directory for the stack
BASE_DIR="/home/steven/docker/stacks/media-automation-docker"

# Set UID and GID to the current user (defaults to UID 1000)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Ensure the base directory exists
if [[ ! -d "$BASE_DIR" ]]; then
  echo "📁 Creating base directory: $BASE_DIR"
  mkdir -p "$BASE_DIR" || { echo "❌ Failed to create $BASE_DIR"; exit 1; }
fi

echo "📁 Setting up directory structure in: $BASE_DIR"
cd "$BASE_DIR" || { echo "❌ Failed to cd into $BASE_DIR"; exit 1; }

# Create required config and data directories
mkdir -p \
  config/{sonarr,radarr,nzbhydra2,nzbget,prowlarr,bazarr,jellyfin} \
  data/{downloads,media/{tv,movies}}

# Fix ownership to the current user
echo "🔐 Fixing ownerships to UID:$USER_ID and GID:$GROUP_ID"
sudo chown -R "$USER_ID:$GROUP_ID" "$BASE_DIR"
chmod -R 775 "$BASE_DIR"

# Check for docker-compose.yml before continuing
if [[ ! -f "docker-compose.yml" ]]; then
  echo "❌ docker-compose.yml not found in $BASE_DIR"
  echo "💡 Clone the stack repo or ensure it's placed correctly."
  exit 1
fi

# Start the stack
echo "🐳 Starting Docker Compose stack"
docker compose up -d || { echo "❌ Docker Compose failed to start"; exit 1; }

echo "✅ All done! Your services should now be available on localhost ports."

