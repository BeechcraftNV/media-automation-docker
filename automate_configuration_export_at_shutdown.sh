#!/bin/bash

echo "📤 Exporting Sonarr settings..."
curl -X POST "http://localhost:8989/api/system/backup" -d "backup=true" -o ~/backups/sonarr_config.xml

echo "📤 Exporting Radarr settings..."
curl -X POST "http://localhost:7878/api/system/backup" -d "backup=true" -o ~/backups/radarr_config.xml

echo "📤 Exporting Prowlarr settings..."
curl -X POST "http://localhost:9696/api/backup" -d "backup=true" -o ~/backups/prowlarr_config.json

echo "📤 Exporting NZBGet settings..."
docker cp nzbget:/config/nzbget.conf ~/backups/nzbget.conf

echo "📤 Exporting Bazarr settings..."
curl -X POST "http://localhost:6767/api/backup" -d "backup=true" -o ~/backups/bazarr_config.json

echo "✅ All exports completed!"

