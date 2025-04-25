#!/bin/bash

# Base directory for the stack
BASE_DIR=~/docker-stacks/media-automation-docker

# Set UID and GID to the current user (defaults to UID 1000)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

echo "📁 Setting up directory structure in: $BASE_DIR"
cd "$BASE_DIR" || { echo "❌ Failed to cd into $BASE_DIR"; exit 1; }

# Ensure the required folders exist
mkdir -p config/{sonarr,radarr,prowlarr,nzbget,bazarr,jellyfin}
mkdir -p data/{downloads,media/tv,media/movies,media/books}

echo "🔐 Fixing ownerships to UID:$USER_ID and GID:$GROUP_ID"
sudo chown -R "$USER_ID:$GROUP_ID" "$BASE_DIR"

echo "📥 Restoring configuration from backups..."

# Restore exported configuration files (adjust paths to your actual files)
cp ~/backups/sonarr_config.xml ./config/sonarr/sonarr_config.xml
cp ~/backups/radarr_config.xml ./config/radarr/radarr_config.xml
cp ~/backups/prowlarr_config.json ./config/prowlarr/prowlarr_config.json
cp ~/backups/nzbget.conf ./config/nzbget/nzbget.conf
cp ~/backups/bazarr_config.json ./config/bazarr/bazarr_config.json

echo "🐳 Starting docker compose"
docker compose up -d

echo "✅ All done! Visit your services via localhost ports."

