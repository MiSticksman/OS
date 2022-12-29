#!/bin/bash

#./script.sh -n <level> /pathToDir/

while [ -n $1 ]
do
case $1 in
	-n)
		shift
		n=$1
		shift
		break
		;;
esac
done

startDir="$(basename $1)/"
function printFiles {
if [[ $(($1 + 1)) -le $n ]]
then
	local dirs=$(ls -d $2*/)
	#echo $(basename -a $dirs)
	if [ $1 -gt 2 ]
	then
		local nameOfDir="$startDir$(basename $2)/"
	else
		local nameOfDir="$startDir"
	fi
	for dir in $dirs
	do
		local curDir=$nameOfDir$(basename $dir)
		local files=$(find $dir -maxdepth 1 -type f)
		local c=$(($1 + 1))
		echo "Entering into $curDir/ with level $c"
	#	echo -e  $(basename -a $files)
		for file in $files
		do
			echo $(basename $file)
		done
		printFiles $c $dir
	done
fi
}
echo "Entering into /$startDir with level 1"
files=$(find $1 -maxdepth 1 -type f)
for file in $files
	do
		echo $(basename $file)
	done
printFiles 1 $1
