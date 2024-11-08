#!/bin/bash
#
# Script starts a service that prints some message to a log file,
# it copies script to a given path if provided.
#
# Usage:
#   sudo ./install.sh
# or
#   sudo ./install.sh <SCRIPT_PATH>
#
# Uninstall: sudo ./uninstall.sh

chmod +x ./dummy.sh

script_path=${1:-$(pwd)}

# Add / to the end of the path if it was not provided
[[ "${script_path}" != */ ]] && script_path="${script_path}/"

if [ -n "$1" ]; then
  cp ./dummy.sh "$script_path"
fi

echo "$script_path"
sed -i "/ExecStart/c\ExecStart=/bin/bash ${script_path}dummy.sh" dummy.service
cp ./dummy.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable dummy.service
sudo systemctl start dummy.service
