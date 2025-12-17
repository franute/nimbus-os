#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
echo "Installing dependencies"
dnf install -y cabextract xorg-x11-font-utils
echo "Downloading mscorefonts2 installer"
curl https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm -o /tmp/msttcore-fonts-installer-2.6-1.noarch.rpm
echo "Installing mscorefonts2 installer"
rpm -i --nodigest /tmp/msttcore-fonts-installer-2.6-1.noarch.rpm

echo "Deleting downloaded files"
rm /tmp/msttcore-fonts-installer-2.6-1.noarch.rpm
