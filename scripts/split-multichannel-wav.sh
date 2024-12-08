#!/bin/bash

set -eu

if [ "$#" -lt 1 ]; then
	echo "Usage: $0 <filename-of-multichannel-wav>" >&2
	echo "" >&2
	echo "Help:" >&2
	echo "    1. cd to the target directory" >&2
	echo "    2. run split.sh from there and append every input file" >&2
	echo "       ex.: ../split.sh 1.WAV 2.WAV 3.WAV" >&2
	exit 1
elif [ ! -r "$1" ]; then
	echo "Error: File is not readable: $1" >&2
	exit 2
else
	for i in $(seq 1 32); do
		cmd="sox"
		for file in "$@"; do
			cmd="$cmd \"$file\""
		done

		cmd="$cmd \"$i.flac\" remix $i"
		echo "$cmd"
		eval "$cmd" &
	done

	wait
fi
