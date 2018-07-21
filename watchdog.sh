#!/bin/bash

ENDPOINT="http://192.168.0.36/api/v1/testfarm/register"
#ENDPOINT="http://manufacturing.riedel.net/api/v1/testfarm/register"
SERIAL=$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2)

curl "$ENDPOINT?serial=$SERIAL"
