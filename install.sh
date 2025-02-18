#!/usr/bin/env bash

# This is an example script that turns your computer into Lokal client (by installing ansible)
# and then it turns it into Lokal server by installing the most basic services (monitoring and wordpress)
set -euo pipefail

if (( EUID != 0 )); then
   echo "This script needs to be run as root, e.g: sudo $0" 1>&2
   exit 100
fi

# install necessary software
apt update
apt install --yes software-properties-common python3-pip

# use pip to install the newest ansible 2.10+
pip install ansible

# install software plugins
ansible-galaxy install -r requirements.yml

# run the installation
ansible-playbook --ask-become-pass -i hosts/local playbook.yml
