#!/bin/bash

set -u

all=0
big=0
skip=0
while getopts :absh OPT; do
    case $OPT in
	a)
	    all=1
	    ;;
	b)
	    big=1
	    ;;
	s)
	    skip=1
	    ;;
	h|*)
	    echo "\
usage: `basename $0` [-a] [-b] [-s] [-h] [--] ARGS...
options:
  -a  subreddits.txtに書かれたサブレディットを取得する(ただしnewsokur、newsokunomoral、lowlevelaware、bakanewsjpは除く)。
  -b  -a と一緒に指定することで本当にsubreddits.txtに書かれたサブレディットをすべて取得する。
  -s  -a 指定時にr/{subreddit}/submissions.jsonがあるサブレディットについてはスキップする。
  -h  このヘルプを表示する。
"
	    exit 2
    esac
done
shift `expr $OPTIND - 1`
OPTIND=1


if [[ $all = 0 ]]; then
    cd "r/${1?}"
    mkdir -p "r/$1"
    ../../get-submissions.sh
    ../../to-tsv.sh
    exit
fi

while read -r target; do
    trap 'exit' INT
    
    case "$target" in
	newsokur|lowlevelaware|bakanewsjp|newsokunomoral)
	    if [[ $big = 0 ]]; then
		continue
	    fi
	    ;;
    esac

    if [[ $skip = 1 && -e r/"$target"/submissions.json && ! -e r/"$target"/now-downloading ]]; then
	continue
    fi

    mkdir -p "r/$target"
    pushd "r/$target" >/dev/null
    echo "download: $target"

    touch now-downloading
    ../../get-submissions.sh
    rm now-downloading
    
    ../../to-tsv.sh
    popd >/dev/null

done <subreddits.txt
