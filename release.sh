# !/bin/bash
#
mkdir -p dists/stable/main/binary-armhf
dpkg-scanpackages pool/ /dev/null > dists/stable/main/binary-armhf/Packages
gzip -k -f dists/stable/main/binary-armhf/Packages
