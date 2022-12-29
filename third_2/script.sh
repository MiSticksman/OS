#!/bin/bash
myDate=""
myTime=""
level=""
while  getopts d:t:l: val
do
	case $val in
	d)
		myDate=$OPTARG
	;;

	t)
		myTime=$OPTARG
	;;

	l)
		level=$OPTARG
	;;

	*) echo "Usage: -d <date> -t <time> -l <log_level> <file_name>"
		exit 1
	;;
	esac
done
if [[ ${myDate:0:1} == "+" ]] ; then
	ch_date="+"
	myDate=`date -d "${myDate:1}" +%s`
	echo xui1
elif [[ ${myDate:0:1} == "-" ]] ; then
	ch_date="-"
	myDate=`date -d "${myDate:1}" +%s`
elif [[ ${#myDate} -gt 0 ]] ; then
	ch_date=""
	myDate=`date -d "$myDate" +%s`
	echo "$myDate"
fi

if [[ ${myTime:0:1} == "+" ]] ; then
	ch_time="+"
	myTime=`date -d "${myTime:1}" +%s`
elif [[ ${myTime:0:1} == "-" ]] ; then
	ch_time="-"
	myTime=`date -d "${myTime:1}" +%s`
elif [[ ${#myTime} -gt 0 ]] ; then
	ch_time=""
	myTime=`date -d "$myTime" +%s`
fi

if [ ${#myDate} -le 0 ] && [ ${#myTime} -le 0 ] && [ ${#level} -le 0 ] ; then
	echo no no no
fi

shift $(expr $OPTIND - 1)
inputFile=$1
#levels=("INFO", "WARN", "ERROR")
#if ! [[ "$level" =~ "${levels[@]}" ]] ; then
#	2>>errors.txt
	#exit 0
#fi

> testDate.txt
i=0
while IFS=' ' read -r -a line
do

	lineDate=`date -d "${line[0]}" +%s`
	lineTime=`date -d "${line[1]}" +%s`
	lineLog=${line[3]}

	line_d=""
	line_t=""
	line_l=""
	if [ "$ch_date" == "+" ] ; then
		if  [ $lineDate -gt $myDate ] ; then
			line_d=${line[*]}
		fi
	elif  [ "$ch_date" == "-" ] ; then
		if [ $lineDate -lt $myDate ] ; then
			line_d=${line[*]}
		fi
	elif [ ${#myDate} -gt 0 ] && [ "$ch_date" == "" ] ; then
		if  [ $lineDate -eq $myDate ] ; then
			line_d=${line[*]}
		fi
	else 
		line_d=${line[*]}
	fi

	if [ "$ch_time" == "+" ] ; then
		if [ $lineTime -gt $myTime ] ; then
			line_t=${line[*]}
		fi
	elif  [ "$ch_time" == "-" ] ; then
		if [ $lineTime -lt $myTime ] ; then
			line_t=${line[*]}
		fi
	elif [ ${#myTime} -gt 0 ] && [ "$ch_time" == "" ] ; then
		if  [ $lineTime -eq $myTime ] ; then
			line_t=${line[*]}
		fi
	else
			line_t=${line[*]}
	fi

	if [ "$lineLog" == "$level" ] ; then
		line_l=${line[*]}

	elif [ ${#level} -le 0 ] ; then 
		line_l=${line[*]}
	fi

	if [ "${line[*]}" == "$line_d" ] && [ "${line[*]}" == "$line_t" ] && [ "${line[*]}" == "$line_l" ] ; then
		#echo $i
		echo ${line[*]}	
		#((i++))
	fi
done < $inputFile #> text.txt
