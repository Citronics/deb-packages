#!/bin/bash
set -e
dpkg-deb --build meta-packages/citronics-lime citronics-lime_1.0_armhf.deb
echo "Built citronics-lime_1.0_armhf.deb"
