#!/bin/bash
#Written by ApplicableRobot #9696
#Limited support available, contact in Flexpool discord server

cd /tmp/
mkdir aprb-installer
cd aprb-installer
git clone -b share-issue-testing https://github.com/nicjohnston/hiveos-bzminer-zmp-installer.git
cd hiveos-bzminer-zmp-installer
cp install.sh /usr/local/bin/install-zmp-bzminer.sh
cp protect-config.sh /usr/local/bin/protect-config.sh
cp release-config.sh /usr/local/bin/release-config.sh
cp update-bzminer.sh /usr/local/bin/update-bzminer.sh
cp logify-config.sh /usr/local/bin/logify-config.sh
cd /tmp/
rm -R aprb-installer/
