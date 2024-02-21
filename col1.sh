#!/bin/sh

usage(){
        echo "usage: ./col.sh " 1>&2
        exit 1
}

if [ $# -gt 0 ]; then
        usage
fi

for i in $(ls | grep -E '^(.[^_]+)_(.[^_]+)\.col'); do
        filename1=$(echo $i | sed -E 's/_.+//g').1
        filename2=$(echo $i | sed -E 's/^.+_//g' | sed -E 's/\.col$//g').2
        cat $i | awk '{print $1}' > $filename1
        cat $i | awk '{print $2}' > $filename2
done
