#!/bin/bash

bzminerCurVersion=10.0.4
workDir=/hive/miners/bzminer/$bzminerCurVersion

#check to make sure bzminer is running and installed
#is bzminer configed and started?
miner status | grep -q bzminer
checkMiner=$?
if [[ checkMiner == 1 ]]; then
	echo "bzminer has not been started.  Make sure the flightsheet is configured to run bzminer 10.0.4 and start the miner ('miner start')";
fi

#is the executable installed and running
checkInstalled=1
if [ -f "$workDir/bzminer" ]; then
	ps -ef | grep -q "[0-9] $workDir/bzminer";
	checkInstalled=$?;
fi
if [[ $checkInstalled == 1 ]]; then
	echo "the proper version of bzminer is not installed and running, make sure the flightsheet is set to 10.0.4 and use 'miner log' to check the installation process";
fi

#does the log file show the miner has started?
grep -q "Working Directory: $workDir" /var/log/miner/bzminer/miner.log
checkRunning=$?
if [[ $checkRunning == 1 ]]; then
	echo "bzminer doesn't seem to be running";
fi

if [[ $checkRunning == 1 || $checkInstalled == 1 || checkMiner == 1 ]]; then
	echo "Try again goofus :-)";
	exit 1;
fi

echo "Initial checks good, proceeding"

#stop miner to prevent loosing mods to config.txt
if ! miner stop ; then
	echo "Failed to stop miner, manual intervention necessary";
fi

#get params from config.txt
cd $workDir
cp config.txt config-orig.txt # backup config for good measure
#rm config.txt
username=$(grep username config.txt | cut -d'"' -f4)

#write base of config.txt
cat << EOL >> config-new.txt
{
  "log_file": "/var/log/miner/bzminer/miner.log",
  "verbosity": 2,
  "stales_ok": true,
  "http_password": "",
  "http_port": 4014,
  "http_address": "127.0.0.1",
  "http_enabled": true,
  "pool_configs": [
    {
EOL


