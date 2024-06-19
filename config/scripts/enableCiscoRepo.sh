#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/fedora-cisco-openh264.repo
