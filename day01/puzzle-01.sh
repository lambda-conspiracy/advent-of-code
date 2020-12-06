#! /bin/zsh

input_numbers=$1

for m in $(cat $input_numbers) ; do
    n=$((2020-$m))
    if (( n > 0 )) ; then
	if grep -o "^$n$" input.txt ; then
	    echo answer is $m and $n = $(($m*$n))
	fi
    fi
done | grep answer | head -1

### xyzzy ###

