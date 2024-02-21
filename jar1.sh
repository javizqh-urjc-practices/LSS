#!/bin/sh


usage(){

	echo "usage: jar.sh classpath file.java [file.java] ..." 1>&2
	exit 1
}

usage_error(){

	echo "Error: "$1 "does not exist" 1>&2
        exit 1
}

classpath_usage(){

	for paths in $@; do

		if ! [ -d $paths ] ; then
			usage_error $paths
		fi
	done
}

javaFiles_usage(){

	for java_file in $@; do

		if ! ( echo $java_file | grep -e '\.java' >/dev/null ); then
			usage
		fi

		if ! [ -f $java_file ]; then
			usage_error $java_file
		fi
	done
}

printClasspath(){

	for directories in $classpath; do

		import_path=$( echo $1 | tr -s "." "/")

		path=$(echo $directories)/$import_path.class

		if ( ls $path 1>/dev/null 2>/dev/null ); then
			echo -n $path ,
		fi

	done | tr -s " " "," | sed -e 's/,$//'
}

if [ $# -lt 2 ]; then
	usage
	exit 1
fi

classpath=$(echo $1 | tr -s ":" "\n" | sed -e 's/\/$//')
classpath_usage $classpath

shift

javaFiles_usage $@

imports=$(grep -E '^import' $@ | grep -E -v ' java.' | tr -s ';' '\n' | awk {'print $2'} | sort | uniq)

for i in $imports; do
	echo -n $i '\t'
	java_files=$(grep -F $i $@ | tr -s ":" '\t' | awk {'print $1'} | sort  | uniq)
	echo -n $java_files | tr -s " " ","
	echo -n '\t'
	java_class=$(printClasspath $i)

	if [ "$java_class" != "" ] ; then
		echo $java_class
	else
		echo ??
	fi

done

exit 0
