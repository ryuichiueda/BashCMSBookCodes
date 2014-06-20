#!/bin/bash

tmp=/tmp/$$
dlm="@a@a@a@"
end="|b|b|b|"
ret="-c-c-c-"

cat << FIN > $tmp-sql
USE wordpress;
SET NAMES utf8;
SELECT * FROM wp_uedaposts INTO OUTFILE "/tmp/out.$$" FIELDS TERMINATED BY "$dlm";
FIN

mysql -u root -pyyy < $tmp-sql

cat /tmp/out.$$                      |
sed "s/[^\\]$/&$end/"                |
sed "s/\x0d.*$/$ret/"                |
tr -d '\n\r'                         |
sed "s/$end/\n/g"                    |
sed "s/${dlm}${dlm}/${dlm}_${dlm}/g" |
sed "s/${dlm}${dlm}/${dlm}_${dlm}/g"

rm -f $tmp-*
