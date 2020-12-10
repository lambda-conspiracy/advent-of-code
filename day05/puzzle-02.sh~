#! /bin/zsh

typeset input_file=$1

cat $input_file | awk -v RS= '{$1=$1}1' | sed 's/ *//g' | while read m ; do echo $m |grep -o . | grep '[a-z]' | sort | uniq | wc -l ; done | paste -s -d'+' - | bc

### xyzzy ###
