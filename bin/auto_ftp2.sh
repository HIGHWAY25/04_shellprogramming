#!/bin/bash

for i in $(cat /root/bin/server.txt) 
do
    
    sftp -n $i 21 <<- EOF
    user root centos
    cd /tmp
    lcd /test
    bin
    hash
    prompt
    put testfile.txt
    quit
EOF

done
