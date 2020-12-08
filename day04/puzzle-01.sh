#! /bin/zsh

input_file=$1

typeset valid_entries=0

awk -v RS= '{$1=$1}1' $input_file | while read m ; do
    typeset m_fields=$(($(echo $m | awk '{print NF}')))

    case $m_fields in
	8)  ((valid_entries+=1))
	    ;;
	7)  if ! echo $m | grep -q 'cid:' ; then
		((valid_entries+=1))
	    fi
	    ;;
	*)  ;;
    esac
done

echo There are $valid_entries entries.

### xyzzy ###
