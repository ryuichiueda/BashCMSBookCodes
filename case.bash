#!/bin/bash

read a
case "$a" in 
yes )
    echo いえーす！
;;
no  )
    echo のおおお！
;;
*  )
    echo ああん？？
;;
esac
