#!/usr/bin/bash

set -eoux pipefail

dnf config-manager setopt fedora-cisco-openh264.enabled=0
dnf config-manager setopt google-chrome.enabled=0

dnf config-manager setopt copr:copr.fedorainfracloud.org:atim:ubuntu-fonts.enabled=0
