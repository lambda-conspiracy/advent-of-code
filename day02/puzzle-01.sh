#! /bin/zsh

input_file=$1

typeset valid_count=0

cat $input_file | while read m ; do
    typeset min=$(echo $m | awk -F- '{print $1}')
    typeset max=$(echo $m | awk '{print $1}' | awk -F- '{print $2}')
    typeset valid_char=$(echo $m | awk '{print $2}' | sed 's/://')
    typeset password=$(echo $m | awk '{print $3}')
    typeset char_matches=$(($(echo $password | egrep -o $valid_char | wc -l)))
    
    if (( $min <= $char_matches && $char_matches <= $max )) ; then
	((valid_count+=1))
    fi
done

echo There are $valid_count valid passwords.

### xyzzy ###

