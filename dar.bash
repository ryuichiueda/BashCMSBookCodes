#!/bin/bash
a=ダァ
echo "元の値: $a"

echo 1 |
while read dummy ; do
    a=シェリイェッス
    echo "中: $a"
done

echo "外: $a"
