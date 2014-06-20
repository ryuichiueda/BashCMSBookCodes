#!/bin/bash
# bash3では動きまへん

############################
#連想配列が使えるらしい

declare -A city
city[tokyo]="東京"
city[osaka]="大阪"

echo ${city[tokyo]}

############################
#ユニコードを指定できる（4.2以降）

echo -e '\u3072\u3043\u3043'
