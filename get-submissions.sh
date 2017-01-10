#!/bin/bash

# usage: (cd r/newsokur; ../../get-submissions.sh)
# r/{subreddit} に移動して実行する。
# そのサブレディットのサブミッションをすべて取得しsubmissions.jsonに保存する。
# 大きいサブレディットだと時間がかかることに注意。
# 並列に実行してもReddit側で絞られるだろうから意味ない。

# ./get-submissions.sh [-a] [period]
# options:
#   -a       追記する
#   period   2015-11-11,2016-01-11 のような形式で期間を設定する


# 2015-02-17はnewsokurが生まれた日
# subreddits.txtに書かれたサブレディットはすべてこの日以降に作られた．

append=
while getopts :a OPT; do
    case $OPT in
	a|+a)
	    append=1
	    ;;
	*)
	    echo "usage: ${0##*/} [+-a} [--] ARGS..."
	    exit 2
    esac
done
shift $(( OPTIND - 1 ))
OPTIND=1

span=${1:-2015-02-17,2016-12-31}

if [[ -z $append ]]; then
    subm "$(basename "$(pwd)")" "$span" >submissions.json
else
    subm "$(basename "$(pwd)")" "$span" >>submissions.json
fi
