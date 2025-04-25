# NZB Media Server Stack

This project sets up a complete, automated Usenet media server stack using Docker Compose on Linux.

---

## 📦 Stack Overview

| Service     | Role                         | Port   | Notes                             |
|-------------|------------------------------|--------|-----------------------------------|
| Jellyfin    | Media server                 | 8096   | Scans `/data/media/` for content  |
| Sonarr      | TV show automation           | 8989   | Pulls from indexers → NZBGet      |
| Radarr      | Movie automation             | 7878   | Pulls from indexers → NZBGet      |
| NZBGet      | Usenet downloader            | 6789   | Handles .nzb files from indexers  |
| NZBHydra2   | Usenet meta-search engine    | 5076   | Unified indexer search frontend   |
| Prowlarr    | Indexer management for apps | 9696   | Connects indexers to Sonarr/Radarr |
| Bazarr      | Subtitle downloader          | 6767   | Optional (syncs with Sonarr/Radarr) |

---

## 📁 Folder Structure

NzbHydra2/ ├── docker-compose.yml ├── .env ├── config/ # Persistent config for each service │ ├── sonarr/ │ ├── radarr/ │ ├── prowlarr/ │ ├── nzbget/ │ ├── jellyfin/ │ └── ... ├── data/ │ ├── downloads/ # Handled by NZBGet │ │ ├── tv/ │ │ └── movies/ │ └── media/ # Final organized media │ ├── tv/ │ └── movies/


---

## 🔧 Setup & Usage

### 🚀 Start the stack

```bash

start the stack
docker compose up -d

stop the stack
docker compose down

Rebuild (e.g. after image updates)
docker compose pull
docker compose up -d

Permissions
sudo chown -R 1000:1000 config data

Note for future steve
tar -czvf nzbstack_backup_$(date +%F).tar.gz docker-compose.yml .env config data
