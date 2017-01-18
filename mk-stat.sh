#!/bin/bash

# usage: ./mk-stat.sh
# ./plot-stat.shに必要なデータを集計する。

# 各サブレディットの2016/12の値を抜き出す。
# ユーザ数でソートする
ls r/*/scores-comments-threads-users_time.data |
    xargs grep -H 2016/12 |
    sed -e 's|^r/||g' -e 's|/.*:2016/12 | |g' |
    sort -k5,5 -nr |
    cut -d' ' -f1,2,3,4,5 >data/scores-comments-threads-users_2016-12.data


tmp=$(mktemp)

# 5大サブレ(newsokur、newsokunomoral、lowlevelaware、newsokuvip、bakanewsjp)の比較データを作る。
# スコア、コメント、スレッド数、ユーザ数について。

function sponge(){
    local temp
    temp=$(mktemp)
    cat - >"$temp"
    mv -f "$temp" "$1"
}

# score数の比較
target=scores-comments-threads-users_time
join \
    <(cat r/newsokur/$target.data | cut -d' ' -f1,2) \
    <(cat r/newsokunomoral/$target.data | cut -d' ' -f1,2) \
    >$tmp
for sub in lowlevelaware newsokuvip bakanewsjp; do
    join $tmp <(cat r/$sub/$target.data | cut -d' ' -f1,2) | sponge $tmp
done
mv $tmp data/scores_top5_time.data


# comment数の比較
target=scores-comments-threads-users_time
join \
    <(cat r/newsokur/$target.data | cut -d' ' -f1,3) \
    <(cat r/newsokunomoral/$target.data | cut -d' ' -f1,3) \
    >$tmp
for sub in lowlevelaware newsokuvip bakanewsjp; do
    join $tmp <(cat r/$sub/$target.data | cut -d' ' -f1,3) | sponge $tmp
done
mv $tmp data/comments_top5_time.data

# thread数の比較
target=scores-comments-threads-users_time
join \
    <(cat r/newsokur/$target.data | cut -d' ' -f1,4) \
    <(cat r/newsokunomoral/$target.data | cut -d' ' -f1,4) \
    >$tmp
for sub in lowlevelaware newsokuvip bakanewsjp; do
    join $tmp <(cat r/$sub/$target.data | cut -d' ' -f1,4) | sponge $tmp
done
mv $tmp data/threads_top5_time.data


# user数の比較
target=scores-comments-threads-users_time
join \
    <(cat r/newsokur/$target.data | cut -d' ' -f1,5) \
    <(cat r/newsokunomoral/$target.data | cut -d' ' -f1,5) \
    >$tmp
for sub in lowlevelaware newsokuvip bakanewsjp; do
    join $tmp <(cat r/$sub/$target.data | cut -d' ' -f1,5) | sponge $tmp
done
mv $tmp data/users_top5_time.data
