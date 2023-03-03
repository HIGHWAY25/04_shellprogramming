#!/bin/bash

if [ $# -ne 1 ] ; then
        echo "Usage: $0 {U-1|U-2|U-#}"
        exit 1
fi

NUM1=$(echo $1 | awk -F- '{print $2}')
NUM2=$(expr $NUM1 + 1)

FILE1=/root/bin/report.txt
sed -n "/U-$NUM1/,/U-$NUM2/p" $FILE1 | grep -v "U-$NUM2"
