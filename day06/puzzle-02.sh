#! /bin/zsh

typeset input_file=$1

typeset count=0

cat $input_file | awk -v RS= -v ORS=' \n' '{$1=$1}1' | while read m ; do
    typeset people=$(echo $m | awk '{print NF}')
    
    typeset common_answers=$(echo $m | grep -o . | grep '[a-z]' | sort | uniq -c | grep '['$people']' | wc -l)
    ((count+=$common_answers))
done

echo $count

### xyzzy ###
