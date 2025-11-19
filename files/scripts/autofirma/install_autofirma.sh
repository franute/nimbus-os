#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
echo "Downloading dependencies"
mkdir -p /tmp/autofirma
curl https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Fedora.zip -o /tmp/autofirma/Autofirma_Linux_Fedora.zip
curl https://raw.githubusercontent.com/franute/nimbus-os/refs/heads/main/files/scripts/autofirma/autofirma.md5 -o /tmp/autofirma/autofirma.md5
unzip /tmp/autofirma/Autofirma_Linux_Fedora.zip -d /tmp/autofirma

cd /tmp/autofirma

if md5sum -c autofirma.md5 > /dev/null; then
    echo "MD5Sum validated, installing autofirma."
    rpm-ostree install -y /tmp/autofirma/autofirma-*.noarch_FEDORA.rpm
else
    echo "Incorrect MD5Sum"
    exit 1
fi

echo "Deleting downloaded files"
cd /tmp
rm -rf /tmp/autofirma
