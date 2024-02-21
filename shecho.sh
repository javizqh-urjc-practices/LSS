#!/bin/sh

usage(){
	echo "usage: shecho.sh [-s] [arg] ..." 1>&2
	exit 1
}

if [ $# -gt 0 ]
then
	if [ "$1" = -h  ]
	#Con argumento -h
	then
		usage
	elif [ "$1" = -s  ]
	#Con argumento -s
	then
		for word in $@
		do
			if ! [ $word = $1 ]
			then
				echo -n "$word\t"
			fi
		done | sed -e 's/\t$//g'
	else
	#Sin argumento
		for word in "$@"
		do
		echo -n "$word\t"
		done | sed -e 's/\t$//g'
	fi
	echo ""
	
fi
