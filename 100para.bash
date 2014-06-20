#!/bin/bash                  
                             
for i in {0..99} ; do        
    ls -f /var/www/bashcms/pages/ | grep -E "^[0-9]{14}_" | sort > /tmp/hoge.$$ &
done                         
                             
wait                         
rm -f /tmp/hoge.* 
