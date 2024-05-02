install-additional-flatpaks:
    #!/usr/bin/bash
    FLATPAKS="custom_flatpaks/additional"
    FLATPAK_LIST="$(cat ${FLATPAKS} | tr '\n' ' ')"
    flatpak --system -y install ${FLATPAK_LIST}

install-advanced-flatpaks:
    #!/usr/bin/bash
    FLATPAKS="custom_flatpaks/advanced"
    FLATPAK_LIST="$(cat ${FLATPAKS} | tr '\n' ' ')"
    flatpak --system -y install ${FLATPAK_LIST}