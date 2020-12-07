#! /bin/zsh

input_file=$1

typeset number_of_trees=0
typeset forest_lines=$(wc -l $input_file | awk '{print $1}')
typeset tree_slots=$(($(head -1 input.txt | awk '{print length}')))
typeset hpos=1

function traverse {
    hjump=$1
    vjump=$2
    
    for (( i=1+$vjump ; i<=$forest_lines ; i+=$vjump )) ; do
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

	# echo $cline
	# echo $hpos $cpos $i $cobj
    done
    echo $number_of_trees
}

patha=$(traverse 1 1) ; echo patha = $patha
pathb=$(traverse 3 1) ; echo pathb = $pathb
pathc=$(traverse 5 1) ; echo pathc = $pathc
pathd=$(traverse 7 1) ; echo pathd = $pathd
pathe=$(traverse 1 2) ; echo pathe = $pathe

echo the mutiplicity of trees is $((patha*pathb*pathc*pathd*pathe)).

### xyzzy ###
