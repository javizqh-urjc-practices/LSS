#!/bin/sh

usage(){
        echo "usage: ./col.sh dir " 1>&2
        exit 1
}

if ! [ $# -eq 1 ]; then
        usage
fi

cwd=$(pwd)

if ! [ -d $1 ]; then
        usage
fi

cd $1

ficheros_col=0

for i in $(ls | grep -E '^(.[^_]+)_(.[^_]+)\.col'); do
        filename1=$(echo $i | sed -E 's/_.+//g').1
        filename2=$(echo $i | sed -E 's/^.+_//g' | sed -E 's/\.col$//g').2
        cat $i | awk '{print $1}' > $filename1
        cat $i | awk '{print $2}' > $filename2
	ficheros_col=1
done

if [ $ficheros_col -eq 0 ]; then
        echo "no files" 1>&2
        exit 1
fi

cd $cwd
