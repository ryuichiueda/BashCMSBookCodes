#!/bin/bash -xv
cat /usr/share/dict/words | sort -R | yarr -10 > /tmp/dummy

num=$(wc -l < /tmp/dummy | tr -d ' ')
n=0
m=0

find /var/www/bashcms/pages/  |
grep '/html$'                 |
while read f ; do
    [ $(wc -l < $f) -gt 1 ] && continue

    awk -v "m=$m" -v "num=$num" 'NR>(m%num) && NR<=(m+100)%num' /tmp/dummy >> $f
    n=$(($n + 1))
    m=$(($m + 100))

    echo $n $m
done
