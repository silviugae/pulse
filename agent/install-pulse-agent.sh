#!/usr/bin/env bash

# usage:
# curl -sLH 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/Manta-Network/pulse/main/agent/install-pulse-agent.sh | bash

if ! getent group pulse > /dev/null 2>&1; then
  sudo groupadd --system pulse
  echo "groupadd pulse, result: $?"
fi
if ! getent passwd pulse > /dev/null 2>&1; then
  sudo useradd \
    --system \
    --gid pulse \
    --groups wheel \
    --no-create-home \
    --shell /sbin/nologin \
    --comment 'pulse agent service account' \
    pulse
  echo "useradd pulse, result: $?"
fi

sudo curl \
  -sLo /etc/systemd/system/pulse-agent.service
  https://raw.githubusercontent.com/Manta-Network/pulse/main/agent/pulse-agent.service

sudo systemctl enable pulse-agent.service
sudo systemctl start pulse-agent.service
