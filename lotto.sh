# lotto.sh

# Here the default values select six numbers 
# in the range 1-59 to play 
# the UK Lotto game or the New Work Lotto game. 
# Usage: ./lotto.sh <number> <number>:wq

#!/bin/bash

# Assign the first argument 
# to a variable if numeric and below 10,
# or  supply a default value

if [[ $1 = [0-9]* && $1 -lt 10 ]]
then a=$1; else a=6 ; fi


# Assign the second argument
# to a variable if numeric and greater than the first argument;
# or supply a default

if [[ $2 = [0-9]* && $1 -lt $2 ]]
then b=$2; else b=59 ; fi


# Function to select a quantity of numbers,
# specified by the first variable,
# from a randomised array of numbers 
# in the range of one to that of second variable

function lotto
{
	for (( i = 0; i <= $2; i++ ))
	{
		(( arr[i] = i ))
	}

	for (( i = 1; i <= $2; i++ ))
	{
		r=$(( ( RANDOM % $2 ) + 1 ))
		# perform swap between array[i] with array[r]
		(( t=arr[i] )); (( arr[i]=arr[r] )); (( arr[r]=t ))
	}

	for (( i = 1; i <= $1; i++ ))
	{
		str+="${arr[$i]} "
	}

	echo "Your Lucky $1 From $2 : $str"
}

# call the function with arguments
lotto $a $b

#####
