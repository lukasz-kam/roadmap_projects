#!/bin/bash

script_file=$(grep 'ExecStart' /etc/systemd/system/dummy.service | awk '{print $2}')

sudo systemctl stop dummy.service
sudo systemctl disable dummy.service
sudo systemctl daemon-reload

rm /var/log/dummy-service.log
rm /etc/systemd/system/dummy.service

if [[ ! $script_file == $(pwd)/dummy.sh ]]; then
  rm "$script_file"
fi
