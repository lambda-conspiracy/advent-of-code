#! /bin/zsh

typeset input_file=$1

function binarize {
    sed 's/[FfLl]/0/g' | sed 's/[BbRr]/1/g'	
}

function encode_row {
    sed 's/0/F/g' | sed 's/1/B/g'
}

function encode_column {
    sed 's/0/L/g' | sed 's/1/R/g'
}

seats=$(for ticket in $(cat $input_file) ; do
	    typeset row=$((2#$(echo $ticket | binarize | cut -c 1-7)))
	    typeset column=$((2#$(echo $ticket  | binarize | cut -c 8-10)))
	    typeset seat=$((row*8+column))
	    echo $seat
	done | sort -n)

my_seat=$(($(count=$(($(echo $seats | head -1)))
	  for s in $(cat seats) ; do
	      if [[ $s -ne $count ]] ; then
		  echo $s
	      fi
	      ((count+=1))
	  done | head -1)-1))

echo My seat is $my_seat, my ticket is: $(echo $(([##2]$my_seat)) | bc | cut -c 1-7 | encode_row)$(echo $(([##2]$my_seat)) | bc | cut -c 8-10 |encode_column)

### xyzzy ###
