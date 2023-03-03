#!/bin/bash

echo -n '파일 이름은? : '
read FILE1

# echo $FILE1
if [ -f $FILE1 ] ; then
    echo '일반파일입니다.'
elif [ -d $FILE1 ] ; then
    echo '디렉토리 파일입니다.'
else
    echo '알수 없는 파일'
fi