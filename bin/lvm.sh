#!/bin/bash
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3
TMP4=/tmp/tmp4
#   1.PV
#   2.VG
#   3.LV

while true
do
echo "################## PV 생성 ##################" 
###################
#   1.PV
###################
#(1) View
fdisk -l | grep LVM | awk '{print $1}' > $TMP1
pvs | tail -n +2 | awk '{print $1}' > $TMP2

cat << EOF
########## PV VIEW ##########
$(cat $TMP1 $TMP2 | sort | uniq -u)
##############################

EOF

#(2) Works
echo "=> 위의 목록에서 PV로 생성하고 싶은 볼륨을 선택합니다. <="
echo -n "볼륨 선택? (ex:/dev/sdb1 /dev/sdc1 ...) : "
read VOLUME

cat << EOF

    다음 명령어를 정말 수행할 겁니까?
    # pvcreate $VOLUME
    1) yes  2) no  3) skip

EOF
echo -n "당신의 선택은? (Y|N|S) : "
read CHOICE
case $CHOICE in
    y) : ;;
    n) continue ;;
    s) break ;;
    *) continue ;;
esac

pvcreate $VOLUME > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo " [ OK ] Physical volume $VOLUME successfully created."
    pvs
    else
    echo "[ FAIL ] Physical volume not created."
    exit 1
fi
break
done

echo "################## VG 생성 ##################" 
###################
#   2.VG
###################
#(1) View
vgs | tail -n +2 | awk '{print $1}' > $TMP3
pvs > $TMP4
for i in $(cat $TMP3) 
do
    sed -i "/$i/d" $TMP4
done

cat << EOF
################# PV LIST #################
$(cat $TMP4)
###########################################

EOF
#(2) Works
# vgcreate vg1 /dev/sdb1 /dev/sdc1
echo -n 'VG 이름은? (ex: vg1) :'
read VGNAME

echo -n "선택가능한 PV 목록을 적어 주세요 (ex: /dev/sdb1 /dev/sdc1 .....)"
read PVLIST

vgcreate $VGNAME $PVLIST
if [ $? -eq 0 ]; then
    echo "[ OK ] Volume group $VGNAME successfully created"
    vgs
else
    echo "[ FAIL ] Volume group not created"
    exit 2
fi

echo "################## LV 생성 ##################" 
###################
#   3.LV
###################
#(1) View
cat << EOF
################# VG LIST #################
$(vgs | awk '$7 != '0' {print $0}')
###########################################
 
#(2) Works
# lvcreate vg1 -n lv1 -L 500
echo -n "LV를 생성할 VG 이름은? (ex: vg1) : "
read VGLV
s
    echo "[ OK ] Volume group $LVNAME successfully created"
    lvs
else
    echo "[ FAIL ] Volume group not created"
    exit 3
fi
###################