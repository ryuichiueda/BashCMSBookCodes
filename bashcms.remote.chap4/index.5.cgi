#!/bin/bash -xv
dir=$(dirname $0)
tmp=/tmp/$$
exec 2> $dir/../www-data/$(basename $0).$(date +%Y%m%d%H%M%S).$$

#GETの文字列から記事ディレクトリ名を得る
page=$(tr -dc 'a-zA-Z0-9_' <<< "${QUERY_STRING:2}")

#日記記事のリストを作る       <- 12行目まで追加
ls -f "$dir/pages/"     |
grep -E "^[0-9]{14}_"   |
sort                    > $tmp-diarylist

#チェック
[ "$page" = "" ]          && page=$(tail -n 1 $tmp-diarylist)
[ -d "$dir/pages/$page" ] || page=$(tail -n 1 $tmp-diarylist)

#前の記事、次の記事
: > $tmp-navi
if grep -Eq "^[0-9]{14}_" <<< "$page" ; then
    grep -B 1 -A 1 "$page" $tmp-diarylist |
    tr '\n' ' '                           |   
    awk '{print $1,$NF}'                  |   
    tr ' ' '\n'                           |   
    awk 'NR==1{print "前の記事",$1}
         NR==2{print "次の記事",$1}'       |   
    grep -v "$page$"                      |   
    sed 's/_/\\_/g' > $tmp-navi

    UPLOAD=$(self -d 1.1.14 "$page" | dayslash "yyyy年m月d日H時M分" 1)   
fi

sed 's/_/\\_/g' "$dir/pages/$page/categories" | sed 's/ /_/g' > $tmp-cs

echo "Content-Type: text/html"
echo
#記事ファイルを読んでインデントをつける
sed 's/^/\t/' "$dir/pages/$page/html"              |
#リンク先を変える
sed "s;\(href\|src\)=\";&/pages/$page/;g"          |
sed "s;\"/pages/$page/\([^:\"]*\)://;\"\1://;g"    |
sed "s;\"/pages/$page//;\"?p=;g"                   |
#テンプレートに記事をはめ込む
filehame -lDOCUMENT $dir/template.5.html -        |
mojihame -lNAVI_HEADER - $tmp-navi                |
mojihame -lNAVI_FOOTER - $tmp-navi                |
mojihame -lCATEGORIES - "$tmp-cs"                 |
sed "s/@UPLOAD/$UPLOAD/"              

rm $tmp-*
