#!/bin/sh

usage(){
	echo "usage: renro dir extension " 1>&2
	exit 1
}

if ! [ $# -eq 2 ]; then
	usage
fi

if ! [ -d $1 ]; then
	usage
fi

cwd=$(pwd)

cd $1

for file in $( ls -l | grep -E '^-r--r--r--' | grep -E -v '\.'$2'$' | grep -E -v '\.ro$' | awk '{print $9}');do
	mv $file ${file}.ro
done

cd $cwd
