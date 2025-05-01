#!/bin/bash

LOG_FILE="$HOME/update_server.log"
REPO_DIR="/home/hamisi/Documents/projects/hamisi-api"
GIT_REPO_URL="https://github.com/hamisishehe/cs421-assignment.git"
WEB_SERVICE="nginx"

{
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🔄 Starting server update..."

  apt update && apt upgrade -y

  cd "$REPO_DIR" || {
    echo "ERROR: Failed to access $REPO_DIR"
    exit 1
  }

  if git pull origin main; then
    echo "Git pull successful"
    systemctl restart "$WEB_SERVICE"
    echo "Web server restarted"
  else
    echo "Git pull failed! Update aborted."
    exit 1
  fi

} >> "$LOG_FILE"
