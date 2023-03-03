#!/bin/bash
:<< EOF
for i in $(cat file1)
do
    echo $i
done
EOF

cat file1 | while read i
do
    echo $i
done