#!/bin/bash

IP1=172.16.6.10
PORT1=21

ftp -n $IP1 $PORT1 << EOF
user user01 user01
cd share
lcd /test
bin
hash
prompt
mput s1.txt
EOF