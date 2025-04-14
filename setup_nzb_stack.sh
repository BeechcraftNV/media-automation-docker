#!/bin/bash

# Base directory for the stack
BASE_DIR=~/docker-projects/NzbHydra2

# Set UID and GID to the current user (defaults to UID 1000)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

echo "📁 Setting up directory structure in: $BASE_DIR"
cd "$BASE_DIR" || { echo "❌ Failed to cd into $BASE_DIR"; exit 1; }

# Ensure the required folders exist
mkdir -p config/{sonarr,radarr,nzbhydra2,nzbget,prowlarr,bazarr,jellyfin}
mkdir -p data/downloads
mkdir -p data/media/{tv,movies}

echo "🔐 Fixing ownerships to UID:$USER_ID and GID:$GROUP_ID"
sudo chown -R "$USER_ID:$GROUP_ID" "$BASE_DIR"

echo "🐳 Starting docker compose"
docker compose up -d

echo "✅ All done! Visit your services via localhost ports."
