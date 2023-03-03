#!/bin/bash
#   # cat hosts.txt
#   192.168.10.10 server10.example.com server10
#   192.168.10.10 server11.example.com server11
#   .......
#   192.168.10.30 server30.example.com server30

#HOSTS=/etc/hosts
HOSTS=/root/bin/hosts &&> $HOSTS
NET=192.168.10
START=10
END=20

C_IP=$(ip addr show ens33  | grep -w inet \
| awk '{print $2}' \
| awk -F. '{print $4}' \
| awk -F/ '{print $1}')
# => echo $C_IP ; read

for i in $(seq $START $END) 
do
    [ $C_IP -eq $i ] && continue
    echo "$NET.$i server$i.example.com server$i" >> $HOSTS
done
