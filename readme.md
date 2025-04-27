# Media-Automation-Docker Stack

> A self-hosted automation suite (NZBHydra2 + NZBGet + *Arr suite + Jellyfin) running under Docker Compose on Ubuntu 25.04.

---

## ✨ What’s inside?

| Service     | Image                                   | Purpose                                   | Port (host) |
|-------------|-----------------------------------------|-------------------------------------------|-------------|
| NZBHydra2   | `ghcr.io/linuxserver/nzbhydra2`         | Meta-search index for Usenet              | `${NZBHYDRA2_PORT}` |
| NZBGet      | `ghcr.io/linuxserver/nzbget`            | Usenet downloader                         | `${NZBGET_PORT}` |
| Prowlarr    | `ghcr.io/linuxserver/prowlarr`          | Indexer manager for *Arr apps             | `${PROWLARR_PORT}` |
| Sonarr      | `ghcr.io/linuxserver/sonarr`            | TV series automation                      | `${SONARR_PORT}` |
| Radarr      | `ghcr.io/linuxserver/radarr`            | Movie automation                          | `${RADARR_PORT}` |
| Readarr     | `lscr.io/linuxserver/readarr:develop`   | E-book / Audiobook automation             | `${READARR_PORT}` |
| Bazarr      | `ghcr.io/linuxserver/bazarr`            | Subtitle searcher                         | `${BAZARR_PORT}` |
| Jellyfin    | `jellyfin/jellyfin`                     | Media server / player                     | `${JELLYFIN_PORT}` |

---

## 🗂️ Folder layout

media-automation-docker/ ├── docker-compose.yml ├── .env ├── data/ │ ├── config/ # All app configs live here │ │ ├── radarr/ │ │ ├── sonarr/ │ │ └── …
│ ├── downloads/ # NZBGet intermediate & completed files │ └── media/ # Final libraries scanned by Jellyfin/*Arr │ ├── tv/ │ ├── movies/ │ └── books/ └── README.md


> **Back up** `./data/` and you have everything—configs, libraries, and activity logs.

---

## 🚀 Quick start

```bash
# 1. Clone / copy this repo
git clone <your-repo-url>
cd media-automation-docker

# 2. Adjust .env (ports, paths, timezone)
nano .env

# 3. Fire it up
docker compose up -d

# 4. Browse to services (e.g. http://localhost:8989 for Sonarr)

TZ=America/Los_Angeles
DATA_ROOT=./data             # base persistent volume

# Service ports
NZBHYDRA2_PORT=5076
NZBGET_PORT=6789
PROWLARR_PORT=9696
SONARR_PORT=8989
RADARR_PORT=7878
READARR_PORT=8787
JELLYFIN_PORT=8096
BAZARR_PORT=6767
