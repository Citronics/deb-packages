# !/bin/bash
#
mkdir -p dists/stable/main/binary-armhf
dpkg-scanpackages pool/ /dev/null > dists/stable/main/binary-armhf/Packages
gzip -k -f dists/stable/main/binary-armhf/Packages
mkdir -p dists/stable/main/binary-arm64
cp dists/stable/main/binary-armhf/Packages dists/stable/main/binary-arm64/Packages
gzip -k -f dists/stable/main/binary-arm64/Packages
