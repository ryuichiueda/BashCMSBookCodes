#!/bin/bash -vx
# Mac用

tmp=/tmp/$$

curl http://blog.ueda.asia/?p=$1    |
nkf -wLux          > $tmp-html

AUTHOR=$(grep 投稿者 $tmp-html | sed 's/.*author">//' | sed 's/<.*//')
DATE=$(grep 'datetime="' $tmp-html | sed 's/.*datetime="//' | sed 's/">.*//' | date -f - +%Y%m%d)

mkdir -p ./${DATE}

cd ./${DATE}

cat << FIN > ./INFO
s/###AUTHOR###/${AUTHOR}/g
s/###DATE###/${DATE}/g
FIN

sed -n '/class="entry-content"/,/<!-- \.entry-content -->/p' $tmp-html	|
sed 's;.*bookmarking_light_clear. />;;' > ./HTML

grep -F '<h1 class="entry-title">' $tmp-html	|
sed 's;.*<h1 class="entry-title">\(..*\)</h1>;\1;' > ./TITLE

rm -f $tmp-*
exit 0
