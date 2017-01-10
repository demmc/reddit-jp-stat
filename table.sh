#!/bin/bash

delim=
header=""
while getopts :d:h: OPT; do
    case $OPT in
	d|+d)
	    delim="-vFS=$OPTARG"
	    ;;
	h|+h)
	    header="$OPTARG""\n"
	    ;;
	*)
	    echo "usage: ${0##*/} [-d ARG] [-h ARG] [--] ARGS..."
	    exit 2
    esac
done
shift $(( OPTIND - 1 ))
OPTIND=1

{ echo -ne $header; cat /dev/stdin; } | awk $delim ' 
{
  for(i=1; i<=NF; i++){
    printf "%s", $i
    if(i != NF){ printf " | " }else{ print "" }
  }
}
NR==1{
  for(i=1; i<=NF; i++){
    printf "---"
    if(i != NF){ printf " | " }else{ print "" }
  }
}
'
