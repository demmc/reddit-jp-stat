#!/bin/bash

# usage: (cd r/newsokur; ../../mk-data.sh)
# r/{subreddit}に移動して実行する。
# submissions.tsvを集計する。

set -eu

# スコア、コメントの分布
gawk <submissions.tsv -vFS='\t' '{t_s[$3]+=1; t_c[$4]+=1;} END{for(s in t_s){print s, t_s[s], t_c[s]}}' | sort -n >scores-comments_dist.data

# スコア、コメント、スレッドの月ごとの合計
gawk <submissions.tsv -vFS='\t' '{date=strftime("%Y/%m", $2); t_s[date]+=$3; t_c[date]+=$4; t_t[date]+=1} END{for(d in t_s){print d, t_s[d], t_c[d], t_t[d]}}' | sort -k1,1 >scores-comments-threads_time.data

# その月に1回以上サブミッションを立てたユーザ数の合計
gawk <submissions.tsv -vFS='\t' '{date=strftime("%Y/%m", $2); print date, $5}' | sort | uniq | cut -d' ' -f1 | uniq -c | gawk '{print $2, $1}' >users_time.data

join scores-comments-threads_time.data users_time.data >scores-comments-threads-users_time.data
