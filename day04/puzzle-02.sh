#! /bin/zsh 

input_file=$1

typeset valid_entries=0

function length {
    echo $1 | awk '{print length}'
}

function get_keyval {
    typeset key=$1
    if [[ $# -eq 2 ]] ; then
	echo $2 | awk 'match($0,/'$key':.*?/) {print substr($0,RSTART,RLENGTH)}' | awk '{print $1}'
    else
	awk 'match($0,/'$key':.*?/) {print substr($0,RSTART,RLENGTH)}' | awk '{print $1}'
    fi
}

function get_val {
    echo $1 | awk -F: '{print $2}'
}

function byr_p {
    # byr (Birth Year) - four digits; at least 1920 and at most 2002.

    typeset keyval=$(get_keyval byr $1)
    typeset val=$(($(get_val $keyval)))
    typeset val_len=$(($(length $val)))
    
    if (( ( val_len == 4 ) && ( val >= 1920 ) && ( val <= 2002 ) )) ; then
	return 0
    else
	return 1
    fi
}

function iyr_p {
    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.

    typeset keyval=$(get_keyval iyr $1)
    typeset val=$(($(get_val $keyval)))
    typeset val_len=$(($(length $val)))
    
    if (( ( val_len == 4 ) && ( val >= 2010 ) && ( val <= 2020 ) )) ; then
	return 0
    else
	return 1
    fi
}

function eyr_p {
    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.

    typeset keyval=$(get_keyval eyr $1)
    typeset val=$(($(get_val $keyval)))
    typeset val_len=$(($(length $val)))

    if (( ( val_len == 4 ) && ( val >= 2020 ) && ( val <= 2030 ) )) ; then
	return 0
    else
	return 1
    fi
}

function hgt_p {
    # hgt (Height) - a number followed by either cm or in:
    # If cm, the number must be at least 150 and at most 193.
    # If in, the number must be at least 59 and at most 76.

    typeset keyval=$(get_keyval hgt $1)
    typeset val=$(get_val $keyval)
    typeset num=$(($(echo $val | sed 's/[ci][mn]//')))
    typeset unit=$(echo $val | sed 's/[0-9]*//')

    case $unit in
	"cm")
	    if (( num >= 150  && num <= 193 )) ; then
		return 0
	    fi
	    ;;
	"in")
	    if (( num >= 59  && num <= 76 )) ; then
		return 0
	    fi
	    ;;
	*)
	    return 1
	    ;;
    esac
}

function hcl_p {
    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    
    typeset keyval=$(get_keyval hcl $1)
    typeset val=$(get_val $keyval)

    echo $val | egrep -q '#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
}

function ecl_p {
    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    
    typeset keyval=$(get_keyval ecl $1)
    typeset val=$(get_val $keyval)

    echo $val | egrep -iq 'amb|blu|brn|gry|grn|hzl|oth'
}

function pid_p {
    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    
    typeset keyval=$(get_keyval pid $1)
    typeset val=$(get_val $keyval)

    echo $val | egrep -q '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
}

function cid_p {
    # cid (Country ID) - ignored, missing or not.
    return 0
}


awk -v RS= '{$1=$1}1' $input_file | while read m ; do
    if ! echo $m | grep -q 'cid:' ; then
	m=$(echo $m cid:NPC | tr ' ' '\n' | sort | paste -s -d' '  -)
    else
	m=$(echo $m | tr ' ' '\n' | sort | paste -s -d' '  -)
    fi
    
    typeset m_fields=$(echo $m | awk '{print NF}')

#   if [[ $m_fields -eq 8 ]] ; then
	if byr_p $m && cid_p && ecl_p $m && eyr_p $m && hcl_p $m && hgt_p $m && iyr_p $m && pid_p $m ; then
	    echo VALID: $m_fields fields, $m
	    ((valid_entries+=1))
#	fi
    else		
	echo INVALID: $m_fields fields, $m
    fi
done

echo There are $valid_entries valid entries.

### xyzzy ###
