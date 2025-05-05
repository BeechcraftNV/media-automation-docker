#!/usr/bin/env bash
set -euo pipefail

# 1) Ensure we're in the right place
if [ ! -f docker-compose.yml ]; then
  echo "⛔️ docker-compose.yml not found in $(pwd)"
  exit 1
fi
if [ ! -f .env ]; then
  echo "⛔️ .env not found in $(pwd)"
  exit 1
fi

# 2) Load PUID & PGID from .env
eval $(
  grep -E '^(PUID|PGID)=' .env \
    | sed 's/^/export /'
)
if [ -z "${PUID:-}" ] || [ -z "${PGID:-}" ]; then
  echo "⛔️ PUID or PGID not set in .env"
  exit 1
fi

# 3) Find all host-side bind paths (./foo/bar)
paths=$(grep -E '^\s*-\s*\./' docker-compose.yml \
          | sed -E 's/^[[:space:]]*-\s*\.\/([^:]+):.*$/\1/' \
          | sort -u)

if [ -z "$paths" ]; then
  echo "⚠️ No ./host-path bind mounts found in docker-compose.yml"
  exit 0
fi

echo "🛠️  Creating directories and setting permissions to ${PUID}:${PGID}:"
for p in $paths; do
  echo " • $p"
  mkdir -p "$p"
  chown "${PUID}:${PGID}" "$p"
done

echo "✅ Done! You can now run: docker compose up -d"

