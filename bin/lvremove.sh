#!/bin/bash


lvremove -f /dev/vg1/lv1
vgremove -f /dev/vg1
pvremove -f /dev/sdb1
