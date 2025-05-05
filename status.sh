#!/bin/bash

APPS_JSON="/opt/webapps/apps.json"

if [ ! -f "$APPS_JSON" ]; then
  echo "❌ apps.json not found."
  exit 1
fi

echo "📊 Status of Dockerized Apps:"
jq -r '.[] | "\(.name): \(.ports.frontend) (frontend), \(.ports.backend) (backend), \(.ports.mongo) (mongo)"' "$APPS_JSON" |
while read -r line; do
  NAME=$(echo "$line" | cut -d':' -f1)
  echo "🔍 $line"

  docker ps --filter "name=$NAME" --format "  → {{.Names}} ({{.Status}})"
done
