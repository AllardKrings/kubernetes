#!/bin/bash
kcat -b 192.168.40.83:9092 -t $1 -P
