#!/usr/bin/bash

set -eoux pipefail

dnf config-manager setopt copr:copr.fedorainfracloud.org:atim:lazygit.enabled=0
dnf config-manager setopt copr:copr.fedorainfracloud.org:atim:starship.enabled=0
dnf config-manager setopt copr:copr.fedorainfracloud.org:ublue-os:staging.enabled=0
