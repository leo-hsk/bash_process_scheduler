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

function findSmallest(){
	# Start with index 0
	smallest=0

	# Get length -1 of the arrival time array
	let len=${#at[*]}-1

	# Iterate through each arrival time element
	for i in $(seq 0 $len)
	do

		# Check if the value of the arrival time element is less then the smallest (first) at this time
		if [[ $((at[$i])) -lt $((at[$smallest])) ]]
 		then
 			# If yes, set the current index of the arrival time element to the smallest value
    		smallest=$i
 		fi
done
# Return index of the smallest value
echo $smallest

}