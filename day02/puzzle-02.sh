#! /bin/zsh

input_file=$1

typeset valid_count=0
typeset input_line=0

cat $input_file | while read m ; do
    ((input_line+=1))
    typeset pos_one=$(echo $m | awk '{print $1}' | awk -F- '{print $1}')
    typeset pos_two=$(echo $m | awk '{print $1}' | awk -F- '{print $2}')
    typeset valid_char=$(echo $m | awk '{print $2}' | sed 's/://')
    typeset password=$(echo $m | awk '{print $3}')
    typeset pos_one_match=$(echo $password | grep -o . | grep -n $valid_char | grep ^$pos_one: | awk -F: '{print $1}')
    typeset pos_two_match=$(echo $password | grep -o . | grep -n $valid_char | grep ^$pos_two: | awk -F: '{print $1}')
    
    if [[ ( -n $pos_one_match || -n $pos_two_match ) && ! ( -n $pos_one_match && -n $pos_two_match ) ]] ; then
	    ((valid_count+=1))
    fi
done

echo There are $valid_count valid passwords.

### xyzzy ###
