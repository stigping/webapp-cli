#!/bin/bash

APPS_JSON="/opt/webapps/apps.json"

if [ ! -f "$APPS_JSON" ]; then
  echo "❌ No apps.json found at $APPS_JSON"
  exit 1
fi

COUNT=$(jq length "$APPS_JSON")

if [ "$COUNT" -eq 0 ]; then
  echo "ℹ️  No apps registered yet."
  exit 0
fi

echo "📦 Registered Apps:"
echo "----------------------"

jq -r '
  .[] |
  "🟢 \(.name)\n  Domain:    \(.domain)\n  Frontend:  http://localhost:\(.ports.frontend)\n  Backend:   http://localhost:\(.ports.backend)\n  Mongo:     localhost:\(.ports.mongo)\n  Path:      \(.path)\n  Created:   \(.createdAt)\n"
' "$APPS_JSON"
