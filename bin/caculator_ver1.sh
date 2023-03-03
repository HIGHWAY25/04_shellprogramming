#!/bin/bash

echo -n "Enter NUM1: "
read NUM1

echo -n "Enter NUM2: "
read NUM2

cat << EOF
==============================================
 (1). +    (2). -    (3). *    (4). /
==============================================
EOF

echo -n "Enter Yout choice? (1|2|3|4) : "
read OP

case $OP in
    1)  expr "$NUM1 + $NUM2 = $(expr $NUM1 + $NUM2)";;
    2)  expr "$NUM1 - $NUM2 = $(expr $NUM1 - $NUM2)";;
    3)  expr "$NUM1 X $NUM2 = $(expr $NUM1 \* $NUM2)";;
    4)  expr "$NUM1 / $NUM2 = $(expr $NUM1 / $NUM2)";;
    *)  echo "[ FAIL ] 계산할 수 없습니다." ; exit 1 ;;
esac