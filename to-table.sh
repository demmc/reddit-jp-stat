#!/bin/bash

# usage: ./to-table.sh
# mk-stat.shが作ったデータからMarkdownのテーブルを作る。

{
    echo '## 2016/12について'
    echo
    echo '### 2016/12 各ポイントについてランキング上位15位'
    echo

    data=data/scores-comments-threads-users_2016-12.data
    paste \
	  <(seq 15) \
	  <(sort -k2,2 -nr <$data | cut -d' ' -f1 | head -15) \
	  <(sort -k3,3 -nr <$data | cut -d' ' -f1 | head -15) \
	  <(sort -k4,4 -nr <$data | cut -d' ' -f1 | head -15) \
	  <(sort -k5,5 -nr <$data | cut -d' ' -f1 | head -15) |
	sed -E 's#\t([a-z])#\t/r/\1#g' |
	./table.sh -h 'rank score comment thread user'
    echo


    echo '## 5大サブレについて推移'
    echo
    for f in scores comments threads users; do
	echo '### ' $f
	echo
	file=data/${f}_top5_time.data
	cat $file | table -h 'time /r/newsokur /r/newsokunomoral /r/lowlevelaware /r/newsokuvip /r/bakanewsjp'
	echo
    done

    echo '### 2016/12 全サブレのポイント'
    echo
    echo 'userとscoreでソート済'
    echo
    
    sed <$data 's|^|/r/|g' |
	sort -s -k1,1 |
	sort -nrs -k5,5 -k2 |
	./table.sh -h 'subreddit scores comments threads users'
    echo

} >data/table.md
