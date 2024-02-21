#!/bin/sh

usage(){
	echo "usage: ./renjpg.sh [dir]" 1>&2
	exit 1
}

if [ $# -gt 1  ]
then
	usage
fi

if [ ! -d $1 ]; then
	usage
fi

if [ -d $1 ];then
	for oldfilename in $( file --mime-type * | grep -e 'image/jpeg$' | awk 'NF {print $1}'| tr -d ':')
	do
		echo hola
		mv $oldfilename {$oldfilename}_image.jpg
	done
fi

