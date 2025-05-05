#!/bin/bash

echo "🧱 New Next.js App Setup"
read -p "Enter project domain (e.g. hfh.sdev.no): " DOMAIN

# Extract subdomain (for naming containers, db)
NAME=$(echo "$DOMAIN" | cut -d'.' -f1)

# Generate random base port between 3000–3999
BASE_PORT=$((RANDOM % 1000 + 3000))
PORT_FRONTEND=$BASE_PORT
PORT_BACKEND=$((BASE_PORT + 1))
PORT_MONGO=$((BASE_PORT + 2))  # This is NOT used in .env anymore

# Create app directory from template
APP_ROOT="/opt/webapps"
cp -r "$APP_ROOT/next-template-docker" "$APP_ROOT/$DOMAIN"
cd "$APP_ROOT/$DOMAIN" || exit 1

# Generate .env file from example
cp .env.example .env
echo "COMPOSE_PROJECT_NAME=$NAME" > .env
echo "NEXT_PUBLIC_PORT=$PORT_FRONTEND" >> .env
echo "BACKEND_PORT=$PORT_BACKEND" >> .env
echo "MONGO_HOST=mongo_\${COMPOSE_PROJECT_NAME}" >> .env
echo "MONGO_PORT=27017" >> .env     # Always use internal Mongo port
echo "MONGO_DB=${NAME}_db" >> .env

# Start containers
docker compose --env-file .env up -d --build

# Register in apps.json
APPS_JSON_PATH="/opt/webapps/apps.json"
NEW_ENTRY=$(cat <<EOF
{
  "name": "$NAME",
  "domain": "$DOMAIN",
  "ports": {
    "frontend": $PORT_FRONTEND,
    "backend": $PORT_BACKEND,
    "mongo": 27017
  },
  "path": "/opt/webapps/$DOMAIN",
  "createdAt": "$(date -Is)"
}
EOF
)

# Ensure apps.json exists and is an array
if [ ! -f "$APPS_JSON_PATH" ] || ! grep -q '^\[' "$APPS_JSON_PATH"; then
  echo "[]" > "$APPS_JSON_PATH"
fi

# Append new entry safely using jq
tmp=$(mktemp)
jq ". += [$NEW_ENTRY]" "$APPS_JSON_PATH" > "$tmp" && mv "$tmp" "$APPS_JSON_PATH"

echo "✅ App '$DOMAIN' is live:"
echo "   🌐 Frontend: http://localhost:$PORT_FRONTEND"
echo "   ⚙️  Backend: http://localhost:$PORT_BACKEND"
