#!/bin/bash

if [ $(date +%S) -eq 0 ] ; then
    echo ぴったり！
elif [ $(date +%S) -eq 1 ] ; then
    echo おしい！
else
    echo ぴったりじゃない！
fi
