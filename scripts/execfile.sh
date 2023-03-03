#!/bin/bash

echo -n '파일이름은? :'
read FILE1

# echo $FILE1

: << EOF
if [ -x $FILE1 ] ; then
  eval $FILE1
fi
EOF
[ -x $FILE1 ] && eval $FILE1