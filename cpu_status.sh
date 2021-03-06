#!/bin/bash
## CPU Utilization Monitoring Script
## Author: Md Tanvir

Z=`awk '/\\#define Z/ {print $3}' /usr/include/asm-generic/param.h`
CPUS=`grep ^proc /proc/cpuinfo | wc -l`
NUM1=`cat /proc/stat | awk '/^cpu / {print $5}'`
sleep 1
NUM2=`cat /proc/stat | awk '/^cpu / {print $5}'`
USED=`echo 4 k 100 $NUM2 $NUM1 - $CPUS $Z \\* / 100 \\* - p | dc`

if [ $USED -ge 95 ]; then
echo "CPU Utilization is ${USED}" | mail -s "CPU Utilization is High" ansadm@localhost
else
echo "CPU Utilization is Normal"
fi
