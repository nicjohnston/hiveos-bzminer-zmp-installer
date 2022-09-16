#!/bin/bash
#Written by ApplicableRobot #9696
#Limited support available, contact in Flexpool discord server

bzminerCurVersion=11.0.3
workDir=/hive/miners/bzminer/$bzminerCurVersion
bzminerNewVersion=11.1.0

if ! miner stop ; then
	echo "Failed to stop miner, manual intervention necessary";
fi

#install new version of bzminer
cd /tmp
#wget https://github.com/bzminer/bzminer/releases/download/v"$bzminerNewVersion"/bzminer_v"$bzminerNewVersion"_linux.tar.gz
wget https://bzminer.com/downloads/bzminer_v"$bzminerNewVersion"_linux.tar.gz
tar -C "$workDir"/ --strip-components 1 -xvf bzminer_v"$bzminerNewVersion"_linux.tar.gz bzminer_v"$bzminerNewVersion"_linux/bzminer


if ! miner start ; then
	echo "Failed to start miner, manual intervention necessary";
fi

if [[ $1 == "r" ]]; then
	sreboot wakealarm
fi
