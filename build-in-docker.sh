#!/usr/bin/env sh

set -eux

if [[ ! -v BUILD_VERSION ]]; then
    echo "BUILD_VERSION is not set"
    exit 1
fi

mkdir /build
cd /build

wget https://github.com/hyprwm/hyprwayland-scanner/archive/refs/tags/v$BUILD_VERSION.tar.gz -O hyprwayland-scanner-$BUILD_VERSION.tar.gz
tar -xzmf hyprwayland-scanner-$BUILD_VERSION.tar.gz
cd hyprwayland-scanner-$BUILD_VERSION

cp -r /shared/debian /build/hyprwayland-scanner-$BUILD_VERSION/debian
sed -i "s/VERSION_TEMPLATE/$BUILD_VERSION/g" /build/hyprwayland-scanner-$BUILD_VERSION/debian/changelog
sed -i "s/VERSION_TEMPLATE/$BUILD_VERSION/g" /build/hyprwayland-scanner-$BUILD_VERSION/debian/control
dpkg-buildpackage -us -uc

cd /build
ls -l

cp hyprwayland-scanner_$BUILD_VERSION\_amd64.deb /shared

cd /shared
dpkg-deb -c hyprwayland-scanner_$BUILD_VERSION\_amd64.deb
dpkg -I hyprwayland-scanner_$BUILD_VERSION\_amd64.deb
