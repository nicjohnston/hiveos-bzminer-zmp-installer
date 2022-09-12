#!/bin/bash
#Written by ApplicableRobot #9696
#Limited support available, contact in Flexpool discord server

bzminerCurVersion=11.0.3
workDir=/hive/miners/bzminer/$bzminerCurVersion
bzminerNewVersion=11.0.3

zilWallet=""
if echo "$1" | grep -q zil; then
	zilWallet=$1;
	echo "Zil address will be configured to: $zilWallet";
else
	echo "Please provide your zil address as the first argument";
	exit 1;
fi

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

##install new version of bzminer
#cd /tmp
#wget https://github.com/bzminer/bzminer/releases/download/v"$bzminerNewVersion"/bzminer_v"$bzminerNewVersion"_linux.tar.gz
#tar -C "$workDir"/ --strip-components 1 -xvf bzminer_v"$bzminerNewVersion"_linux.tar.gz bzminer_v"$bzminerNewVersion"_linux/bzminer

#get params from config.txt
cd $workDir
cp config.txt config-orig.txt # backup config for good measure
#rm config.txt
#username=$(grep username config.txt | cut -d'"' -f4)
username=$(jq -r '.pool_configs[0].username' config.txt)
password=$(jq -r '.pool_configs[0].password' config.txt)

##write base of config.txt
#cat << EOL >> config-new.txt
#{
#  "log_file": "/var/log/miner/bzminer/miner.log",
#  "verbosity": 2,
#  "stales_ok": true,
#  "http_password": "",
#  "http_port": 4014,
#  "http_address": "127.0.0.1",
#  "http_enabled": true,
#  "pool_configs": [
#    {
#EOL

#modify config.txt json
cat config-orig.txt | jq '.pool_configs[.pool_configs| length] |= . + {"algorithm": "zil", "wallet": "'$zilWallet'", "username": "'$username'", "password": "'$password'", "lhr_only": false, "url": ["zmp://zil.flexpool.io"] } | .pool = [0,1]' > config-new.txt

#inform user:
echo "The following changes are about to be applied to config.txt:"
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
diff -y config-orig.txt config-new.txt
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
echo

if [[ $2 != "y" ]]; then
	read -p "Press enter to apply this change, Ctrl-C to cancel";
fi

echo "Removing config.txt..."
rm config.txt
echo "Creating new config.txt..."
mv config-new.txt config.txt
echo "Protecting file from hiveos..."
chmod -w config.txt
chattr +i config.txt


if [[ $2 != "y" ]]; then
	read -p "Press enter to start the miner, Ctrl-C to cancel";
fi

miner start

