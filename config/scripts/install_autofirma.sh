#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
curl -O https://estaticos.redsara.es/comunes/autofirma/1/8/3/AutoFirma_Linux_Fedora.zip
unzip AutoFirma_Linux_Fedora.zip
rpm-ostree install -y ./autofirma-1.8.3-1.noarch_FEDORA.rpm
rm AutoFirma_Linux_Fedora.zip
rm autofirma-1.8.3-1.noarch_FEDORA.rpm