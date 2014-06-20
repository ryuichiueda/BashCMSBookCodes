#!/bin/bash -xv

jot 1000000 > file              #大きなファイルを作る
cat file | tail -n 1 &          #バックグラウンドでcat, tail
ps c | grep -q cat && rm file   #catが走っていたらファイルを消してしまう
wait                            #バックグラウンドプロセスの終了待ち
