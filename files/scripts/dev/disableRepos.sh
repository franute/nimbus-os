#!/usr/bin/bash

set -eoux pipefail

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/fedora-cisco-openh264.repo

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-lazygit-*.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-starship-*.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/atim-ubuntu-fonts-*.repo
sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:ublue-os:staging.repo
