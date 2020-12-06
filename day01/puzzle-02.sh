#! /bin/zsh

input_numbers=$1

for m in $(cat $input_numbers) ; do
    for n in $(cat $input_numbers | grep -v "^$m$") ; do
	o=$((2020-$m-$n))
	if (( o > 0 )) ; then
	   if grep -o "^$o$" input.txt ; then
	       echo answer is $m and $n and $o = $(($m*$n*$o))
	   fi
	fi
    done
done | grep answer | head -1

### xyzzy ###

