#!/bin/bash

# usage: (cd r/newsokur; ../../mk-data.sh)
# r/{subreddit}に移動して実行する。
# submissions.tsvを集計する。

set -eu

# スコア、コメントの分布
gawk <submissions.tsv -vFS='\t' '
  {
    t_s[$3]+=1
    t_c[$4]+=1
  }
  END{
    for(s in t_s){
      print s, t_s[s], t_c[s]
    }
  }' | sort -n >scores-comments_dist.data


function norm-days(){
    # 月ごとの日数を正規化する
    gawk '
    {
      print "norm-days", $0 >/dev/stderr
      d = $1
      # point * 30 / <その月の日数>
      if(d ~ /^.*\/02$/){
        # 2月は28日
        ratio = 30 / 28.0
      }else if(d ~ /^.*\/(04|06|09|11)$/){
        # 4、6、9、11月は30日
        # 30.0 / 30.0
        ratio = 1.0
      }else{
        # 1、3、5、7、8、10、12月は31日
        ratio = 30.0 / 31.0
      }
      printf "%s", d
      for(i=2; i<=NF; i++){
        n = $i * ratio
        if(n >= int(n)+0.5){
          n = int(n) + 1
        }else{
          n = int(n)
        }
        printf " %d", n
      }
      print ""
    }' -
}

# スコア、コメント、スレッドの月ごとの合計
gawk <submissions.tsv -vFS='\t' '
  {
    date=strftime("%Y/%m", $2)
    t_s[date]+=$3
    t_c[date]+=$4
    t_t[date]+=1
  }
  END{
    for(d in t_s){
      print d, t_s[d], t_c[d], t_t[d]
    }
  }' | norm-days | sort -k1,1 >scores-comments-threads_time.data

# その月に1回以上サブミッションを立てたユーザ数の合計
gawk <submissions.tsv -vFS='\t' '
  {
    date=strftime("%Y/%m", $2)
    print date, $5
  }' | sort | uniq | cut -d' ' -f1 | uniq -c |
    gawk '{print $2, $1}' | norm-days >users_time.data

join scores-comments-threads_time.data users_time.data >scores-comments-threads-users_time.data
