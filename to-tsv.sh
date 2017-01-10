#!/bin/bash

# usage: (cd r/newsokur; ../../to-tsv.sh)
# submissions.jsonを扱いやすいようにtsvファイルにする
# カラムは:
#   スレッドID、作成時のUNIX TIME、スコア、コメント数、作者、フレア、ドメイン、URL、タイトル
# のようになっている。

jq <submissions.json -r '[.id, .created_utc, .score, .num_comments, .author, .link_flair_text, .domain, .url, .title] | @tsv' >submissions.tsv
