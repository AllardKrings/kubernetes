#!/bin/bash
echo $2 >> message
kcat -b 192.168.40.83:9092 -t $1 message -P 
rm message
