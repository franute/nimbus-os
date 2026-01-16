# vim: set ft=make :

build-main:
    #!/usr/bin/env bash
    sudo bluebuild generate-iso --secure-boot-url https://github.com/blue-build/base-images/raw/refs/heads/main/files/base/etc/pki/akmods/certs/akmods-blue-build.der --enrollment-password nimbus --variant silverblue --iso-name nimbus-os.iso image ghcr.io/franute/nimbus-os

build-nvidia:
    #!/usr/bin/env bash
    sudo bluebuild generate-iso --secure-boot-url https://github.com/blue-build/base-images/raw/refs/heads/main/files/base/etc/pki/akmods/certs/akmods-blue-build.der --enrollment-password nimbus --variant silverblue --iso-name nimbus-os-nvidia.iso image ghcr.io/franute/nimbus-os-nvidia

build-home:
    #!/usr/bin/env bash
    sudo bluebuild generate-iso --secure-boot-url https://github.com/blue-build/base-images/raw/refs/heads/main/files/base/etc/pki/akmods/certs/akmods-blue-build.der --enrollment-password nimbus --variant silverblue --iso-name nimbus-os-home.iso image ghcr.io/franute/nimbus-os-home
