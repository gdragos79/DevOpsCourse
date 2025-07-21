#!/bin/bash

set -e

echo "Please insert the URL of the repository:"
read REPO_URL
REPO_DIR=$(echo "$REPO_URL" | cut -d '/' -f5)
REPO_DIR=${REPO_DIR%.git} # Remove .git if present

echo -e "The URL inserted is: $REPO_URL.\nThe repo's directory is: $REPO_DIR.\nDo you want to continue with this data? (y/n)"
read USER_INPUT
USER_INPUT_LOWER=$(echo "$USER_INPUT" | tr '[:upper:]' '[:lower:]')

if [[ "$USER_INPUT_LOWER" == "y" || "$USER_INPUT_LOWER" == "yes" ]]; then
  echo "Cloning the repository..."
  git clone "$REPO_URL"
  cd "$REPO_DIR" 
  chmod +x ./Install_tools.bash
  ./Install_tools.bash
else
  echo "Exiting..."
  exit 1
fi