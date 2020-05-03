#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script returns the index of the element with the highest response ratio.       #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

function findHighestResponseRatio(){
	# Start with index 0

	highest=0

	# Iterate through each responseRatio element
	for i in ${process_IDs[@]}
	do
		# Check if process already arrived
		if [[ ${at[$i]} -le $clock ]]
		then
		
			# Check if the value of the response ratio element is more than the highest (first) at this time
    		if [[ $((responseR[$i])) -ge $((responseR[$highest])) ]]
     		then
     			# If yes, set the current index of the response ratio element to the highest value
        		highest=$i
     		fi
     	fi
done
# Return index of the highest value
echo $highest

}