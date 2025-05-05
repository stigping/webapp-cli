#!/bin/bash

echo "🗑  Uninstall Project"

read -p "Enter project name to remove (e.g. test-project): " NAME

APP_PATH="/opt/webapps/$NAME"
APPS_JSON="/opt/webapps/apps.json"
ENV_FILE="$APP_PATH/.env"

if [ ! -d "$APP_PATH" ]; then
  echo "❌ Directory $APP_PATH does not exist."
  exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ .env file not found in $APP_PATH. Cannot proceed."
  exit 1
fi

echo "🛑 Stopping containers for $NAME..."
cd "$APP_PATH" || exit 1
docker compose --env-file .env down

echo "🧹 Removing project directory..."
rm -rf "$APP_PATH"

if [ -f "$APPS_JSON" ]; then
  echo "🧽 Updating apps.json..."
  jq "del(.[].name | select(. == \"$NAME\"))" "$APPS_JSON" > "$APPS_JSON.tmp" && mv "$APPS_JSON.tmp" "$APPS_JSON"
fi

echo "✅ Project '$NAME' has been removed."
