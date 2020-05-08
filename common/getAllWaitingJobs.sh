#!/bin/bash

#############################################################################################
#                                                                                           #
# This shell script fills a list with boolean values whether the process is waiting or not. #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

function getAllWaitingJobs() {

	# Reset the isWaiting array to all zeros
	for i in $(seq 0 $((${#isWaiting[@]}-1)))
	do
		isWaiting[$i]=0
	done

	for p in ${process_IDs[@]}
	do
		if [[ $((at[$p]-$clock)) -le 0 ]]
		then
			isWaiting[$p]=1
		fi
	done
}