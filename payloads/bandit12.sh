#!/usr/bin/env bash

function get_type() {
    echo $(file -b $1 | tr ' ' '\n' | head -n1)
}

function gzip_get_filename() {
    echo $(gzip -l $1 | tr ' ' '\n' | tail -1)
}

function tar_get_filename() {
    echo $(tar -tf $1)
}


working_file=data
temporary_dir=/tmp/me
# Works on temporary directory to have permissions

mkdir -p $temporary_dir && cp ~/data.txt $temporary_dir/data.txt && cd $temporary_dir && xxd -r data.txt > $working_file

while true; do
    rm -f *.gz *.tar.gz *.bz

    type=$(get_type "$working_file")
    
    if [ "$type" == "ASCII" ]; then
	    cat "$working_file" | tr ' ' '\n' | tail -1
	    exit 1
    elif [ "$type" == "gzip" ]; then
	    mv -f "$working_file" data.gz
	    working_file=$(gzip_get_filename data.gz)
	    gzip -d data.gz
    elif [ "$type" == "bzip2" ]; then 
	    mv -f "$working_file" "$working_file.bz2" && bzip2 -d "$working_file.bz2"
    elif [ "$type" == "POSIX" ]; then
	    mv -f "$working_file" data.tar.gz
	    working_file=$(tar_get_filename data.tar.gz)
	    tar -xf data.tar.gz
    else
	    echo "$working_file $type NOT FOUND, ABORTING..."
	    exit 1
    fi
done