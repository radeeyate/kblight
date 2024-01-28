#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi

if ! command -v ectool &> /dev/null; then
  echo "ectool is not installed or was not found in your PATH"
  echo "Downloading ectool to /usr/local/bin..."
  mkdir -p /usr/local/bin
  curl -L "$ECTOOLURL" -o ectool.zip
  unzip -j ectool.zip _build/src/ectool -d /usr/local/bin
  chmod +x /usr/local/bin/ectool
  rm ectool.zip
  echo "Done!"
  exit 0
fi

echo "Installing kblight to /usr/local/bin"
curl -o /usr/local/bin/kblight "https://raw.githubusercontent.com/radeeyate/kblight/master/kblight"
echo "Done... exiting"
exit 0