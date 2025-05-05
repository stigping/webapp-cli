#!/bin/bash

echo "♻️  Rebuild Project"

read -p "Enter project name (e.g. test-project): " NAME
APP_PATH="/opt/webapps/$NAME"
ENV_FILE="$APP_PATH/.env"

if [ ! -d "$APP_PATH" ] || [ ! -f "$ENV_FILE" ]; then
  echo "❌ Project '$NAME' or its .env file not found."
  exit 1
fi

cd "$APP_PATH" || exit 1

echo "🛑 Stopping existing containers..."
docker compose --env-file .env down

echo "🔨 Rebuilding and restarting containers..."
docker compose --env-file .env up -d --build

echo "✅ $NAME rebuilt."
