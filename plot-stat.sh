#!/bin/bash

# usage: ./plot-stat.sh
# ./mk-stat.shで作ったデータでグラフを書く。

### 2016-12  ##############################################################
# 2016/12 scores
sed 's/_/\\\\_/g' <data/scores-comments-threads-users_2016-12.data |
    sort -nr -k2,2 |
    gnuplot -p -e '
      set terminal png;
      set output "data/scores_2016-12_top.png";
      set title "2016/12 score ranking";
      set boxwidth 0.5 relative;
      set xtics rotate by -90;
      set xrange [-0.5:15.5];
      set xlabel "Time";
      set ylabel "Frequency";
      plot "-" using 0:2:xtic(1) with boxes title "scores";
    '

# 2016/12 comments
sed 's/_/\\\\_/g' <data/scores-comments-threads-users_2016-12.data |
    sort -nr -k3,3 | 
    gnuplot -p -e '
      set terminal png;
      set output "data/comments_2016-12_top.png";
      set title "2016/12 comment ranking";
      set boxwidth 0.5 relative;
      set xtics rotate by -90;
      set xrange [-0.5:15.5];
      set xlabel "Time";
      set ylabel "Frequency";
      plot "-" using 0:3:xtic(1) with boxes title "comments";
    '

# 2016/12 threads
sed 's/_/\\\\_/g' <data/scores-comments-threads-users_2016-12.data |
    sort -nr -k4,4 | 
    gnuplot -p -e '
      set terminal png;
      set output "data/threads_2016-12_top.png";
      set title "2016/12 thread ranking";
      set boxwidth 0.5 relative;
      set xtics rotate by -90;
      set xrange [-0.5:15.5];
      set xlabel "Time";
      set ylabel "Frequency";
      plot "-" using 0:4:xtic(1) with boxes title "threads";
    '

# 2016/12 users
sed 's/_/\\\\_/g' <data/scores-comments-threads-users_2016-12.data |
    sort -nr -k5,5 | 
    gnuplot -p -e '
      set terminal png;
      set output "data/users_2016-12_top.png";
      set title "2016/12 user ranking";
      set boxwidth 0.5 relative;
      set xtics rotate by -90;
      set xrange [-0.5:15.5];
      set xlabel "Time";
      set ylabel "Frequency";
      plot "-" using 0:5:xtic(1) with boxes title "users";
    '

### 推移比較 ############################################################

# score数について
gnuplot -p -e '
  set terminal png;
  set output "data/scores_top5_time.png";
  set title "score";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/scores_top5_time.data" using 1:2 with lp title "newsokur",
       "data/scores_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/scores_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/scores_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/scores_top5_time.data" using 1:6 with lp title "bakanewsjp";
'


# comment数について
gnuplot -p -e '
  set terminal png;
  set output "data/comments_top5_time.png";
  set title "comment";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/comments_top5_time.data" using 1:2 with lp title "newsokur",
       "data/comments_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/comments_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/comments_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/comments_top5_time.data" using 1:6 with lp title "bakanewsjp";
'

# thread数について
gnuplot -p -e '
  set terminal png;
  set output "data/threads_top5_time.png";
  set title "thread";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/threads_top5_time.data" using 1:2 with lp title "newsokur",
       "data/threads_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/threads_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/threads_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/threads_top5_time.data" using 1:6 with lp title "bakanewsjp";
'

# user数について
gnuplot -p -e '
  set terminal png;
  set output "data/users_top5_time.png";
  set title "user";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/users_top5_time.data" using 1:2 with lp title "newsokur",
       "data/users_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/users_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/users_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/users_top5_time.data" using 1:6 with lp title "bakanewsjp";
'

## Zoom版 ###############################################
# newsokurが圧倒的すぎるので他のについて見やすくする。

# score数について(Zoom)
gnuplot -p -e '
  set terminal png;
  set output "data/scores_top5_time_zoom.png";
  set title "score (zoomed)";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set yrange [0:65000];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/scores_top5_time.data" using 1:2 with lp title "newsokur",
       "data/scores_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/scores_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/scores_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/scores_top5_time.data" using 1:6 with lp title "bakanewsjp";
'
# comment数について(Zoom)
gnuplot -p -e '
  set terminal png;
  set output "data/comments_top5_time_zoom.png";
  set title "comment (zoomed)";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set yrange [0:38000];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/comments_top5_time.data" using 1:2 with lp title "newsokur",
       "data/comments_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/comments_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/comments_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/comments_top5_time.data" using 1:6 with lp title "bakanewsjp";
'

# thread数について(Zoom)
gnuplot -p -e '
  set terminal png;
  set output "data/threads_top5_time_zoom.png";
  set title "thread (zoomed)";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set yrange [0:5000];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/threads_top5_time.data" using 1:2 with lp title "newsokur",
       "data/threads_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/threads_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/threads_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/threads_top5_time.data" using 1:6 with lp title "bakanewsjp";
'

# user数について(Zoom)
gnuplot -p -e '
  set terminal png;
  set output "data/users_top5_time_zoom.png";
  set title "user (zoomed)";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set yrange[0:400];
  set xlabel "Time";
  set ylabel "Frequency";
  set key below;
  plot "data/users_top5_time.data" using 1:2 with lp title "newsokur",
       "data/users_top5_time.data" using 1:3 with lp title "newsokunomoral",
       "data/users_top5_time.data" using 1:4 with lp title "lowlevelaware",
       "data/users_top5_time.data" using 1:5 with lp title "newsokuvip",
       "data/users_top5_time.data" using 1:6 with lp title "bakanewsjp";
'

# 全サブレについてのユーザー数
gnuplot -p -e '
  set terminal png;
  set output "data/users_all_time.png";
  set timefmt "%Y/%m";
  set xdata time;
  set format x "%Y/%m";
  set xtics "2015/03", 7884000, "2016/12";
  set xrange ["2015/03":"2016/12"];
  set xlabel "Time";
  set ylabel "Frequency";
  plot "data/users_all_time.data" using 1:2 with lp title "all jp subreddits"; 
'
