#!/bin/sh

usage(){
	#Error message
	echo "usage: crfiles.sh [dir]" 1>&2
	exit 1
}

if ! [ $# -eq 1 ]; then
	usage
else
	dir=$1
fi


if ! [ -d $dir ]; then
	#if the argument is not a directory return error
	cwd=$(pwd)
	echo "error: could not open dir $dir from $cwd" 1>&2
	exit 1
fi

#Create the new files in the directory passed
for new_file in $(seq 1 20) ; do
	touch $dir/$new_file.q
done

#Change the name of the directory
end_new_dir_name=$(echo "_done")
mv $dir $dir$end_new_dir_name

#End the script
exit 0
