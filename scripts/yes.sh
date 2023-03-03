#!/bin/bash

echo -n "너의 선택은? (yes/no):"
read CHOICE

case $CHOICE in
    yes|Y|YES|y|Yes) echo "[ OK ] Oh YES ~~" ;;
    no|N|n|No) echo "[ FAIL ] Oh No~~~~" ;;
    *) echo "[ FAIL ] yes 또는 no를 입력하세요."
        exit 1;;
esac