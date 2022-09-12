#!/bin/bash

bzminerCurVersion=10.0.4

#check to make sure bzminer is running and installed
#is bzminer configed and started?
miner status | grep -q bzminer
checkMiner=$?
if [[ checkMiner == 1 ]]; then
	echo "bzminer has not been started.  Make sure the flightsheet is configured to run bzminer 10.0.4 and start the miner ('miner start')";
fi

#is the executable installed and running
checkInstalled=1
if [ -f "/hive/miners/bzminer/$bzminerCurVersion/bzminer" ]; then
	ps -ef | grep "[0-9] /hive/miners/bzminer/$bzminerCurVersion/bzminer";
	checkInstalled=$?;
fi
if [[ $checkInstalled == 1 ]]; then
	echo "the proper version of bzminer is not installed, make sure the flightsheet is set to 10.0.4 and use 'miner log' to check the installation process";
fi

#does the log file show the miner has started?
grep "Working Directory: /hive/miners/bzminer/$bzminerCurVersion" /var/log/miner/bzminer/miner.log
checkRunning=$?
if [[ $checkRunning == 1 ]]; then
	echo "bzminer doesn't seem to be running";
fi

if [[ $checkRunning == 1 || $checkInstalled == 1 || checkMiner == 1 ]]; then
	echo "Try again goofus :-)";
	exit 1;
fi

echo "all checks good, proceeding"
