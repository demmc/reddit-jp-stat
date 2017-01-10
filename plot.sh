#!/bin/bash

# usage: (cd r/newsokur; ../../plot.sh)
# そのサブレディットについていくつかグラフを書く。
sub=$(basename `pwd`)
cat <<EOF | gnuplot -
    set terminal png;
    set output "scores-comments_dist.png";
    set title "$sub scores and comments distribution";
    set xrange [0:70];
    set xlabel "Points"
    set ylabel "Frequency"
    set style data linespoints;
    set key below;
    plot "scores-comments_dist.data" using 1:2 title "scores",\
         "scores-comments_dist.data" using 1:3 title "comments";
EOF

cat <<EOF | gnuplot -
    set terminal png;
    set output "scores-comments_time.png";
    set title "$sub scores and comments";
    set xdata time;
    set timefmt "%Y/%m";
    set format x "%Y/%m";
    set xlabel "Time";
    set ylabel "Frequency";
    set xtics "2015/02", 7883999, "2016/12";
    set xrange ["2015/03":"2016/12"]
    set style data linespoints;
    set key below;
    plot "scores-comments-threads_time.data" using 1:2 title "scores",\
         "scores-comments-threads_time.data" using 1:3 title "comments";
EOF

cat <<EOF | gnuplot -
    set terminal png;
    set output "users-threads_time.png";
    set title "$sub users and threads";
    set xdata time;
    set timefmt "%Y/%m";
    set format x "%Y/%m";
    set xrange ["2015/03":"2016/12"]
    set xlabel "Time";
    set ylabel "Frequency (users)";
    set xtics "2015/02", 10511999, "2016/12";
    set ytics nomirror;
    set autoscale;
    set y2label "Frequency (threads)";
    set y2tics autofreq;
    set y2tics auto;
    set style data linespoints;
    set key below;
    plot "users_time.data" using 1:2 title "users",\
         "scores-comments-threads_time.data" using 1:4 title "threads" axes x1y2;
EOF
