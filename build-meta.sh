#!/bin/bash
set -e
for pkg_dir in meta-packages/*/; do
  if [ -d "${pkg_dir}DEBIAN" ]; then
    pkg_name=$(grep '^Package:' "${pkg_dir}DEBIAN/control" | awk '{print $2}')
    pkg_version=$(grep '^Version:' "${pkg_dir}DEBIAN/control" | awk '{print $2}')
    pkg_arch=$(grep '^Architecture:' "${pkg_dir}DEBIAN/control" | awk '{print $2}')
    dpkg-deb --build "$pkg_dir" "${pkg_name}_${pkg_version}_${pkg_arch}.deb"
    echo "Built ${pkg_name}_${pkg_version}_${pkg_arch}.deb"
  fi
done
