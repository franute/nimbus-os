#!/usr/bin/bash

set -eoux pipefail

# Remove Existing Kernel
# for pkg in kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra; do
#     rpm --erase $pkg --nodeps
# done

AKMODS_FLAVOR="main"
BASE_IMAGE_NAME="silverblue"

# Fetch Common AKMODS & Kernel RPMS
skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods:"${AKMODS_FLAVOR}"-"$(rpm -E %fedora)" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' </tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/
mv /tmp/rpms/* /tmp/akmods/
# NOTE: kernel-rpms should auto-extract into correct location

# Install Kernel
# dnf5 -y install \
#     /tmp/kernel-rpms/kernel-[0-9]*.rpm \
#     /tmp/kernel-rpms/kernel-core-*.rpm \
#     /tmp/kernel-rpms/kernel-modules-*.rpm

# # TODO: Figure out why akmods cache is pulling in akmods/kernel-devel
# dnf5 -y install \
#     /tmp/kernel-rpms/kernel-devel-*.rpm

# dnf5 versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra


# Fetch Nvidia RPMs
if [[ "${IMAGE_NAME}" =~ open ]]; then
    skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods-nvidia-open:"${AKMODS_FLAVOR}"-"$(rpm -E %fedora)" dir:/tmp/akmods-rpms
else
    skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods-nvidia:"${AKMODS_FLAVOR}"-"$(rpm -E %fedora)" dir:/tmp/akmods-rpms
fi
NVIDIA_TARGZ=$(jq -r '.layers[].digest' </tmp/akmods-rpms/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods-rpms/"$NVIDIA_TARGZ" -C /tmp/
mv /tmp/rpms/* /tmp/akmods-rpms/

# Exclude the Golang Nvidia Container Toolkit in Fedora Repo
# Exclude for non-beta.... doesn't appear to exist for F42 yet?
# if [[ "${UBLUE_IMAGE_TAG}" != "beta" ]]; then
#     dnf5 config-manager setopt excludepkgs=golang-github-nvidia-container-toolkit
# else
    # Monkey patch right now...
    if ! grep -q negativo17 <(rpm -qi mesa-dri-drivers); then
        dnf5 -y swap --repo=updates-testing \
            mesa-dri-drivers mesa-dri-drivers
    fi
# fi

# Install Nvidia RPMs
curl -Lo /tmp/nvidia-install.sh https://raw.githubusercontent.com/ublue-os/main/main/build_files/nvidia-install.sh
chmod +x /tmp/nvidia-install.sh
IMAGE_NAME="${BASE_IMAGE_NAME}" RPMFUSION_MIRROR="" /tmp/nvidia-install.sh
rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json
ln -sf libnvidia-ml.so.1 /usr/lib64/libnvidia-ml.so

KARGS_D="/usr/lib/bootc/kargs.d"
BLUEBUILD_NVIDIA_TOML="${KARGS_D}/00-bluebuild-nvidia-kargs.toml"

# Create kargs folder if doesn't exist
mkdir -p "${KARGS_D}"
echo 'kargs = ["rd.driver.blacklist=nouveau", "modprobe.blacklist=nouveau", "nvidia-drm.modeset=1", "initcall_blacklist=simpledrm_platform_driver_init"]' >> "${BLUEBUILD_NVIDIA_TOML}"
