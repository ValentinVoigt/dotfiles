#!/bin/bash

set -eu

_term() {
	echo "Caught SIGTERM, killing children :O"
	pkill -P $$
}

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
	trap _term SIGTERM
	trap _term SIGINT

	for i in $(seq 1 32); do
		cmd="sox"

		if [ $i == 1 ]; then
			cmd="$cmd -S"
		fi

		for file in "$@"; do
			cmd="$cmd \"$file\""
		done

		cmd="$cmd \"$i.flac\" remix $i"
		echo "$cmd"
		eval "$cmd" &
	done

	wait
fi
