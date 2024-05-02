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