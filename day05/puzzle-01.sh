#! /bin/zsh

typeset input_file=$1

function binarize {
    sed 's/[FfLl]/0/g' | sed 's/[BbRr]/1/g'	
}

highest_seat=0

for ticket in $(cat $input_file) ; do
    typeset row=$((2#$(echo $ticket | binarize | cut -c 1-7)))
    typeset column=$((2#$(echo $ticket  | binarize | cut -c 8-10)))
    typeset seat=$((row*8+column))

    if (( seat >= $highest_seat )) ;  then
	highest_seat=$seat
    fi
done

echo The highest seat on the plane is $highest_seat.

### xyzzy ###
