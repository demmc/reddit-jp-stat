#!/bin/bash

# usage: ./apply-all.sh ./plot.sh
#
#  r/{subreddit}のそれぞれに移動して引数に指定したスクリプトを実行する。

command=$(readlink -f ${1?})
if [[ ! -x $command ]]; then
    command=$1
fi
shift

echo $command
find r -maxdepth 1 -type d ! -name r | while read -r d; do
    pushd "$d" >/dev/null
    echo "=== $(basename "$d") ==="
    $command $@
    popd >/dev/null
done
