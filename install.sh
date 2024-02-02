#!/bin/bash

ECTOOLURL="https://gitlab.howett.net/DHowett/ectool/-/jobs/890/artifacts/download?file_type=archive"

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
curl -o /usr/local/bin/kblightd.sh "https://raw.githubusercontent.com/radeeyate/kblight/master/daemon.sh"
chown "$(logname)":"$(logname)" /usr/local/bin/kblight
chmod +x /usr/local/bin/kblight
chmod +x /usr/local/bin/kblightd.sh


echo "[Unit]
Description=Keyboard backlight daemon
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/kblightd.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/kblightd.service

systemctl daemon-reload
systemctl enable kblightd
systemctl start kblightd

echo "You can now use kblight. See all options with \"sudo kblight help\""
exit 0