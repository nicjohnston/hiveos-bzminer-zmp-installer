#!/bin/bash
#Written by ApplicableRobot #9696
#Limited support available, contact in Flexpool discord server

cd /hive/miners/bzminer/11.0.3/
if grep log_file_verbosity config.txt; then
	echo "already configured for verbose logs, goodbye";
	exit 0;
fi

miner stop

release-config.sh

cat config.txt | jq '.pool = [0,1] | .+ {"log_file_verbosity":4}' > config-new.txt

#inform user:
echo "The following changes are about to be applied to config.txt:"
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
diff -y config.txt config-new.txt
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
echo

if [[ $1 != "y" ]]; then
	read -p "Press enter to apply this change, Ctrl-C to cancel";
fi

protect-config.sh

miner start
