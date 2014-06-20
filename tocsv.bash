#!/bin/bash

tmp=/tmp/$$

cat << FIN > $tmp-sql
USE wordpress;
SET NAMES utf8;
SELECT * FROM wp_uedaposts INTO OUTFILE "/tmp/out.$$" FIELDS TERMINATED BY ',';
FIN

mysql -u root -pyyy < $tmp-sql

cat /tmp/out.$$

rm -f $tmp-*
