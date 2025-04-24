#!/usr/bin/bash

set -eoux pipefail

dnf config-manager setopt fedora-cisco-openh264.enabled=0
