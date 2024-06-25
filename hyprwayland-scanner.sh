#!/usr/bin/env bash

VER=0.3.10

wget https://github.com/hyprwm/hyprwayland-scanner/archive/refs/tags/v$VER.tar.gz -O hyprwayland-scanner-$VER.tar.gz
tar -xzmf hyprwayland-scanner-$VER.tar.gz
cd hyprwayland-scanner-$VER

mkdir debian

cat > debian/changelog <<EOF
hyprwayland-scanner ($VER) unstable; urgency=low

  * Release

 -- John Doe <john@doe.org>  Wed, 22 May 2024 17:54:24 +0000
EOF

cat > debian/rules <<EOF
#!/usr/bin/make -f
export DH_VERBOSE = 1

%:
	dh \$@ --buildsystem=cmake
EOF
chmod +x debian/rules

cat > debian/control <<EOF
Source: hyprwayland-scanner
Section: utils
Priority: extra
Maintainer: John Doe <john@doe.org>
Build-Depends: libpugixml-dev (>= 0.0.0), debhelper (>= 0.0.0), cmake (>= 3.19.0), pkg-config (>= 0.0.0)
Standards-Version: $VER

Package: hyprwayland-scanner
Section: utils
Priority: extra
Architecture: amd64
Depends: \${shlibs:Depends}
Description: A Hyprland implementation of wayland-scanner, in and for C++.
EOF

echo 10 > debian/compat

dpkg-buildpackage -S -nc

cd ..

pbuilder build hyprwayland-scanner_$VER.dsc

dpkg -I /var/cache/pbuilder/result/hyprwayland-scanner_$VER\_amd64.deb
