#!/bin/bash

logfile="/tmp/ceph-pg-stat.log"
ceph="/usr/bin/ceph"

###
. ceph-functions.sh

### do not edit below
_dump() {
	$ceph pg stat >$logfile
}

_stat() {
	cat $logfile |awk -F",| " '{ for (x=1;x<=NF;x++) if ($x ~ "'"$1"'") sum+=$(x-1) } END {print sum}'
}

###
case $1 in
	"dump") _dump; _check_w && _check_r ;;
	$1) score=`_stat $1`;
	if [[ $score == "" ]]; then
		echo 0; else
		echo $score;
	fi ;;
	*)
esac
