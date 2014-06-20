#!/bin/bash -xv
dir=$(dirname $0)
exec 2> $dir/../www-data/$(basename $0).$(date +%Y%m%d%H%M%S).$$

echo "Content-Type: text/html"
echo
sed 's/^/\t/' $dir/pages/top/html        |
filehame -lDOCUMENT $dir/template.0.html -
