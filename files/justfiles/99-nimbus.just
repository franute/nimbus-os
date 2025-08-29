# vim: set ft=make :

# Adds zstd encryption to kargs
nimbus-fix-zstd-kargs:
    #!/usr/bin/env bash
    if ! rpm-ostree kargs | grep zstd >> /dev/null; then
        echo "Adding kargs"
        sudo rpm-ostree kargs --delete=rootflags=subvol=root --append=rootflags=subvol=root,compress=zstd:1,x-systemd.device-timeout=0
    else
        echo "zstd kargs already in place, skipping..."
    fi

# Enables chezmoi for the current user
nimbus-chezmoi-services-setup:
    #!/usr/bin/env bash
    echo "Enabling chezmoi-init.service and chezmoi-update.timer for current user"
    systemctl enable --user chezmoi-init.service chezmoi-update.timer
    echo "Please restart now to activate it"

# Sets current user as operator for tailscale
nimbus-tailscale-set-operator:
    #!/usr/bin/env bash
    sudo tailscale set --operator=$USER
