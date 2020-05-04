#!/bin/bash

#############################################################################################
#                                                                                           #
# The user can jump to creating new processes or using a different algorithm.               #
# Authors: Anton Rösler (anton.roesler@stud.fra-uas.de)                                     #
#          Leonard Hußke (leonard.husske@stud.fra-uas.de)                                   #
#          Patrick Frech (patrick.frech@stud.fra-uas.de)                                    #
#                                                                                           #
# Copyright (c) 2020-2020 Anton Rösler, Leonard Hußke, Patrick Frech.  All Rights Reserved. #
#                                                                                           #
#############################################################################################

source ${processSchedulerWorkingDir}/common/selectOptions.sh

echo "WHAT SHOULD BE HERE?:"
echo

options=("Choose different algorithm" "Change processes" "Exit program")

select_option "${options[@]}"

choice=$?

if [[ $choice -eq 0 ]]
then
	continue

elif [[ $choice -eq 1 ]]
then
	break 1

elif [[ choice -eq 2 ]]
then
	isExit=1
	echo "Aborting program."
fi