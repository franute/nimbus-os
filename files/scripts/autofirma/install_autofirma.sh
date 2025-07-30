#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
echo "Downloading dependencies"
curl -O https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Fedora.zip
curl -L https://raw.githubusercontent.com/franute/nimbus-os/refs/heads/main/files/scripts/autofirma/autofirma.md5 > autofirma.md5
unzip Autofirma_Linux_Fedora.zip

if md5sum -c autofirma/autofirma.md5 > /dev/null; then
    echo "MD5Sum validated, installing autofirma."
    rpm-ostree install -y ./autofirma-*.noarch_FEDORA.rpm
else
    echo "Incorrect MD5Sum"
    exit 1
fi

echo "Deleting downloaded files"
rm autofirma.md5
rm Autofirma_Linux_Fedora.zip
rm autofirma-*.noarch_FEDORA.rpm
