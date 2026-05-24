#!/bin/sh

# Write config — fsb.env is the exact filename the binary looks for
cat <<ENVEOF > /app/fsb.env
API_ID=${API_ID}
API_HASH=${API_HASH}
BOT_TOKEN=${BOT_TOKEN}
MULTI_TOKEN1=${MULTI_TOKEN1}
MULTI_TOKEN2=${MULTI_TOKEN2}
MULTI_TOKEN3=${MULTI_TOKEN3}
LOG_CHANNEL=${LOG_CHANNEL}
HOST=${HOST}
PORT=${PORT:-8080}
ENVEOF

# Start Cloudflare tunnel in background
cloudflared tunnel --no-autoupdate run --token "${TUNNEL_TOKEN}" &

sleep 2

# Launch bot in foreground
# Render has a generous startup grace period so no nc placeholder needed
exec tg-filestreambot run
