#! /bin/zsh

input_file=$1

typeset number_of_trees=0
typeset forest_lines=$(wc -l $input_file | awk '{print $1}')
typeset tree_slots=$(($(head -1 input.txt | awk '{print length}')))
typeset hpos=1
typeset hjump=3

for (( i=2 ; i<=$forest_lines ; i++ )) ; do
    typeset cline=$(sed -n ${i}p $input_file)
    ((hpos+=$hjump))

    if (( $hpos > $tree_slots )) ; then
	typeset cpos=$(($hpos%$tree_slots))
	if (( cpos == 0 )) ; then
	    cpos=$tree_slots
	fi
    else
	typeset cpos=$hpos
    fi

    typeset cobj=$(echo $cline | grep -o . | grep -n . | sed -n ${cpos}p | awk -F: '{print $2}')
    
    if [[ $cobj = \# ]] ; then
	((number_of_trees++))
    fi
done

echo There are $number_of_trees trees.

### xyzzy ###
