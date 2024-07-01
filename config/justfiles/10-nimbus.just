# vim: set ft=make :

install-additional-flatpaks:
    #!/usr/bin/bash
    FLATPAKS="/usr/share/ublue-os/just/custom_flatpaks/additional"
    FLATPAK_LIST="$(cat ${FLATPAKS} | tr '\n' ' ')"
    flatpak --system -y install ${FLATPAK_LIST}

install-advanced-flatpaks:
    #!/usr/bin/bash
    FLATPAKS="/usr/share/ublue-os/just/custom_flatpaks/advanced"
    FLATPAK_LIST="$(cat ${FLATPAKS} | tr '\n' ' ')"
    flatpak --system -y install ${FLATPAK_LIST}

configure-powerline-go-bash:
    #!/usr/bin/bash
    if ! grep powerline-go ~/.bashrc -q; then
        echo "Configuring Powerline-go for user bash profile."
        cat /usr/share/ublue-os/just/custom_config/powerline_go >> ~/.bashrc
    else
        echo "Powerline-go already configured in user's .bashrc."
    fi