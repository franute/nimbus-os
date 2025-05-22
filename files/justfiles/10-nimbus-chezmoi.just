# vim: set ft=make :

chezmoi-services-setup:
    #!/usr/bin/env bash
    echo "Enabling chezmoi-init.service and chezmoi-update.timer for current user"
    systemctl enable --user chezmoi-init.service chezmoi-update.timer
    echo "Please restart now to activate it"
