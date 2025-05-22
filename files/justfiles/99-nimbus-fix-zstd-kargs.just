# vim: set ft=make :

fix-zstd-kargs:
  #!/usr/bin/env bash
  if ! rpm-ostree kargs | grep zstd >> /dev/null; then
    echo "Adding kargs"
    sudo rpm-ostree kargs --delete=rootflags=subvol=root --append=rootflags=subvol=root,compress=zstd:1,x-systemd.device-timeout=0
  else
    echo "zstd kargs already in place, skipping..."
  fi
