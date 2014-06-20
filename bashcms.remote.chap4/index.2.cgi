#!/bin/bash -xv
dir=$(dirname $0)
exec 2> $dir/../www-data/$(basename $0).$(date +%Y%m%d%H%M%S).$$

#GETの文字列から記事ディレクトリ名を得る
page=$(tr -dc 'a-zA-Z0-9_' <<< "${QUERY_STRING:2}")

#チェック
[ "$page" = "" ]          && page=top
[ -d "$dir/pages/$page" ] || page=top

echo "Content-Type: text/html"
echo
sed 's/^/\t/' "$dir/pages/$page/html"        |
filehame -lDOCUMENT $dir/template.0.html -
