#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket

temp_packages=(
    git
    extra-cmake-modules
    kwin-devel
    kf6-kconfigwidgets-devel
    kf6-kcmutils-devel
    libepoxy-devel
    wayland-devel
)

packages=(
  ${temp_packages[@]}
)

rpm-ostree install ${packages[@]}

cd /home/
git clone https://github.com/FloFri/kwin-blishhud-shader.git
cd kwin-blishhud-shader
mkdir -p build && cd build
cmake .. && make && make install

rpm-ostree uninstall ${temp_packages[@]}
rm -Rf /home/kwin-blishhud-shader/