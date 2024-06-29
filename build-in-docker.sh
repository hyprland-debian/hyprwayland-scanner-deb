#!/usr/bin/env sh

set -eux

export VER="0.3.10"

mkdir /build
cd /build

wget https://github.com/hyprwm/hyprwayland-scanner/archive/refs/tags/v$VER.tar.gz -O hyprwayland-scanner-$VER.tar.gz
tar -xzmf hyprwayland-scanner-$VER.tar.gz
cd hyprwayland-scanner-$VER

cp -r /shared/debian /build/hyprwayland-scanner-$VER/debian
sed -i "s/VERSION_TEMPLATE/$VER/g" /build/hyprwayland-scanner-$VER/debian/changelog
sed -i "s/VERSION_TEMPLATE/$VER/g" /build/hyprwayland-scanner-$VER/debian/control
dpkg-buildpackage -us -uc

cd /build
ls -l

cp hyprwayland-scanner_$VER\_amd64.deb /shared

cd /shared
dpkg-deb -c hyprwayland-scanner_$VER\_amd64.deb
dpkg -I hyprwayland-scanner_$VER\_amd64.deb