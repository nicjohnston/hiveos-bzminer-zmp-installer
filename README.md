# HiveOS BZminer ZMP Installer
This collection of scripts installs bzminer's latest version (ahead of HiveOS's repo), modifies the config file to add Zilliqa mining with Flexpool, and provides a couple helper scripts.

This is currently configured to use BZminer 11.0.4b2, with HiveOS's repos set to install 11.0.3.  I'll attempt to keep this updated as long as it is needed to run Zilliqa dual mining on Flexpool with ZMP.

Also note that if the flightsheet is changed or hiveos starts providing a newer version of BZminer it might break the install, requiring a re-installation.  I'll provide details as this becomes clearer.

I'll try to provide some support, either through issues or the Flexpool discord server.

# Install Instructions
1. In Hive, configure a flightsheet to mine ethereum with bzminer version 11.0.3
2. Start said flightsheet and confirm that it is running and submitting shares
3. This script can be installed either as a worker command through the hiveos webui, or in the terminal.  For the web ui, run `wget -O /tmp/install-zmp-bzminer.sh https://raw.githubusercontent.com/nicjohnston/hiveos-bzminer-zmp-installer/main/install.sh && bash /tmp/install-zmp-bzminer.sh <zil address here> y` as a worker command.  Note that the second argument (`y`) tells the script to proceed with all changes.  For a more interactive install, run the following command in the terminal: `wget -O /tmp/install-zmp-bzminer.sh https://raw.githubusercontent.com/nicjohnston/hiveos-bzminer-zmp-installer/main/install.sh && bash /tmp/install-zmp-bzminer.sh <zil address here>`

# Helper Scripts
To update BZminer without modifying `config.txt` use:

`wget -O /tmp/update-bzminer.sh https://raw.githubusercontent.com/nicjohnston/hiveos-bzminer-zmp-installer/main/update-bzminer.sh && bash /tmp/update-bzminer.sh`

This command can take `r` as an argument to reboot, but I recommend against using this.

For locking and unlocking the config file (to prevent hive from being able to overwrite changes to `config.txt`), the following commands are available.  Note that these are not needed for a normal installation (`install-zmp-bzminer.sh` will lock `config.txt` automatically), but are available to easily make manual modifications to `config.txt`.

`wget -O - https://raw.githubusercontent.com/nicjohnston/hiveos-bzminer-zmp-installer/main/protect-config.sh | bash`
`wget -O - https://raw.githubusercontent.com/nicjohnston/hiveos-bzminer-zmp-installer/main/release-config.sh | bash`

To install all of these tools locally in  `/usr/local/bin` use `wget -O - https://raw.githubusercontent.com/nicjohnston/hiveos-bzminer-zmp-installer/main/install-scripts.sh | bash`
