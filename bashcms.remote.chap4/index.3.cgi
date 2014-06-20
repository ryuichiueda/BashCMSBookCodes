#!/bin/bash -xv
dir=$(dirname $0)
exec 2> $dir/../www-data/$(basename $0).$(date +%Y%m%d%H%M%S).$$

#GETの文字列から記事ディレクトリ名を得る
page=$(tr -dc 'a-zA-Z0-9_' <<< "${QUERY_STRING:2}")

#チェック
[ "$page" = "" ] && page=top
[ -d "$dir/pages/$page" ] || page=top

echo "Content-Type: text/html"
echo
#記事ファイルを読んでインデントをつける
sed 's/^/\t/' "$dir/pages/$page/html"           |
#リンク先を変える
sed "s;\(href\|src\)=\";&/pages/$page/;g"       |
sed "s;\"/pages/$page/\([^:\"]*\)://;\"\1://;g" |
sed "s;\"/pages/$page//;\"?p=;g"                |       
#テンプレートに記事をはめ込む
filehame -lDOCUMENT $dir/template.0.html -
