#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script calculates the response ratio and converts it into integers.            #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

function calcResponseRatio() {
	for p in ${process_IDs[@]}
	do
		if [[ ${bt[$p]} -eq 0 ]]
		then
			responseR[$p]=0
		else
			rratio=$(bc <<< "scale=0;(${wt[$p]}+${bt[$p]})*1000/${bt[$p]}")  # Calculate response ratio fo each process * 1000
			responseR[$p]=$rratio
		fi
	done
}