# nimbus-os &nbsp; [![build-ublue](https://github.com/franute/nimbus-os/actions/workflows/build.yml/badge.svg)](https://github.com/franute/nimbus-os/actions/workflows/build.yml)

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

## Image features

For these images I'm using [Ublue's](https://universal-blue.org/) Silverblue images with a couple of changes:

### Software Changes

#### RPM Packages Changes

The following packages are removed from the base image:
- `gnome-software-rpm-ostree` - because updates happen automatically already, there's no need to keep this functionality in Gnome Software. Better to keep it lean and focussed on Flatpaks.
- `virtualbox-guest-additions` - I don't see a huge value in it.

Packages added to the base image:
- `powerline-go` - for a good-looking prompt.
- `gnome-shell-extension-appindicator` - not default, can be enabled through the Extensions app.
- `evince` - the base image already has the thumbnailer and previewer, so installing the app itself doesn't add much as the dependencies are already in place.
- `simple-scan` - for now it's better to have it layered as the flatpak can only use driverless printers.
- `ubuntu-family-fonts`
- `fira-code-fonts`
- `cascadia-code-nf-fonts` - Cascadia Nerd Fonts
- `java-17-openjdk` - to be able to install Autofirma

#### Additional Software

[Autofirma](https://sede.serviciosmin.gob.es/ES-ES/FIRMAELECTRONICA/Paginas/AutoFirma.aspx) is installed by default so that you can use the Spanish DNIe OOTB.

#### Default flatpaks

Some flatpaks will be installed automatically as soon as the system boots up and has an active connection:
- Gnome Calculator
- Gnome Calendar
- Gnome Characters
- Gnome Contacts
- Extension Manager
- Loupe
- NautilusPreviewer
- Gnome Text Editor
- Clapper
- Gnome File Roller
- Flatseal
- Impression
- Libreoffice

### System changes

The `rpm-ostreed-automatic.service` now has an additional override to disable it when the system is running on battery.

[QMK](https://qmk.fm/) udev file is added to allow keyboard customisations.

#### Gnome Defaults
- Automatic Timezone Enabled
- Default fonts settings changed:
  - Document and general font changed to *Ubuntu*.
  - Titlebar font changed to *Ubuntu Bold*.
  - Monospaced font changed to *Cascadia Code Nerd*.
  - Font antialiasing enabled.
  - Font hinting set to *slight*.
- Numlock on keyboard enabled by default.
- Natural scroll enabled by default for mice.
- Automatically remove old temp and trash files.
- File-chooser to sort directories before files.

#### *Just* changes

Added a few commands:
- `configure-powerline-go-bash` to enable `powerline-go` for the current user.
- `install-additional-flatpaks` to install my default additional flatpaks:
  - Chromium browser
  - Gimp
  - Inkscape
  - Pitivi
  - Spotify
  - Dropbox
  - Fragments
  - Gnome Baobab
  - Gnome Font Viewer
  - Gnome Connections
  - Gnome Maps
  - Gnome Weather
  - Gnome Snapshot
  - Gnome Logs
- `install-advanced-flatpaks` to install my default *advanced* flatpaks:
  - Darktable
  - Kdenlive
  - Discord
  - Fractal
  - Telegram Desktop
  - OBS + plugins
  - Gnome Builder
  - Cockpit Client
  - Meld
  - Gitg
  - Gnome Firmware
  - Spot

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/franute/nimbus-os:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/franute/nimbus-os:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/franute/nimbus-os
```
