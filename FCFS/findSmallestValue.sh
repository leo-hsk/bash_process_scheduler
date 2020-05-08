#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script returns the index of the element with the smallest value.               #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

function findSmallestValue(){
	smallest=0  # Start with index 0

	let len=${#at[*]}-1  # Get highest inedx of the arrival time array.

	for i in $(seq 0 $len)  # Iterate through each index in the arrival time array.
	do
		if [[ $((at[$i])) -lt $((at[$smallest])) ]]  # Check if the value of the arrival time element is less than the smallest.
 		then
    		smallest=$i  # If yes, set the current index of the arrival time element to the smallest value
 		fi
done
echo $smallest  # Return index of the smallest value

}