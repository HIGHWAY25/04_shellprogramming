#!/bin/bash

PID1=$(ps -ef | grep code \
              | grep -v 'grep --color' \
              | awk '{print $2}' | sort | head -1)

[ "$PID1" ] && kill $PID1
