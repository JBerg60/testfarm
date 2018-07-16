#!/bin/bash

ENDPOINT="http://manufacturing.riedel.net/api/v1/testfarm/register"
SERIAL=$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2)

curl "$ENDPOINT?serial=$SERIAL"
