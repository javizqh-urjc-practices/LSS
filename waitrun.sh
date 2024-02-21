#!/bin/sh

usage(){
	echo "usage: waitrun.sh cmd" 1>&2
	exit 1
}

if [ $# -eq 1 ]
then
#Si le pasan argumentos se ejecuta

	while true
	do
		if [ -f /tmp/go ]
		then
			#Si encuentra el fichero go en tmp ejecuta el comando que le han pasado y sale
			$1
			break
		else
			#Si no encuentra el fichero ejecuta sleep 1 seg
			sleep 1
		fi
	done
else
	#Si no recibe argumentos sale con error
	usage
fi
