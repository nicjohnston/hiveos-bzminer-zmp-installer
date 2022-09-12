#!/bin/bash
#Written by ApplicableRobot #9696
#Limited support available, contact in Flexpool discord server

bzminerCurVersion=11.0.3
workDir=/hive/miners/bzminer/$bzminerCurVersion

if miner status | grep -q bzminer; then
	echo "Miner is still running, please stop miner before unlocking config.txt for editing";
	exit 1;
fi

chattr -i $workDir/config.txt
chmod +w $workDir/config.txt
