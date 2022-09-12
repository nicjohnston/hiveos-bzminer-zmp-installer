#!/bin/bash
#Written by ApplicableRobot #9696
#Limited support available, contact in Flexpool discord server

bzminerCurVersion=11.0.3
workDir=/hive/miners/bzminer/$bzminerCurVersion

chmod -w $workDir/config.txt
chattr +i $workDir/config.txt
