#!/usr/bin/bash

set -eoux pipefail

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-cisco-openh264.repo

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-lazygit-fedora-41.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-fedora-41.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-ubuntu-fonts-fedora-41.repo
