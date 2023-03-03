#!/bin/bash

echo -n "Enter NUM1: "
read NUM1

echo -n "Enter OP (+|-|X|/) : "
read OP

echo -n "Enter NUM2: "
read NUM2

if [ $OP='+' ]; then
expr $NUM1 + $NUM2
    elif [ $OP = '-' ]; then
    expr $NUM1 - $NUM2
    elif [ $OP = 'x' ]; then
    expr $NUM1 \* $NUM2
    elif [ $OP = '/' ]; then
    expr $NUM1 / $NUM2
    else
    :
fi
#case $OP in
#    +)  expr "$NUM1 + $NUM2 = $(expr $NUM1 + $NUM2)";;
#    -)  expr "$NUM1 - $NUM2 = $(expr $NUM1 - $NUM2)";;
#    x)  expr "$NUM1 X $NUM2 = $(expr $NUM1 \* $NUM2)";;
#    /)  expr "$NUM1 / $NUM2 = $(expr $NUM1 / $NUM2)";;
#    *)  echo "[ FAIL ] 계산할 수 없습니다." ; exit 1 ;;
#esac
