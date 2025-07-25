# Nimbus-os &nbsp; [![bluebuild build badge](https://github.com/blue-build/template/actions/workflows/build.yml/badge.svg)](https://github.com/blue-build/template/actions/workflows/build.yml)

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

## Image features

For these images I'm using [Ublue's](https://universal-blue.org/) Silverblue images with a couple of changes:

### Software Changes

#### RPM Packages Changes

The following packages are removed from the base image:
- `virtualbox-guest-additions` - I don't see a huge value in it.
- `gnome-shell-extension-background-logo` - I disable it automatically, so no use in having it

Packages added to the base image:
- `starship` - for a good-looking prompt.
- `fastfetch` - why not?
- `lazygit` - git repository manager
- `gnome-shell-extension-appindicator` - not default, can be enabled through the Extensions app.
- `evince` - the base image already has the thumbnailer and previewer, so installing the app itself doesn't add much as the dependencies are already in place.
- `ubuntu-family-fonts`
- `fira-code-fonts`
- `cascadia-code-nf-fonts` - Cascadia Nerd Fonts
- `java-21-openjdk` - to be able to install Autofirma
- `google-chrome` - have yet another browser compatible with Autofirma

#### Additional Software

[Autofirma](https://sede.serviciosmin.gob.es/ES-ES/FIRMAELECTRONICA/Paginas/AutoFirma.aspx) is installed by default so that you can use the Spanish DNIe OOTB.

#### Default flatpaks

Some flatpaks will be installed automatically as soon as the system boots up and has an active connection:
- Gnome Calculator
- Gnome Calendar
- Gnome Characters
- Gnome Contacts
- Loupe
- Gnome Text Editor
- Showtime
- Flatseal
- Impression
- Libreoffice
- Extension Manager
- Resources

### System changes

The `rpm-ostreed-automatic.service` service is disabled in favour of `bootc-fetch-apply-updates.service`.
An override has been set for the latter to avoid automatic reboots.

[QMK](https://qmk.fm/) udev file is added to allow keyboard customisations.

#### Gnome Defaults
- Automatic Timezone Enabled
- Default fonts settings changed:
  - Monospaced font changed to *Cascadia Code Nerd*.
  - Font antialiasing enabled.
  - Font hinting set to *slight*.
- Numlock on keyboard enabled by default.
- Natural scroll enabled by default for mice.
- Automatically remove old temp and trash files.
- File-chooser to sort directories before files.
- Appindicator as the only gnome-shell plugin enabled by default

## Installation

> **Warning**
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  sudo bootc switch ghcr.io/franute/nimbus-os:latest
  ```
  Or using `rpm-ostree` if you prefer that.
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/franute/nimbus-os:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  sudo bootc switch --enforce-container-sigpolicy ghcr.io/franute/nimbus-os:latest
  ```
  Again, there's the option of using `rpm-ostree` but `bootc` is the preferred option.
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
