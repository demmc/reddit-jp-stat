#!/bin/bash

# usage: ./to-table.sh
# mk-stat.shが作ったデータからMarkdownのテーブルを作る。

{
    echo '### 2016/12について'
    echo
    sed <data/scores-comments-threads-users_2016-12.data 's|^|/r/|g' |
	sort -s -k1,1 | 
	sort -nrs -k5,5 |
	./table.sh -h 'subreddit scores comments threads users'
    echo

    for f in scores comments threads users; do
	echo '### ' $f
	echo
	file=data/${f}_top5_time.data
	cat $file | table -h 'time /r/newsokur /r/newsokunomoral /r/lowlevelaware /r/newsokuvip /r/bakanewsjp'
	echo
    done
    
} >data/table.md
